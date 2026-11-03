"""
AquaTrace Environmental Intelligence - Statistical Analysis & Water Quality Physics Engine
Includes:
1. Rolling Z-Score Anomaly Detection (|z| > 2.5) on sensor time-series.
2. Chlorine Residual Decay Kinetics (First-order decay C(t) = C0 * exp(-k*t)).
3. Water Quality Index (WQI) calculation (0-100 scale).
"""

import math
import sqlite3
from typing import Dict, Any, List, Optional
from database import get_connection

# IS 10500:2012 Thresholds for Quick Anomaly & Compliance Checks
PARAM_THRESHOLDS = {
    "pH": {"min": 6.5, "max": 8.5, "unit": "pH", "weight": 0.2},
    "turbidity_NTU": {"min": 0.0, "max": 1.0, "extreme_max": 5.0, "unit": "NTU", "weight": 0.3},
    "TDS_mgL": {"min": 0.0, "max": 500.0, "extreme_max": 2000.0, "unit": "mg/L", "weight": 0.2},
    "residual_chlorine_mgL": {"min": 0.2, "max": 1.0, "extreme_max": 0.05, "unit": "mg/L", "weight": 0.3}
}

def detect_anomalies(node_id: str, window_hours: int = 72, threshold_z: float = 2.5) -> Dict[str, Any]:
    """
    Computes rolling mean, standard deviation, and Z-scores for node sensor readings.
    Flags statistical anomalies (|z| > threshold_z) and regulatory breaches.
    """
    with get_connection() as conn:
        cursor = conn.cursor()
        
        # Check sensor for node
        cursor.execute("SELECT id, type FROM sensors WHERE node_id = ?;", (node_id,))
        sensor = cursor.fetchone()
        if not sensor:
            return {"node_id": node_id, "has_sensor": False, "anomalies": []}
            
        sensor_id = sensor["id"]
        
        # Fetch readings within window
        cursor.execute("""
        SELECT pH, turbidity_NTU, TDS_mgL, residual_chlorine_mgL, timestamp
        FROM readings
        WHERE sensor_id = ?
        ORDER BY timestamp DESC
        LIMIT ?;
        """, (sensor_id, window_hours))
        
        rows = cursor.fetchall()
        if not rows:
            return {"node_id": node_id, "sensor_id": sensor_id, "has_sensor": True, "readings_count": 0, "anomalies": []}
            
        latest_reading = rows[0]
        results = []
        
        params = ["pH", "turbidity_NTU", "TDS_mgL", "residual_chlorine_mgL"]
        for p in params:
            values = [r[p] for r in rows if r[p] is not None]
            if len(values) < 2:
                continue
                
            n = len(values)
            mean = sum(values) / n
            variance = sum((x - mean) ** 2 for x in values) / (n - 1)
            std_dev = math.sqrt(variance) if variance > 0 else 0.0001
            
            latest_val = latest_reading[p]
            z_score = (latest_val - mean) / std_dev
            
            # Check limit breach
            limits = PARAM_THRESHOLDS.get(p, {})
            is_breached = False
            breach_reason = ""
            if "min" in limits and latest_val < limits["min"]:
                is_breached = True
                breach_reason = f"Below permissible minimum ({limits['min']} {limits.get('unit')})"
            elif "max" in limits and latest_val > limits["max"]:
                is_breached = True
                breach_reason = f"Exceeds permissible standard ({limits['max']} {limits.get('unit')})"
                
            is_anomaly = abs(z_score) >= threshold_z or is_breached
            
            results.append({
                "parameter": p,
                "latest_value": round(latest_val, 2),
                "mean": round(mean, 2),
                "std_dev": round(std_dev, 3),
                "z_score": round(z_score, 2),
                "is_statistical_anomaly": abs(z_score) >= threshold_z,
                "is_regulatory_breach": is_breached,
                "breach_reason": breach_reason,
                "status": "CRITICAL" if (abs(z_score) > 3.0 or (p == "turbidity_NTU" and latest_val > 4.0)) else ("WARNING" if is_anomaly else "NORMAL")
            })
            
        return {
            "node_id": node_id,
            "sensor_id": sensor_id,
            "sensor_type": sensor["type"],
            "timestamp": latest_reading["timestamp"],
            "has_sensor": True,
            "anomalies_detected": any(r["is_statistical_anomaly"] or r["is_regulatory_breach"] for r in results),
            "parameters": results
        }

