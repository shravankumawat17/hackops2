"""
AquaTrace Environmental Intelligence & Water Quality Fault Localization System
FastAPI Backend Server
"""

import os
import json
import uuid
import datetime
from typing import Dict, Any, List, Optional
from fastapi import FastAPI, HTTPException, Query, status
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel, Field

from database import get_connection
from localization import localize_fault, SYMPTOM_MAP
from analysis import detect_anomalies, calculate_wqi, simulate_chlorine_decay

app = FastAPI(
    title="AquaTrace API",
    description="Environmental Intelligence & Water Quality Fault Localization System for Mumbai Municipal Supply Chain",
    version="1.0.0"
)

# Enable CORS for frontend
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

MANDATORY_BANNER = "Automated findings support human judgment. They are not official regulatory decisions."

# --- Pydantic Request Models ---
class ComplaintCreate(BaseModel):
    household_node_id: str = Field(..., example="node_hh_shreeji_301")
    symptom: str = Field(..., example="brown_discolored")
    taps_affected: Optional[str] = Field("all", example="all")
    since: Optional[str] = Field("this morning", example="this morning")
    neighbors_affected: Optional[int] = Field(0, example=0)
    illness_reported: Optional[int] = Field(0, example=0)
    text: Optional[str] = Field("", example="Water from tap is muddy brown.")

class CaseStatusUpdate(BaseModel):
    status: str = Field(..., example="in progress")  # 'reported', 'located', 'assigned', 'in progress', 'resolved'
    actor: str = Field("BMC Water Works Officer", example="BMC Water Works Officer")
    note: str = Field(..., example="Inspection crew dispatched.")

class CaseActionCreate(BaseModel):
    action: str = Field(..., example="Valve Inspection")
    actor: str = Field(..., example="BMC Field Tech")
    note: str = Field(..., example="Inspected isolating valve; found sediment buildup.")

# --- Endpoints ---

@app.get("/")
def root():
    return {
        "service": "AquaTrace Environmental Intelligence API",
        "status": "online",
        "disclaimer": MANDATORY_BANNER,
        "standards_reference": "IS 10500:2012 Drinking Water Specification"
    }

@app.get("/api/health")
def health():
    return {
        "status": "HEALTHY",
        "timestamp": datetime.datetime.now().isoformat(),
        "disclaimer": MANDATORY_BANNER
    }

