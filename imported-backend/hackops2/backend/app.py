"""AquaTrace MVP API. Serves the JSON API and the static frontend from one process.

Run from the project root:
    python -m uvicorn backend.app:app --reload
"""

import json
from datetime import timedelta
from pathlib import Path

from fastapi import Depends, FastAPI, HTTPException
from fastapi.responses import FileResponse
from fastapi.staticfiles import StaticFiles
from pydantic import BaseModel

from . import forecast as fc
from . import rules
from . import standards as std
from . import wqi as wqi_mod
from .db import (all_rows, connect, demo_now, iso, latest_lab, latest_reading,
                 load_config, one)
from .graph import chain, load_parents, trace

BASE = Path(__file__).resolve().parent.parent
WEB = BASE / "web"

app = FastAPI(title="AquaTrace", version="0.1")


def db():
    conn = connect()
    try:
        yield conn
    finally:
        conn.close()


def _node(conn, node_id):
    row = one(conn, "SELECT * FROM nodes WHERE id=?", (node_id,))
    if not row:
        raise HTTPException(404, f"Unknown node {node_id}")
    return row


def _case(conn, case_id):
    row = one(conn, "SELECT * FROM cases WHERE id=?", (case_id,))
    if not row:
        raise HTTPException(404, f"Unknown case {case_id}")
    return row


def _evidence(case):
    try:
        return json.loads(case.get("evidence_json") or "{}")
    except json.JSONDecodeError:
        return {}


class ComplaintIn(BaseModel):
    building_node_id: str
    category: str
    text: str | None = None


class StatusIn(BaseModel):
    status: str
    actor: str = "Priya Nair"
    role: str = "Municipal Officer"
    note: str | None = None


class ActionIn(BaseModel):
    actor: str = "Priya Nair"
    role: str = "Municipal Officer"
    action: str
    note: str | None = None


class ClusterIn(BaseModel):
    window_hours: int | None = None
    min_buildings: int | None = None


class ApproveIn(BaseModel):
    actor: str = "Priya Nair"
    role: str = "Municipal Officer"


# --------------------------------------------------------------------------
# Read APIs
# --------------------------------------------------------------------------
@app.get("/api/meta")
def meta(conn=Depends(db)):
    now = demo_now(conn)
    return {
        "app": "AquaTrace",
        "event": "Infomatrix HackOps 2",
        "demo_now": iso(now),
        "synthetic": True,
        "banner": "Automated findings support human judgment. They are not official regulatory decisions.",
        "disclaimer": "All data is synthetic sample data for a fictional city.",
        "limits": load_config("limits.json"),
        "rules": load_config("rules.json"),
    }


@app.get("/api/network")
def network(conn=Depends(db)):
    nodes = all_rows(conn, "SELECT * FROM nodes")
    pipes = all_rows(conn, "SELECT * FROM pipes")
    for n in nodes:
        n["latest"] = latest_reading(conn, n["id"])
        n["wqi"] = wqi_mod.evaluate(conn, n["id"])
        n["forecast"] = fc.forecast(conn, n["id"]) if n["latest"] else None
    lats = [n["lat"] for n in nodes if n["lat"] is not None]
    lons = [n["lon"] for n in nodes if n["lon"] is not None]
    return {
        "now": iso(demo_now(conn)),
        "nodes": nodes,
        "pipes": pipes,
        "bounds": {
            "min_lat": min(lats), "max_lat": max(lats),
            "min_lon": min(lons), "max_lon": max(lons),
        },
    }


@app.get("/api/complaints")
def complaints(conn=Depends(db)):
    return all_rows(
        conn,
        """
        SELECT c.*, n.name AS building_name, n.zone_id AS zone_id,
               z.name AS zone_name
        FROM complaints c
        JOIN nodes n ON n.id = c.building_node_id
        LEFT JOIN nodes z ON z.id = n.zone_id
        ORDER BY c.timestamp DESC
        """,
    )


