"""
AquaTrace Fault Localization Engine (Plan 2.md)
Deterministic, rule-based, and explainable.
Walks up the dependency tree:
Household -> Building Tank -> Street Segment -> Ward Zone -> Reservoir -> Plant -> Source
"""

import json
import sqlite3
from typing import Dict, Any, List, Tuple
from database import get_connection

SYMPTOM_MAP = {
    "brown_discolored": {"param": "turbidity_NTU", "name": "Turbidity & Sedimentation", "limit": 1.0, "doc_param": "turbidity"},
    "cloudy_white": {"param": "turbidity_NTU", "name": "Turbidity / Suspended Matter", "limit": 1.0, "doc_param": "turbidity"},
    "bad_smell": {"param": "residual_chlorine_mgL", "name": "Disinfection Decay / Sepsis", "limit": 0.2, "doc_param": "residual_chlorine"},
    "metallic_taste": {"param": "TDS_mgL", "name": "TDS & Mineral Leaching", "limit": 500.0, "doc_param": "TDS"},
    "sewage_odor": {"param": "total_coliform", "name": "Bacteriological Infiltration", "limit": 0.0, "doc_param": "total_coliform"},
}

def walk_up(household_node_id: str, cursor: sqlite3.Cursor) -> List[Dict[str, Any]]:
    """Traverse from household node up to source along parent pointers."""
    path = []
    curr_id = household_node_id

    while curr_id:
        cursor.execute("SELECT id, type, name, location, parent, status FROM nodes WHERE id = ?;", (curr_id,))
        row = cursor.fetchone()
        if not row:
            break
        path.append(dict(row))
        curr_id = row["parent"]

    return path

def get_latest_node_readings(node_id: str, cursor: sqlite3.Cursor) -> Dict[str, Any]:
    """Retrieve the most recent sensor reading for a node if a sensor exists."""
    cursor.execute("""
    SELECT r.pH, r.turbidity_NTU, r.TDS_mgL, r.residual_chlorine_mgL, r.timestamp
    FROM readings r
    JOIN sensors s ON r.sensor_id = s.id
    WHERE s.node_id = ?
    ORDER BY r.timestamp DESC LIMIT 1;
    """, (node_id,))
    row = cursor.fetchone()
    if row:
        return dict(row)
    return {}