@app.get("/api/graph")
def get_graph():
    """
    Returns full dependency network (nodes and edges) formatted for XYFlow / interactive graph.
    Includes live WQI, status badge, coordinates, and latest telemetry readings.
    """
    with get_connection() as conn:
        cursor = conn.cursor()
        
        # 1. Fetch all nodes
        cursor.execute("SELECT id, type, name, location, parent, status FROM nodes;")
        raw_nodes = cursor.fetchall()
        
        # 2. Fetch latest readings for each sensor
        cursor.execute("""
        SELECT s.node_id, r.pH, r.turbidity_NTU, r.TDS_mgL, r.residual_chlorine_mgL, r.timestamp
        FROM readings r
        JOIN sensors s ON r.sensor_id = s.id
        WHERE r.id IN (
            SELECT MAX(id) FROM readings GROUP BY sensor_id
        );
        """)
        readings_map = {r["node_id"]: dict(r) for r in cursor.fetchall()}
        
        # 3. Fetch complaint counts grouped by node
        cursor.execute("""
        SELECT household_node_id, COUNT(*) as cnt 
        FROM complaints 
        WHERE status != 'resolved' 
        GROUP BY household_node_id;
        """)
        complaint_counts = {r["household_node_id"]: r["cnt"] for r in cursor.fetchall()}
        
        # 4. Fetch pipes for edge details
        cursor.execute("SELECT id, from_node, to_node, length_m, diameter_mm, material FROM pipes;")
        pipes = cursor.fetchall()
        
    # Tree hierarchy positioning for XYFlow
    level_map = {
        "source": 0,
        "plant": 1,
        "reservoir": 2,
        "zone": 3,
        "street_segment": 4,
        "building_tank": 5,
        "household": 6
    }
    
    nodes_by_level: Dict[int, List[Dict[str, Any]]] = {}
    for n in raw_nodes:
        lvl = level_map.get(n["type"], 3)
        nodes_by_level.setdefault(lvl, []).append(dict(n))
        
    flow_nodes = []
    y_spacing = 150
    x_spacing = 270
    
    for lvl, level_nodes in nodes_by_level.items():
        total_in_level = len(level_nodes)
        for idx, node in enumerate(level_nodes):
            reading = readings_map.get(node["id"])
            wqi_info = calculate_wqi(reading) if reading else {"wqi": 95, "grade": "GOOD", "color": "#10b981"}
            
            x_offset = (idx - (total_in_level - 1) / 2.0) * x_spacing + 500
            y_offset = lvl * y_spacing + 50
            
            c_count = complaint_counts.get(node["id"], 0)
            
            flow_nodes.append({
                "id": node["id"],
                "type": "waterNode",
                "position": {"x": x_offset, "y": y_offset},
                "data": {
                    "label": node["name"],
                    "nodeType": node["type"],
                    "location": node["location"],
                    "parent": node["parent"],
                    "status": node["status"],
                    "wqi": wqi_info["wqi"],
                    "wqiGrade": wqi_info["grade"],
                    "wqiColor": wqi_info["color"],
                    "activeComplaints": c_count,
                    "readings": reading or None
                }
            })
            
    # Edges
    flow_edges = []
    seen_edges = set()
    
    for p in pipes:
        edge_key = f"{p['from_node']}->{p['to_node']}"
        seen_edges.add(edge_key)
        flow_edges.append({
            "id": p["id"],
            "source": p["from_node"],
            "target": p["to_node"],
            "label": f"{p['length_m']}m ({p['material']})",
            "animated": True,
            "style": {"stroke": "#94a3b8", "strokeWidth": 2}
        })
        
    for n in raw_nodes:
        if n["parent"]:
            edge_key = f"{n['parent']}->{n['id']}"
            if edge_key not in seen_edges:
                seen_edges.add(edge_key)
                flow_edges.append({
                    "id": f"edge_{n['parent']}_{n['id']}",
                    "source": n["parent"],
                    "target": n["id"],
                    "animated": False,
                    "style": {"stroke": "#cbd5e1", "strokeDasharray": "4 4"}
                })
                
    return {
        "disclaimer": MANDATORY_BANNER,
        "nodes": flow_nodes,
        "edges": flow_edges,
        "total_nodes": len(flow_nodes),
        "total_edges": len(flow_edges)
    }