@app.post("/api/complaints")
def create_complaint(payload: ComplaintIn, conn=Depends(db)):
    building = _node(conn, payload.building_node_id)
    if building["type"] != "building":
        raise HTTPException(400, "Complaints must be filed against a building node")

    now = demo_now(conn)
    seq = conn.execute("SELECT COUNT(*) AS n FROM complaints").fetchone()["n"] + 1
    cid = f"CMP{seq:03d}"
    while one(conn, "SELECT id FROM complaints WHERE id=?", (cid,)):
        seq += 1
        cid = f"CMP{seq:03d}"

    conn.execute(
        "INSERT INTO complaints (id,timestamp,building_node_id,category,text,status,"
        "suggested_category,extracted_fields) VALUES (?,?,?,?,?,?,?,?)",
        (cid, iso(now), payload.building_node_id, payload.category, payload.text,
         "NEW", None, None),
    )
    conn.commit()

    zone_id = building["zone_id"]
    zone_result = wqi_mod.evaluate(conn, zone_id)
    zone_read = latest_reading(conn, zone_id)
    return {
        "complaint": one(conn, "SELECT * FROM complaints WHERE id=?", (cid,)),
        "area": {
            "zone_id": zone_id,
            "zone_name": one(conn, "SELECT name FROM nodes WHERE id=?", (zone_id,))["name"],
            "wqi": zone_result,
            "latest": zone_read,
        },
    }


@app.get("/api/cases")
def cases(conn=Depends(db)):
    rows = all_rows(
        conn,
        """
        SELECT c.*, n.name AS node_name, n.type AS node_type
        FROM cases c JOIN nodes n ON n.id = c.node_id
        ORDER BY CASE c.severity WHEN 'High' THEN 0 WHEN 'Medium' THEN 1 ELSE 2 END,
                 c.created_at DESC
        """,
    )
    for r in rows:
        ev = _evidence(r)
        r["complaint_count"] = len(ev.get("complaint_ids", []))
        r.pop("evidence_json", None)
    return rows


@app.get("/api/cases/{case_id}")
def case_detail(case_id: str, conn=Depends(db)):
    case = _case(conn, case_id)
    ev = _evidence(case)
    ids = ev.get("complaint_ids", [])
    complaints = []
    if ids:
        marks = ",".join("?" for _ in ids)
        complaints = all_rows(
            conn,
            f"""SELECT c.*, n.name AS building_name FROM complaints c
                JOIN nodes n ON n.id=c.building_node_id WHERE c.id IN ({marks})""",
            tuple(ids),
        )
    actions = all_rows(
        conn, "SELECT * FROM case_actions WHERE case_id=? ORDER BY timestamp, id", (case_id,)
    )
    node = _node(conn, case["node_id"])
    return {
        "case": case,
        "evidence": ev,
        "node": node,
        "complaints": complaints,
        "actions": actions,
        "trace": trace(conn, case["node_id"]),
        "standards": ev.get("standards") or std.answer(wqi_mod.evaluate(conn, case["node_id"])),
    }


@app.get("/api/nodes/{node_id}")
def node_detail(node_id: str, conn=Depends(db)):
    node = _node(conn, node_id)
    sensor = one(conn, "SELECT * FROM sensors WHERE node_id=?", (node_id,))
    history = []
    if sensor:
        history = all_rows(
            conn,
            "SELECT * FROM readings WHERE sensor_id=? ORDER BY timestamp DESC LIMIT 72",
            (sensor["id"],),
        )
        history.reverse()
    return {
        "node": node,
        "latest": latest_reading(conn, node_id),
        "wqi": wqi_mod.evaluate(conn, node_id),
        "lab": latest_lab(conn, node_id),
        "forecast": fc.forecast(conn, node_id),
        "anomaly": fc.anomaly(conn, node_id),
        "maintenance": all_rows(
            conn, "SELECT * FROM maintenance_checks WHERE node_id=? ORDER BY date DESC", (node_id,)
        ),
        "history": history,
    }