def calculate_wqi(reading: Dict[str, Any]) -> Dict[str, Any]:
    """
    Computes a simplified Water Quality Index (0-100) based on IS 10500 standards.
    100 = Excellent, 80-99 = Good, 60-79 = Moderate, 40-59 = Poor, <40 = Critical/Unsafe.
    """
    if not reading:
        return {"wqi": 100, "grade": "UNKNOWN", "status": "No Reading"}
        
    scores = []
    
    # pH (optimal 7.0 - 7.5)
    ph = reading.get("pH", 7.0)
    ph_score = max(0, 100 - abs(ph - 7.2) * 45)
    scores.append(ph_score * PARAM_THRESHOLDS["pH"]["weight"])
    
    # Turbidity (optimal < 0.5 NTU, limit 1.0, worst > 5.0)
    turb = reading.get("turbidity_NTU", 0.5)
    if turb <= 1.0:
        turb_score = 100 - (turb * 20)
    else:
        turb_score = max(0, 80 - ((turb - 1.0) * 20))
    scores.append(turb_score * PARAM_THRESHOLDS["turbidity_NTU"]["weight"])
    
    # TDS (optimal < 250, limit 500, worst > 1000)
    tds = reading.get("TDS_mgL", 180)
    if tds <= 500:
        tds_score = 100 - (tds / 500) * 25
    else:
        tds_score = max(0, 75 - ((tds - 500) / 500) * 50)
    scores.append(tds_score * PARAM_THRESHOLDS["TDS_mgL"]["weight"])
    
    # Residual Chlorine (optimal 0.4 - 0.8 mg/L, min 0.2)
    cl = reading.get("residual_chlorine_mgL", 0.5)
    if 0.2 <= cl <= 1.0:
        cl_score = 100 - abs(cl - 0.5) * 40
    elif cl < 0.2:
        cl_score = max(0, cl * 200) # drops severely towards 0
    else:
        cl_score = max(20, 100 - (cl - 1.0) * 50)
    scores.append(cl_score * PARAM_THRESHOLDS["residual_chlorine_mgL"]["weight"])
    
    wqi_total = round(sum(scores), 1)
    
    if wqi_total >= 85:
        grade = "EXCELLENT"
        color = "#10b981" # green
    elif wqi_total >= 70:
        grade = "GOOD"
        color = "#06b6d4" # cyan
    elif wqi_total >= 50:
        grade = "POOR"
        color = "#f59e0b" # amber
    else:
        grade = "CRITICAL"
        color = "#ef4444" # red
        
    return {
        "wqi": wqi_total,
        "grade": grade,
        "color": color
    }

def simulate_chlorine_decay(start_node_id: str = "plant_bhandup", initial_chlorine: float = 1.8) -> List[Dict[str, Any]]:
    """
    Simulates residual chlorine decay along pipe network hierarchy starting from treatment plant.
    First-order kinetics: C(t) = C0 * exp(-k * t)
    Bulk & wall reaction rate constant k = 0.05 hr^-1.
    """
    k_decay = 0.048  # decay constant per hour
    
    with get_connection() as conn:
        cursor = conn.cursor()
        
        # Get all pipes and nodes
        cursor.execute("SELECT id, from_node, to_node, length_m, diameter_mm, install_year, material FROM pipes;")
        pipes = cursor.fetchall()
        
        cursor.execute("SELECT id, type, name, location, parent FROM nodes;")
        nodes = {n["id"]: dict(n) for n in cursor.fetchall()}
        
    # Build tree from pipes
    node_chlorine = {start_node_id: {"concentration": initial_chlorine, "travel_time_hrs": 0.0, "distance_m": 0.0}}
    queue = [start_node_id]
    
    decay_trail = []
    
    while queue:
        curr = queue.pop(0)
        curr_info = node_chlorine[curr]
        
        # Find downstream pipes
        downstream_pipes = [p for p in pipes if p["from_node"] == curr]
        for p in downstream_pipes:
            nxt = p["to_node"]
            dist = p["length_m"]
            # Estimate flow velocity v = 1.0 m/s for mains, 0.8 for distribution
            velocity = 1.0 if p["diameter_mm"] >= 600 else 0.7
            travel_time_hrs = dist / (velocity * 3600.0)
            
            # Additional wall factor based on pipe age
            pipe_age = max(1, 2026 - p["install_year"])
            age_factor = 1.0 + (pipe_age * 0.015)
            effective_k = k_decay * age_factor
            
            accum_time = curr_info["travel_time_hrs"] + travel_time_hrs
            accum_dist = curr_info["distance_m"] + dist
            
            # Decay formula
            c_next = curr_info["concentration"] * math.exp(-effective_k * travel_time_hrs)
            c_next = max(0.01, round(c_next, 3))
            
            node_chlorine[nxt] = {
                "concentration": c_next,
                "travel_time_hrs": round(accum_time, 2),
                "distance_m": round(accum_dist, 1)
            }
            queue.append(nxt)
            
    for node_id, metrics in node_chlorine.items():
        node_data = nodes.get(node_id, {})
        decay_trail.append({
            "node_id": node_id,
            "node_name": node_data.get("name", node_id),
            "node_type": node_data.get("type", "unknown"),
            "distance_m": metrics["distance_m"],
            "travel_time_hrs": metrics["travel_time_hrs"],
            "residual_chlorine_mgL": metrics["concentration"],
            "is_below_is10500_min": metrics["concentration"] < 0.2,
            "vulnerability_status": "VULNERABLE (Chlorine < 0.2 mg/L)" if metrics["concentration"] < 0.2 else "PROTECTED"
        })
        
    return decay_trail

if __name__ == "__main__":
    print("Testing Analysis Engine...")
    anomalies = detect_anomalies("plant_bhandup")
    print(f"Bhandup Plant Anomalies: {anomalies.get('anomalies_detected')}")
    for p in anomalies.get("parameters", []):
        print(f" - {p['parameter']}: {p['latest_value']} (z: {p['z_score']}, status: {p['status']})")
        
    decay = simulate_chlorine_decay()
    print(f"\nChlorine decay modeled across {len(decay)} nodes.")
    for d in decay[:5]:
        print(f" - {d['node_name']}: {d['residual_chlorine_mgL']} mg/L ({d['vulnerability_status']})")
