"""Explainable clustering and routing over the pipe graph.

Rules live in config/rules.json. Every case stores the evidence that produced it.
"""

import json
from collections import defaultdict
from datetime import timedelta

from . import standards, wqi as wqi_mod
from .db import all_rows, demo_now, iso, latest_reading, load_config
from .graph import chain, load_parents, trace

RULES = load_config("rules.json")
CLUSTER = RULES["clustering"]

WATER_QUALITY_HINTS = ("smell", "taste", "colour", "color", "muddy", "brown",
                       "dirty", "cloudy", "contamination", "illness", "stomach")


def family_for(category, text):
    c = (category or "").lower()
    if "pressure" in c:
        return "pressure"
    if "other" in c:
        t = (text or "").lower()
        if any(w in t for w in WATER_QUALITY_HINTS):
            return "water_quality"
        if "pressure" in t or "supply" in t or "timing" in t:
            return "pressure"
        return "other"
    return "water_quality"


def _next_case_id(conn):
    nums = []
    for r in conn.execute("SELECT id FROM cases WHERE id LIKE 'CASE-2026-%'"):
        tail = r["id"].split("-")[-1]
        if tail.isdigit():
            nums.append(int(tail))
    return f"CASE-2026-{(max(nums) if nums else 0) + 1:03d}"


def _severity(conn, node_id, building_count):
    result = wqi_mod.evaluate(conn, node_id)
    severe = bool(result and any(b["severity"] in ("permissible", "micro") for b in result["breaches"]))
    if building_count >= 5 or severe:
        return "High"
    if building_count >= 3:
        return "Medium"
    return "Low"


def _evidence(conn, node_id, complaints, rule_text):
    result = wqi_mod.evaluate(conn, node_id)
    path = trace(conn, node_id)
    return {
        "complaint_ids": [c["id"] for c in complaints],
        "buildings": sorted({c["building_node_id"] for c in complaints}),
        "shared_node": node_id,
        "rule": rule_text,
        "wqi": result,
        "standards": standards.answer(result),
        "trace": path["path"],
        "synthetic": True,
    }


def _upsert_case(conn, node_id, scope, severity, title, rule_text, evidence, actor="Rule engine"):
    existing = conn.execute(
        "SELECT * FROM cases WHERE node_id=? AND scope=? AND status!='Resolved' "
        "ORDER BY created_at DESC LIMIT 1",
        (node_id, scope),
    ).fetchone()

    now = iso(demo_now(conn))
    if existing:
        merged = json.loads(existing["evidence_json"]) if existing["evidence_json"] else {}
        old_ids = set(merged.get("complaint_ids", []))
        new_ids = set(evidence["complaint_ids"])
        evidence["complaint_ids"] = sorted(old_ids | new_ids)
        conn.execute(
            "UPDATE cases SET updated_at=?, severity=?, evidence_json=?, rule_fired=? WHERE id=?",
            (now, severity, json.dumps(evidence), rule_text, existing["id"]),
        )
        conn.execute(
            "INSERT INTO case_actions (id, case_id, timestamp, actor, role, action, note) "
            "VALUES (?,?,?,?,?,?,?)",
            (f"ACT{_next_action(conn):04d}", existing["id"], now, actor, "System",
             "Cluster re-run", "Evidence refreshed with the latest complaint window."),
        )
        return "updated", existing["id"]

    cid = _next_case_id(conn)
    conn.execute(
        "INSERT INTO cases (id,node_id,scope,status,severity,title,created_at,updated_at,"
        "rule_fired,evidence_json) VALUES (?,?,?,?,?,?,?,?,?,?)",
        (cid, node_id, scope, "Open", severity, title, now, now, rule_text, json.dumps(evidence)),
    )
    conn.execute(
        "INSERT INTO case_actions (id, case_id, timestamp, actor, role, action, note) "
        "VALUES (?,?,?,?,?,?,?)",
        (f"ACT{_next_action(conn):04d}", cid, now, actor, "System", "Case opened", rule_text),
    )
    return "created", cid


def _next_action(conn):
    nums = []
    for r in conn.execute("SELECT id FROM case_actions WHERE id LIKE 'ACT%'"):
        tail = r["id"][3:]
        if tail.isdigit():
            nums.append(int(tail))
    return (max(nums) if nums else 0) + 1