@app.get("/api/nodes/{node_id}/readings")
def node_readings(node_id: str, conn=Depends(db)):
    _node(conn, node_id)
    sensor = one(conn, "SELECT * FROM sensors WHERE node_id=?", (node_id,))
    if not sensor:
        return {"node_id": node_id, "readings": []}
    return {
        "node_id": node_id,
        "readings": all_rows(
            conn,
            "SELECT * FROM readings WHERE sensor_id=? ORDER BY timestamp ASC",
            (sensor["id"],),
        ),
    }


@app.get("/api/nodes/{node_id}/forecast")
def node_forecast(node_id: str, conn=Depends(db)):
    _node(conn, node_id)
    return fc.forecast(conn, node_id)


@app.get("/api/trace/{case_id}")
def case_trace(case_id: str, conn=Depends(db)):
    case = _case(conn, case_id)
    ev = _evidence(case)
    buildings = ev.get("buildings", [])
    parents = load_parents(conn)
    return {
        "case_id": case_id,
        "shared_node": case["node_id"],
        "trace": trace(conn, case["node_id"]),
        "building_chains": {b: chain(parents, b) for b in buildings},
        "explanation": ev.get("rule"),
    }


@app.get("/api/hotspots")
def hotspots(conn=Depends(db)):
    now = demo_now(conn)
    cutoff = iso(now - timedelta(hours=24))
    zones = all_rows(conn, "SELECT * FROM nodes WHERE type='zone'")
    out = []
    for z in zones:
        w = wqi_mod.evaluate(conn, z["id"]) or {}
        count = conn.execute(
            """SELECT COUNT(*) AS n FROM complaints c
               JOIN nodes b ON b.id=c.building_node_id
               WHERE b.zone_id=? AND c.timestamp >= ?""",
            (z["id"], cutoff),
        ).fetchone()["n"]
        f = fc.forecast(conn, z["id"])
        crosses = f.get("crossing_hours") is not None
        risk = (w.get("score") or 0) * 0.55 + count * 6 + (18 if crosses else 0)
        out.append({
            "zone_id": z["id"],
            "zone_name": z["name"],
            "wqi": w,
            "complaints_24h": count,
            "forecast_crossing_hours": f.get("crossing_hours"),
            "risk_score": round(risk, 1),
        })
    out.sort(key=lambda r: r["risk_score"], reverse=True)
    return out


@app.get("/api/standards/{node_id}")
def standards_for_node(node_id: str, conn=Depends(db)):
    _node(conn, node_id)
    return std.answer(wqi_mod.evaluate(conn, node_id))


@app.get("/api/health")
def health(conn=Depends(db)):
    counts = {
        t: conn.execute(f"SELECT COUNT(*) AS n FROM {t}").fetchone()["n"]
        for t in ("nodes", "pipes", "sensors", "readings", "complaints", "cases")
    }
    return {"status": "ok", "demo_now": iso(demo_now(conn)), "seed_counts": counts}


@app.get("/health")
def health_alias(conn=Depends(db)):
    return health(conn)


# --------------------------------------------------------------------------
# Write APIs
# --------------------------------------------------------------------------
@app.post("/api/cluster/run")
def cluster_run(payload: ClusterIn | None = None, conn=Depends(db)):
    payload = payload or ClusterIn()
    return rules.run(conn, payload.window_hours, payload.min_buildings)


@app.patch("/api/cases/{case_id}/status")
def update_status(case_id: str, payload: StatusIn, conn=Depends(db)):
    _case(conn, case_id)
    allowed = ["Open", "Investigating", "Action Taken", "Resolved"]
    if payload.status not in allowed:
        raise HTTPException(400, f"status must be one of {allowed}")
    now = iso(demo_now(conn))
    conn.execute("UPDATE cases SET status=?, updated_at=? WHERE id=?",
                 (payload.status, now, case_id))
    conn.execute(
        "INSERT INTO case_actions (id,case_id,timestamp,actor,role,action,note) "
        "VALUES (?,?,?,?,?,?,?)",
        (f"ACT{rules._next_action(conn):04d}", case_id, now, payload.actor, payload.role,
         f"Status -> {payload.status}", payload.note or ""),
    )
    conn.commit()
    return {"case": _case(conn, case_id)}