@app.post("/api/complaints")
def submit_complaint(complaint_in: ComplaintCreate):
    """
    Intake citizen complaint -> runs top-down graph fault localization ->
    auto-links or creates case -> returns full diagnostic packet with standard citations & plumber routing.
    """
    with get_connection() as conn:
        cursor = conn.cursor()
        
        # Verify household node exists
        cursor.execute("SELECT id, name, location, parent FROM nodes WHERE id = ?;", (complaint_in.household_node_id,))
        node_row = cursor.fetchone()
        if not node_row:
            raise HTTPException(status_code=404, detail=f"Household node '{complaint_in.household_node_id}' not found.")
            
        complaint_id = f"c_{uuid.uuid4().hex[:8]}"
        now_str = datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S")
        
        # 1. Execute Fault Localization Engine
        diagnosis = localize_fault(
            household_node_id=complaint_in.household_node_id,
            symptom=complaint_in.symptom,
            taps_affected=complaint_in.taps_affected or "all",
            neighbors_affected=bool(complaint_in.neighbors_affected),
            illness_reported=bool(complaint_in.illness_reported),
            text=complaint_in.text or ""
        )
        
        fault_stage = diagnosis["fault_stage"]
        fault_node_id = diagnosis["fault_node"]["id"]
        routed_to = diagnosis["routed_to"]
        
        # 2. Check if an active open case already exists for this fault node/stage
        cursor.execute("""
        SELECT case_id, timeline, actions FROM cases 
        WHERE located_node = ? AND fault_stage = ? AND status NOT IN ('resolved', 'closed');
        """, (fault_node_id, fault_stage))
        existing_case = cursor.fetchone()
        
        if existing_case:
            case_id = existing_case["case_id"]
            timeline = json.loads(existing_case["timeline"]) if existing_case["timeline"] else []
            timeline.append({
                "timestamp": now_str,
                "actor": "Citizen (AquaTrace Intake)",
                "note": f"Additional complaint {complaint_id} attached for {node_row['name']} ({complaint_in.symptom})."
            })
            cursor.execute("""
            UPDATE cases SET timeline = ?, updated_at = ? WHERE case_id = ?;
            """, (json.dumps(timeline), now_str, case_id))
        else:
            case_id = f"case_{fault_stage.replace('/', '_').replace(' ', '_')}_{uuid.uuid4().hex[:6]}"
            init_timeline = [{
                "timestamp": now_str,
                "actor": "AquaTrace Localization Engine",
                "note": f"Case created. Fault localized to {fault_stage} ({diagnosis['fault_node']['name']}). Confidence: {diagnosis['confidence']}."
            }]
            init_actions = [f"Route assigned to: {routed_to}"]
            
            cursor.execute("""
            INSERT INTO cases (
                case_id, household_node, symptom, taps_affected, since,
                neighbors_affected, illness_reported, located_node, fault_stage,
                confidence, evidence, standard_cited, threshold_check,
                routed_to, status, actions, timeline, created_at, updated_at
            ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, 'assigned', ?, ?, ?, ?);
            """, (
                case_id,
                complaint_in.household_node_id,
                complaint_in.symptom,
                complaint_in.taps_affected,
                complaint_in.since,
                complaint_in.neighbors_affected,
                complaint_in.illness_reported,
                fault_node_id,
                fault_stage,
                diagnosis["confidence"],
                json.dumps(diagnosis["evidence_trail"]),
                json.dumps(diagnosis["standard_citation"]),
                json.dumps(diagnosis["threshold_check"]),
                routed_to,
                json.dumps(init_actions),
                json.dumps(init_timeline),
                now_str,
                now_str
            ))
            
        # 3. Store complaint record
        cursor.execute("""
        INSERT INTO complaints (
            id, timestamp, household_node_id, symptom, taps_affected,
            since, neighbors_affected, illness_reported, text, status
        ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, 'reported');
        """, (
            complaint_id,
            now_str,
            complaint_in.household_node_id,
            complaint_in.symptom,
            complaint_in.taps_affected,
            complaint_in.since,
            complaint_in.neighbors_affected,
            complaint_in.illness_reported,
            complaint_in.text
        ))
        
        conn.commit()
        
    return {
        "complaint_id": complaint_id,
        "case_id": case_id,
        "household_node": dict(node_row),
        "diagnosis": diagnosis,
        "disclaimer": MANDATORY_BANNER
    }

@app.get("/api/complaints")
def list_complaints():
    """Returns all citizen complaints joined with node info."""
    with get_connection() as conn:
        cursor = conn.cursor()
        cursor.execute("""
        SELECT c.*, n.name as node_name, n.location as node_location
        FROM complaints c
        LEFT JOIN nodes n ON c.household_node_id = n.id
        ORDER BY c.timestamp DESC;
        """)
        rows = [dict(r) for r in cursor.fetchall()]
        
    return {
        "disclaimer": MANDATORY_BANNER,
        "total": len(rows),
        "complaints": rows
    }

@app.get("/api/cases")
def list_cases():
    """Returns all cases with parsed JSON evidence and node locations."""
    with get_connection() as conn:
        cursor = conn.cursor()
        cursor.execute("""
        SELECT c.*, n.name as fault_node_name, n.location as fault_node_location
        FROM cases c
        LEFT JOIN nodes n ON c.located_node = n.id
        ORDER BY c.updated_at DESC;
        """)
        raw_cases = cursor.fetchall()
        
        cases = []
        for r in raw_cases:
            cdict = dict(r)
            cdict["evidence"] = json.loads(cdict["evidence"]) if cdict.get("evidence") else []
            cdict["standard_cited"] = json.loads(cdict["standard_cited"]) if cdict.get("standard_cited") else {}
            cdict["threshold_check"] = json.loads(cdict["threshold_check"]) if cdict.get("threshold_check") else {}
            cdict["actions"] = json.loads(cdict["actions"]) if cdict.get("actions") else []
            cdict["timeline"] = json.loads(cdict["timeline"]) if cdict.get("timeline") else []
            cases.append(cdict)
            
    return {
        "disclaimer": MANDATORY_BANNER,
        "total": len(cases),
        "cases": cases
    }