def run(conn, window_hours=None, min_buildings=None):
    window = int(window_hours or CLUSTER["window_hours"])
    minimum = int(min_buildings or CLUSTER["min_buildings_for_municipal_case"])
    now = demo_now(conn)
    cutoff = iso(now - timedelta(hours=window))

    complaints = all_rows(
        conn,
        "SELECT * FROM complaints WHERE timestamp >= ? AND timestamp <= ? AND status != 'CLOSED' ORDER BY timestamp",
        (cutoff,iso(now)),
    )
    parents = load_parents(conn)
    node_types = {r["id"]: r["type"] for r in conn.execute("SELECT id, type FROM nodes")}
    meta = {r["id"]: r for r in all_rows(conn, "SELECT * FROM nodes")}

    groups = defaultdict(list)
    for c in complaints:
        groups[family_for(c["category"], c["text"])].append(c)

    created, updated, results = [], [], []
    handled = set()

    # --- MUNICIPAL: find the deepest node shared by >= N complaint buildings ---
    for fam, items in groups.items():
        if fam != "water_quality":
            continue
        building_ids = sorted({c["building_node_id"] for c in items})
        chains = {b: chain(parents, b) for b in building_ids}

        shared = defaultdict(set)
        for b, ch in chains.items():
            for anc in ch:
                shared[anc].add(b)

        best = None  # (distance_from_building, node, buildings)
        for anc, bset in shared.items():
            if len(bset) < minimum:
                continue
            dist = min(chains[b].index(anc) for b in bset if anc in chains[b])
            if best is None or dist < best[0] or (dist == best[0] and len(bset) > len(best[2])):
                best = (dist, anc, bset)

        if not best:
            continue

        _dist, node_id, bset = best
        cluster = [c for c in items if c["building_node_id"] in bset]
        if not cluster:
            continue
        rule_text = (
            f"{len(bset)} buildings share upstream node {node_id} "
            f"({meta[node_id]['name']}); threshold is {minimum}."
        )
        evidence = _evidence(conn, node_id, cluster, rule_text)
        title = f"Suspected contamination upstream of {meta[node_id]['name']}"
        state, cid = _upsert_case(
            conn, node_id, "MUNICIPAL", _severity(conn, node_id, len(bset)),
            title, rule_text, evidence,
        )
        (created if state == "created" else updated).append(cid)
        for c in cluster:
            conn.execute("UPDATE complaints SET status='CLUSTERED', suggested_category=? WHERE id=?",
                         ("water_quality", c["id"]))
            handled.add(c["id"])
        results.append({"case_id": cid, "state": state, "scope": "MUNICIPAL", "node": node_id})

    # --- BUILDING_SIDE: a single water-quality complaint with normal siblings ---
    per_building = defaultdict(list)
    for c in complaints:
        if c["id"] in handled:
            continue
        if family_for(c["category"], c["text"]) != "water_quality":
            continue
        per_building[c["building_node_id"]].append(c)

    for building, items in per_building.items():
        if node_types.get(building) != "building":
            continue
        zone_id = meta[building]["zone_id"]
        zone_read = latest_reading(conn, zone_id)
        zone_result = wqi_mod.evaluate(conn, zone_id)
        zone_ok = False
        if zone_read:
            zone_ok = (
                zone_read["turbidity_ntu"] <= CLUSTER["sibling_normal_tolerance"]["turbidity_ntu_max"]
                and zone_read["residual_chlorine_mgl"] >= CLUSTER["sibling_normal_tolerance"]["chlorine_mgl_min"]
            )
        siblings_complaining = [
            c for c in complaints
            if c["building_node_id"] != building
            and meta.get(c["building_node_id"], {}).get("zone_id") == zone_id
            and family_for(c["category"], c["text"]) == "water_quality"
        ]
        if not zone_ok or siblings_complaining:
            continue

        rule_text = (
            f"Only {meta[building]['name']} complains; the {meta[zone_id]['name']} sensor is normal "
            f"(turbidity {zone_read['turbidity_ntu']:.2f} NTU, chlorine "
            f"{zone_read['residual_chlorine_mgl']:.3f} mg/L) and no sibling building complains."
        )
        evidence = _evidence(conn, building, items, rule_text)
        evidence["checklist"] = ["Inspect and clean the overhead tank",
                                 "Check internal plumbing for cross-connection",
                                 "Replace or clean the building filter",
                                 "Re-sample after 24 hours"]
        evidence["zone_sensor"] = zone_result
        title = f"Building-side water quality complaint at {meta[building]['name']}"
        state, cid = _upsert_case(
            conn, building, "BUILDING_SIDE", "Low", title, rule_text, evidence,
            actor="Rule engine (building-side)",
        )
        (created if state == "created" else updated).append(cid)
        for c in items:
            conn.execute("UPDATE complaints SET status='CLUSTERED' WHERE id=?", (c["id"],))
            handled.add(c["id"])
        results.append({"case_id": cid, "state": state, "scope": "BUILDING_SIDE", "node": building})

    # --- UNDETERMINED: 2 complaints share a node but below the municipal threshold ---
    remaining = [c for c in complaints if c["id"] not in handled
                 and family_for(c["category"], c["text"]) == "water_quality"]
    if remaining:
        building_ids = sorted({c["building_node_id"] for c in remaining})
        chains = {b: chain(parents, b) for b in building_ids}
        shared = defaultdict(set)
        for b, ch in chains.items():
            for anc in ch:
                shared[anc].add(b)
        best = None
        for anc, bset in shared.items():
            if len(bset) < 2:
                continue
            dist = min(chains[b].index(anc) for b in bset)
            if best is None or dist < best[0]:
                best = (dist, anc, bset)
        if best:
            _d, node_id, bset = best
            cluster = [c for c in remaining if c["building_node_id"] in bset]
            rule_text = (f"{len(bset)} buildings share {node_id}, below the {minimum}-building "
                         "threshold. Routed for inspection, not asserted as a source.")
            evidence = _evidence(conn, node_id, cluster, rule_text)
            state, cid = _upsert_case(
                conn, node_id, "UNDETERMINED", "Low",
                f"Inspection requested near {meta[node_id]['name']}", rule_text, evidence,
            )
            (created if state == "created" else updated).append(cid)
            for c in cluster:
                conn.execute("UPDATE complaints SET status='CLUSTERED' WHERE id=?", (c["id"],))
            results.append({"case_id": cid, "state": state, "scope": "UNDETERMINED", "node": node_id})

    conn.commit()
    return {
        "window_hours": window,
        "min_buildings": minimum,
        "complaints_considered": len(complaints),
        "created": created,
        "updated": updated,
        "results": results,
    }