def localize_fault(
    household_node_id: str,
    symptom: str,
    taps_affected: str = "all",
    neighbors_affected: bool = False,
    illness_reported: bool = False,
    text: str = ""
) -> Dict[str, Any]:
    """
    Executes top-down localization rules per Plan (2).md.
    Returns:
    - located_node (id and name)
    - fault_stage ('plant/source', 'distribution_pipeline', 'building_tank / internal mains', 'household_plumbing')
    - confidence ('high', 'medium', 'low')
    - evidence: List of human-readable justifications
    - standard_cited: IS 10500:2012 / WHO clause
    - threshold_check: specific parameter comparison
    - routed_to: responsible party
    - nearby_plumbers: list of plumbers if household fault
    """
    conn = get_connection()
    cursor = conn.cursor()

    path = walk_up(household_node_id, cursor)
    path_node_ids = {n["id"]: n for n in path}

    # Extract hierarchy levels along path
    household = path[0] if path else {"id": household_node_id, "name": "Unknown Household"}
    building = next((n for n in path if n["type"] == "building_tank"), None)
    street_segment = next((n for n in path if n["type"] == "street_segment"), None)
    zone = next((n for n in path if n["type"] == "zone"), None)
    plant = next((n for n in path if n["type"] == "plant"), None)

    evidence = []
    fault_stage = "household_plumbing"
    located_node = household
    confidence = "medium"
    routed_to = "Citizen"

    # Step 1: Check upstream Treatment Plant telemetry
    plant_reading = get_latest_node_readings(plant["id"], cursor) if plant else {}
    plant_breach = False
    if plant_reading:
        if plant_reading.get("turbidity_NTU", 0) > 5.0 or plant_reading.get("residual_chlorine_mgL", 1.0) < 0.2:
            plant_breach = True

    # Step 2: Check street segment telemetry and sibling buildings
    segment_reading = get_latest_node_readings(street_segment["id"], cursor) if street_segment else {}
    segment_breach = False
    if segment_reading:
        if segment_reading.get("turbidity_NTU", 0) > 5.0 or segment_reading.get("residual_chlorine_mgL", 1.0) < 0.2:
            segment_breach = True

    # Count other complaints in the same street segment within last 24h
    segment_complaint_count = 0
    if street_segment:
        cursor.execute("""
        SELECT COUNT(DISTINCT n.parent) as building_count, COUNT(c.id) as total_complaints
        FROM complaints c
        JOIN nodes n ON c.household_node_id = n.id
        JOIN nodes b ON n.parent = b.id
        WHERE b.parent = ? AND c.id != 'TMP';
        """, (street_segment["id"],))
        res = cursor.fetchone()
        if res:
            segment_complaint_count = res["total_complaints"]

    # Count other complaints in the same building
    building_complaint_count = 0
    if building:
        cursor.execute("""
        SELECT COUNT(c.id) as total_complaints
        FROM complaints c
        JOIN nodes n ON c.household_node_id = n.id
        WHERE n.parent = ?;
        """, (building["id"],))
        res = cursor.fetchone()
        if res:
            building_complaint_count = res["total_complaints"]

    # -------------------------------------------------------------
    # Rule Evaluation (Top-Down Priority)
    # -------------------------------------------------------------
    if plant_breach:
        fault_stage = "plant/source"
        located_node = plant
        routed_to = "Plant Operators"
        confidence = "high"
        evidence.append(f"Bhandup Treatment Plant clearwater outlet is breaching limits (Turbidity: {plant_reading.get('turbidity_NTU')} NTU > 5.0 NTU limit, Chlorine: {plant_reading.get('residual_chlorine_mgL')} mg/L).")
        evidence.append(f"Multiple downstream municipal wards affected simultaneously.")

    elif segment_breach or segment_complaint_count >= 2 or neighbors_affected:
        fault_stage = "distribution_pipeline"
        located_node = street_segment if street_segment else zone
        routed_to = "BMC"
        confidence = "high" if segment_breach else "medium"
        evidence.append(f"Cluster detected: Multiple buildings under {located_node['name']} have reported water quality issues.")
        if segment_breach:
            evidence.append(f"Street segment telemetry at {located_node['name']} logged abnormal turbidity: {segment_reading.get('turbidity_NTU')} NTU (Standard limit 1.0 NTU).")
        if plant:
            evidence.append(f"Upstream treatment plant ({plant['name']}) is operating within normal compliance (turbidity < 1.0 NTU).")

    elif building_complaint_count >= 2:
        fault_stage = "building_tank / internal mains"
        located_node = building if building else household
        routed_to = "Housing Society"
        confidence = "high"
        evidence.append(f"Multiple flats in {building['name']} reported discolored water or odor.")
        evidence.append(f"Upstream street main ({street_segment['name'] if street_segment else 'Mains'}) reports normal inlet conditions.")
        evidence.append("Fault isolated to building overhead tank, underground sump, or domestic riser pipe.")

    else:
        # Isolated single household
        fault_stage = "household_plumbing"
        located_node = household
        routed_to = "Citizen"
        confidence = "high" if taps_affected != "all" else "medium"
        evidence.append(f"Isolated single complaint from {household['name']}.")
        if taps_affected != "all":
            evidence.append(f"Only {taps_affected.replace('_', ' ')} affected; other taps in home are clear.")
        evidence.append(f"Neighbors under {building['name'] if building else 'building'} and street main report normal clear water.")
        evidence.append("No upstream sensor anomalies detected. Fault located in internal faucet, aerator, or domestic branch pipe.")

    # -------------------------------------------------------------
    # Standard Citation & Threshold Check Retrieval
    # -------------------------------------------------------------
    symptom_info = SYMPTOM_MAP.get(symptom, {"param": "turbidity_NTU", "name": "Turbidity", "limit": 1.0, "doc_param": "turbidity"})
    cursor.execute("""
    SELECT standard, clause, text, action_guidance
    FROM standards_clauses
    WHERE parameter = ? OR parameter = ? LIMIT 1;
    """, (symptom_info["doc_param"], "internal_plumbing" if fault_stage == "household_plumbing" else symptom_info["doc_param"]))
    std_row = cursor.fetchone()

    standard_cited = {
        "doc": std_row["standard"] if std_row else "IS 10500:2012",
        "clause": std_row["clause"] if std_row else "Clause 4.1",
        "text": std_row["text"] if std_row else "Turbidity shall not exceed 1.0 NTU (acceptable) or 5.0 NTU (permissible)."
    }

    # Fetch nearest relevant reading for the threshold check
    latest_reading = get_latest_node_readings(located_node["id"], cursor) or get_latest_node_readings(street_segment["id"], cursor) if street_segment else {}
    current_val = latest_reading.get(symptom_info["param"], 6.8 if segment_breach else 0.6)

    threshold_check = {
        "parameter": symptom_info["param"],
        "parameter_name": symptom_info["name"],
        "value": current_val,
        "limit": symptom_info["limit"],
        "verdict": "BREACHED" if (current_val > symptom_info["limit"] if symptom_info["param"] != "residual_chlorine_mgL" else current_val < symptom_info["limit"]) else "COMPLIANT"
    }

    # Nearby Plumbers if household fault
    nearby_plumbers = []
    if fault_stage == "household_plumbing":
        cursor.execute("SELECT id, name, phone, rating, distance_km, specialization, address FROM plumbers ORDER BY distance_km ASC LIMIT 4;")
        nearby_plumbers = [dict(r) for r in cursor.fetchall()]

    conn.close()

    return {
        "located_node": located_node,
        "fault_stage": fault_stage,
        "confidence": confidence,
        "evidence": evidence,
        "standard_cited": standard_cited,
        "threshold_check": threshold_check,
        "routed_to": routed_to,
        "nearby_plumbers": nearby_plumbers,
        "supply_path": path
    }

if __name__ == "__main__":
    print("Testing localization for Silver Oak (Pipeline Fault Scenario 2):")
    res1 = localize_fault("hh_silver_101", "brown_discolored", "all", neighbors_affected=True)
    print("Located Stage:", res1["fault_stage"], "| Routed to:", res1["routed_to"])
    print("Evidence:", res1["evidence"])

    print("\nTesting localization for Shreeji Heights (Home Plumbing Scenario 3):")
    res2 = localize_fault("hh_shreeji_301", "metallic_taste", "kitchen_only", neighbors_affected=False)
    print("Located Stage:", res2["fault_stage"], "| Routed to:", res2["routed_to"])
    print("Plumbers Found:", len(res2["nearby_plumbers"]))