@app.get("/api/cases/{case_id}")
def get_case(case_id: str):
    """Returns single case with full timeline, attached complaints, and standards cited."""
    with get_connection() as conn:
        cursor = conn.cursor()
        cursor.execute("""
        SELECT c.*, n.name as fault_node_name, n.type as fault_node_type, n.location as fault_node_location
        FROM cases c
        LEFT JOIN nodes n ON c.located_node = n.id
        WHERE c.case_id = ?;
        """, (case_id,))
        case_row = cursor.fetchone()
        if not case_row:
            raise HTTPException(status_code=404, detail=f"Case '{case_id}' not found.")
            
        case = dict(case_row)
        case["evidence"] = json.loads(case["evidence"]) if case.get("evidence") else []
        case["standard_cited"] = json.loads(case["standard_cited"]) if case.get("standard_cited") else {}
        case["threshold_check"] = json.loads(case["threshold_check"]) if case.get("threshold_check") else {}
        case["actions"] = json.loads(case["actions"]) if case.get("actions") else []
        case["timeline"] = json.loads(case["timeline"]) if case.get("timeline") else []
        
        # Anomaly status on fault node
        anomaly_info = detect_anomalies(case["located_node"])
        
    return {
        "disclaimer": MANDATORY_BANNER,
        "case": case,
        "telemetry_anomalies": anomaly_info
    }

@app.patch("/api/cases/{case_id}/status")
def update_case_status(case_id: str, update_in: CaseStatusUpdate):
    """Updates status of a case and logs a timestamped action entry."""
    with get_connection() as conn:
        cursor = conn.cursor()
        cursor.execute("SELECT case_id, status, timeline FROM cases WHERE case_id = ?;", (case_id,))
        row = cursor.fetchone()
        if not row:
            raise HTTPException(status_code=404, detail="Case not found.")
            
        now = datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S")
        timeline = json.loads(row["timeline"]) if row["timeline"] else []
        timeline.append({
            "timestamp": now,
            "actor": update_in.actor,
            "note": f"Status changed from '{row['status']}' to '{update_in.status}'. Note: {update_in.note}"
        })
        
        cursor.execute("""
        UPDATE cases SET status = ?, timeline = ?, updated_at = ? WHERE case_id = ?;
        """, (update_in.status, json.dumps(timeline), now, case_id))
        
        conn.commit()
        
    return {"case_id": case_id, "new_status": update_in.status, "updated_at": now}

@app.post("/api/cases/{case_id}/actions")
def log_case_action(case_id: str, action_in: CaseActionCreate):
    """Logs an explicit maintenance action (e.g. valve test, crew dispatch, water test)."""
    with get_connection() as conn:
        cursor = conn.cursor()
        cursor.execute("SELECT case_id, actions, timeline FROM cases WHERE case_id = ?;", (case_id,))
        row = cursor.fetchone()
        if not row:
            raise HTTPException(status_code=404, detail="Case not found.")
            
        now = datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S")
        actions = json.loads(row["actions"]) if row["actions"] else []
        actions.append(f"[{now}] {action_in.action} by {action_in.actor}: {action_in.note}")
        
        timeline = json.loads(row["timeline"]) if row["timeline"] else []
        timeline.append({
            "timestamp": now,
            "actor": action_in.actor,
            "note": f"Action logged: {action_in.action} - {action_in.note}"
        })
        
        cursor.execute("""
        UPDATE cases SET actions = ?, timeline = ?, updated_at = ? WHERE case_id = ?;
        """, (json.dumps(actions), json.dumps(timeline), now, case_id))
        conn.commit()
        
    return {"case_id": case_id, "status": "ACTION_LOGGED", "timestamp": now}

@app.get("/api/nodes/{node_id}/readings")
def get_node_readings(node_id: str, limit: int = 48):
    """Returns time-series telemetry data for a specific node for charts."""
    with get_connection() as conn:
        cursor = conn.cursor()
        cursor.execute("""
        SELECT r.pH, r.turbidity_NTU, r.TDS_mgL, r.residual_chlorine_mgL, r.timestamp
        FROM readings r
        JOIN sensors s ON r.sensor_id = s.id
        WHERE s.node_id = ?
        ORDER BY r.timestamp DESC
        LIMIT ?;
        """, (node_id, limit))
        rows = [dict(r) for r in cursor.fetchall()]
        
    return {
        "disclaimer": MANDATORY_BANNER,
        "node_id": node_id,
        "count": len(rows),
        "readings": list(reversed(rows))
    }