@app.post("/api/cases/{case_id}/actions")
def add_action(case_id: str, payload: ActionIn, conn=Depends(db)):
    _case(conn, case_id)
    now = iso(demo_now(conn))
    conn.execute(
        "INSERT INTO case_actions (id,case_id,timestamp,actor,role,action,note) "
        "VALUES (?,?,?,?,?,?,?)",
        (f"ACT{rules._next_action(conn):04d}", case_id, now, payload.actor, payload.role,
         payload.action, payload.note or ""),
    )
    conn.commit()
    return {"actions": all_rows(
        conn, "SELECT * FROM case_actions WHERE case_id=? ORDER BY timestamp, id", (case_id,))}


@app.post("/api/cases/{case_id}/draft")
def draft_advisory(case_id: str, conn=Depends(db)):
    case = _case(conn, case_id)
    ev = _evidence(case)
    node = _node(conn, case["node_id"])
    w = ev.get("wqi") or wqi_mod.evaluate(conn, case["node_id"]) or {}
    breaches = w.get("breaches", [])
    lines = [
        "PUBLIC ADVISORY - DRAFT (requires officer approval)",
        f"Area: {node['name']}",
        f"Case: {case_id} - {case['title']}",
        f"Assessment: Water Quality Index {w.get('score')} ({w.get('band')})",
        "Evidence:",
    ]
    if breaches:
        for b in breaches:
            lines.append(f"  - {b['label']}: {b['value']} {b.get('unit','')} "
                         f"(limit {b['limit']}) - {b['severity']} breach")
    else:
        lines.append("  - No parameter breach in the latest reading.")
    lines += [
        "Standard: IS 10500:2012 (verify against the official BIS document).",
        "Recommended action: flush and re-chlorinate the affected segment; re-sample within 24 hours; "
        "issue a boil-water notice for the affected buildings until two consecutive clean samples.",
        "This is a draft generated from rule-based findings. It is not an official regulatory decision.",
    ]
    text = "\n".join(lines)
    ev["advisory"] = {
        "text": text,
        "approved": False,
        "generated_at": iso(demo_now(conn)),
    }
    now = iso(demo_now(conn))
    conn.execute("UPDATE cases SET evidence_json=?, updated_at=? WHERE id=?",
                 (json.dumps(ev), now, case_id))
    conn.execute(
        "INSERT INTO case_actions (id,case_id,timestamp,actor,role,action,note) "
        "VALUES (?,?,?,?,?,?,?)",
        (f"ACT{rules._next_action(conn):04d}", case_id, now, "Rule engine", "System",
         "Draft advisory generated", "Draft requires officer approval before publishing."),
    )
    conn.commit()
    return ev["advisory"]


@app.post("/api/cases/{case_id}/approve")
def approve_advisory(case_id: str, payload: ApproveIn, conn=Depends(db)):
    case = _case(conn, case_id)
    ev = _evidence(case)
    advisory = ev.get("advisory")
    if not advisory:
        raise HTTPException(400, "Generate a draft first")
    advisory["approved"] = True
    advisory["approved_by"] = payload.actor
    advisory["approved_at"] = iso(demo_now(conn))
    ev["advisory"] = advisory
    now = iso(demo_now(conn))
    conn.execute("UPDATE cases SET evidence_json=?, updated_at=? WHERE id=?",
                 (json.dumps(ev), now, case_id))
    conn.execute(
        "INSERT INTO case_actions (id,case_id,timestamp,actor,role,action,note) "
        "VALUES (?,?,?,?,?,?,?)",
        (f"ACT{rules._next_action(conn):04d}", case_id, now, payload.actor, payload.role,
         "Advisory approved and published", "Officer approval recorded."),
    )
    conn.commit()
    return advisory


# --------------------------------------------------------------------------
# Static frontend (one process, no CORS)
# --------------------------------------------------------------------------
if WEB.is_dir():
    app.mount("/static", StaticFiles(directory=str(WEB)), name="static")


@app.get("/")
def index():
    return FileResponse(WEB / "index.html")