@app.get("/api/nodes/{node_id}/anomaly")
def get_node_anomaly(node_id: str):
    """Computes real-time Z-score anomalies and regulatory breaches for a node."""
    return detect_anomalies(node_id)

@app.get("/api/decay-simulation")
def get_decay_simulation(plant_id: str = "plant_bhandup", initial_chlorine: float = 1.8):
    """Simulates 24h residual chlorine decay kinetics along the Mumbai municipal network."""
    trail = simulate_chlorine_decay(start_node_id=plant_id, initial_chlorine=initial_chlorine)
    return {
        "disclaimer": MANDATORY_BANNER,
        "decay_model": "First-Order Kinetic Decay: C(t) = C0 * exp(-k * t)",
        "bulk_wall_decay_constant_per_hour": 0.048,
        "initial_chlorine_mgL": initial_chlorine,
        "simulation_nodes": trail
    }

@app.get("/api/plumbers")
def list_plumbers():
    """Returns verified local licensed plumbers."""
    with get_connection() as conn:
        cursor = conn.cursor()
        cursor.execute("SELECT * FROM plumbers ORDER BY rating DESC;")
        plumbers = [dict(r) for r in cursor.fetchall()]
        
    return {
        "disclaimer": MANDATORY_BANNER,
        "plumbers": plumbers
    }

@app.get("/api/standards")
def list_standards():
    """Returns IS 10500:2012 Drinking Water Specification regulatory clauses."""
    with get_connection() as conn:
        cursor = conn.cursor()
        cursor.execute("SELECT * FROM standards_clauses;")
        standards = [dict(r) for r in cursor.fetchall()]
        
    return {
        "disclaimer": MANDATORY_BANNER,
        "standards": standards
    }

@app.post("/api/cases/{case_id}/draft")
def generate_public_advisory(case_id: str):
    """
    Auto-generates a public advisory draft with standard citation and human-readable explanation.
    """
    with get_connection() as conn:
        cursor = conn.cursor()
        cursor.execute("""
        SELECT c.*, n.name as node_name, n.location as node_location
        FROM cases c
        LEFT JOIN nodes n ON c.located_node = n.id
        WHERE c.case_id = ?;
        """, (case_id,))
        case = cursor.fetchone()
        if not case:
            raise HTTPException(status_code=404, detail="Case not found.")
            
        cursor.execute("SELECT COUNT(*) as cnt FROM complaints WHERE household_node_id = ?;", (case["household_node"],))
        complaint_count = cursor.fetchone()["cnt"]
        
    stage = case["fault_stage"]
    node_name = case["node_name"]
    location = case["node_location"]
    
    if stage == "plant/source":
        headline = f"MUNICIPAL WATER TREATMENT ADVISORY - {node_name.upper()}"
        recommendation = "Boil all tap water for minimum 3 minutes before domestic consumption. Plant operators currently optimizing coagulant dosage and backwashing filtration units."
    elif stage == "distribution_pipeline":
        headline = f"BMC WATER WORKS INFRASTRUCTURE NOTICE - {node_name.upper()}"
        recommendation = f"Maintenance crew mobilized for valve inspection and pipe integrity test along {location}. Avoid drawing water directly for drinking until line flush is verified."
    elif stage == "building_tank / internal mains":
        headline = f"HOUSING SOCIETY MAINTENANCE NOTICE - {node_name.upper()}"
        recommendation = "Underground and overhead water storage tanks require immediate sediment purging and hyper-chlorination. Resident committee notified."
    else:
        headline = f"RESIDENTIAL PLUMBING ADVISORY - {node_name.upper()}"
        recommendation = "Inspection indicates localized internal household plumbing fault. Contact verified licensed plumbers for internal line inspection and filter check."

    draft = f"""{headline}
Location: {location}
Date: {datetime.datetime.now().strftime("%d %B %Y")}
Case Reference: {case['case_id']}
Active Citizen Reports: {complaint_count}

SUMMARY:
AquaTrace diagnostic localized a suspected water quality concern at the {stage.upper()} level ({node_name}).

APPLICABLE STANDARD:
Evaluated against Bureau of Indian Standards IS 10500:2012 (Drinking Water Specification).

REQUIRED ACTION:
{recommendation}

NOTICE:
{MANDATORY_BANNER}"""

    return {
        "case_id": case_id,
        "headline": headline,
        "advisory_text": draft,
        "disclaimer": MANDATORY_BANNER
    }

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="127.0.0.1", port=8000)
