"""
AquaTrace Dataset & Network Graph Generator
Aligned with Plan (2).md:
- Tree hierarchy: Source -> Plant -> Reservoir -> Zone -> Street Segment -> Building -> Household
- 3 Demo Scenarios (Plant fault, Pipeline fault, Household plumbing fault)
- IS 10500:2012 & WHO regulatory clauses table
- Certified local plumbers directory
"""

import math
import random
import json
import sqlite3
from datetime import datetime, timedelta
from database import get_connection, init_db

random.seed(42)

def seed_database():
    init_db()
    conn = get_connection()
    cursor = conn.cursor()

    # Clear old data
    cursor.execute("DELETE FROM readings;")
    cursor.execute("DELETE FROM sensors;")
    cursor.execute("DELETE FROM lab_tests;")
    cursor.execute("DELETE FROM complaints;")
    cursor.execute("DELETE FROM cases;")
    cursor.execute("DELETE FROM maintenance_checks;")
    cursor.execute("DELETE FROM pipes;")
    cursor.execute("DELETE FROM plumbers;")
    cursor.execute("DELETE FROM standards_clauses;")
    cursor.execute("DELETE FROM nodes;")

    print("Populating IS 10500:2012 and WHO Standards Knowledge Base...")
    standards = [
        (
            "std_turbidity",
            "IS 10500:2012",
            "Clause 4.1, Table 1 (Item 2)",
            "turbidity",
            1.0,
            5.0,
            "NTU",
            "Turbidity in drinking water shall not exceed 1.0 NTU (acceptable limit). In the absence of an alternate source, it may be relaxed up to 5.0 NTU (permissible limit). Above 5 NTU, consumer acceptance decreases and microbial pathogens may be shielded from disinfection.",
            "Inspect coagulant dosing and rapid gravity sand filters. If occurring in distribution network, isolate street segment and execute controlled scour valve flushing."
        ),
        (
            "std_chlorine",
            "IS 10500:2012",
            "Clause 4.1, Table 1 (Item 6)",
            "residual_chlorine",
            0.2,
            1.0,
            "mg/L",
            "Free residual chlorine minimum level shall be 0.2 mg/L at consumer end to ensure residual germicidal protection against post-treatment contamination. Maximum permissible limit is 1.0 mg/L (extended to 2.0 mg/L in emergency epidemic conditions).",
            "Deploy mobile booster chlorinator at the distribution reservoir or injection point. Flush stagnant terminal ends."
        ),
        (
            "std_ph",
            "IS 10500:2012",
            "Clause 4.1, Table 1 (Item 1)",
            "pH",
            6.5,
            8.5,
            "",
            "pH of drinking water shall strictly be within 6.5 to 8.5 with no relaxation. Water with pH < 6.5 is corrosive to iron/copper piping causing metal leaching and red water; pH > 8.5 impairs chlorine disinfection efficiency.",
            "Adjust lime/soda ash buffer feed at the treatment plant."
        ),
        (
            "std_tds",
            "IS 10500:2012",
            "Clause 4.1, Table 1 (Item 5)",
            "TDS",
            500.0,
            2000.0,
            "mg/L",
            "Total Dissolved Solids (TDS) acceptable limit is 500 mg/L; permissible limit up to 2000 mg/L. Beyond 500 mg/L, palatability decreases and scaling occurs.",
            "Blend source lake waters or clean intake well screens."
        ),
        (
            "std_coliform",
            "IS 10500:2012",
            "Clause 5.1, Table 2 (Microbiological)",
            "total_coliform",
            0.0,
            0.0,
            "MPN/100mL",
            "All water intended for drinking: E. coli or thermotolerant coliform bacteria MUST NOT be detectable in any 100 mL sample. No relaxation permitted.",
            "CRITICAL HEALTH ADVISORY: Issue immediate public Boil Water Notice, isolate affected distribution main, and hyperchlorinate."
        ),
        (
            "std_who_plumbing",
            "WHO Guidelines (4th Ed.)",
            "Chapter 8.4 (Building Systems)",
            "internal_plumbing",
            0.0,
            0.0,
            "",
            "In intermittent water supply systems, vacuum back-siphonage into building storage tanks and domestic pipe corrosion account for over 60% of isolated complaints. Responsibility falls on building premises management.",
            "Advise resident to engage a licensed plumber to inspect overhead tank check-valves and domestic brass/galvanized fittings."
        )
    ]

    cursor.executemany("""
    INSERT INTO standards_clauses (id, standard, clause, parameter, acceptable_limit, permissible_limit, unit, text, action_guidance)
    VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?);
    """, standards)

    # -------------------------------------------------------------
    # Certified Nearby Plumbers Directory (for Home Fault routing)
    # -------------------------------------------------------------
    plumbers = [
        ("plumb_01", "Ramesh Plumbers & Sanitaries", "+91 98201 44521", 4.8, 0.4, "Internal Pipeline & Leakage Repair", "Shop 4, Station Road, Bhandup West, Mumbai"),
        ("plumb_02", "Apex Hydro Solutions", "+91 98334 11209", 4.6, 0.8, "Overhead Tank Cleaning & Valves", "Gala 12, LBS Marg, Mulund West, Mumbai"),
        ("plumb_03", "Shree Ganesh Plumbing Services", "+91 97690 88341", 4.9, 1.2, "Pipe Replacement & Fitting", "Near Hanuman Temple, Station Road, Mumbai"),
        ("plumb_04", "Metro Rapid Plumbers", "+91 91672 55902", 4.5, 1.5, "Tap Filters, Geyser & In-house Lines", "Shop 2, Hill View CHS, Bhandup East, Mumbai"),
        ("plumb_05", "QuickFix Sanitary Works", "+91 98218 33214", 4.7, 1.9, "Booster Pumps & Water Meter Repair", "MG Road, Mulund West, Mumbai")
    ]

    cursor.executemany("""
    INSERT INTO plumbers (id, name, phone, rating, distance_km, specialization, address)
    VALUES (?, ?, ?, ?, ?, ?, ?);
    """, plumbers)

    # -------------------------------------------------------------
    # Supply Chain Dependency Tree Nodes (Mumbai Network)
    # -------------------------------------------------------------
    print("Generating Mumbai supply chain tree nodes...")
    nodes = [
        # Level 1: Raw Water Source
        {"id": "src_vaitarna", "type": "source", "name": "Upper Vaitarna Lake", "location": "Western Ghats Intake", "lat": 19.6500, "lon": 73.2800, "parent": None, "status": "NORMAL"},
        {"id": "src_bhatsa", "type": "source", "name": "Bhatsa River Dam", "location": "Shahapur Reservoir", "lat": 19.5200, "lon": 73.2500, "parent": None, "status": "NORMAL"},

        # Level 2: Treatment Plants
        {"id": "plant_bhandup", "type": "plant", "name": "Bhandup Water Treatment Complex", "location": "Bhandup Hills, Mumbai", "lat": 19.1550, "lon": 72.9150, "parent": "src_bhatsa", "status": "ELEVATED_TURBIDITY"},

        # Level 3: Master Service Reservoir
        {"id": "res_bhandup_master", "type": "reservoir", "name": "Bhandup Master Service Reservoir", "location": "Hill Reservoir Ridge", "lat": 19.1520, "lon": 72.9220, "parent": "plant_bhandup", "status": "NORMAL"},

        # Level 4: Ward Distribution Zones
        {"id": "zone_mulund", "type": "zone", "name": "T-Ward (Mulund Zone)", "location": "Mulund Central", "lat": 19.1720, "lon": 72.9450, "parent": "res_bhandup_master", "status": "NORMAL"},
        {"id": "zone_bhandup", "type": "zone", "name": "S-Ward (Bhandup Zone)", "location": "Bhandup Industrial-Urban Grid", "lat": 19.1440, "lon": 72.9360, "parent": "res_bhandup_master", "status": "ELEVATED_TURBIDITY"},

        # Level 5: Street Distribution Segments
        {"id": "seg_nehru_rd", "type": "street_segment", "name": "Segment 1: Nehru Road Main", "location": "Mulund West Feeder", "lat": 19.1710, "lon": 72.9420, "parent": "zone_mulund", "status": "NORMAL"},
        {"id": "seg_lbs_marg", "type": "street_segment", "name": "Segment 2: LBS Marg Distribution Main", "location": "LBS Industrial Belt", "lat": 19.1450, "lon": 72.9380, "parent": "zone_bhandup", "status": "CONTAMINATED"}, # Scenario 2 pipeline fault
        {"id": "seg_station_rd", "type": "street_segment", "name": "Segment 3: Bhandup Station Road", "location": "Station Link", "lat": 19.1410, "lon": 72.9340, "parent": "zone_bhandup", "status": "NORMAL"},

        # Level 6: Building Tanks
        # Under seg_nehru_rd (Zone Mulund - Normal)
        {"id": "bld_green_valley", "type": "building_tank", "name": "Green Valley Towers CHS", "location": "Nehru Rd, Mulund", "lat": 19.1700, "lon": 72.9410, "parent": "seg_nehru_rd", "status": "NORMAL"},
        {"id": "bld_model_school", "type": "building_tank", "name": "Model High School & Campus", "location": "Nehru Rd, Mulund", "lat": 19.1690, "lon": 72.9430, "parent": "seg_nehru_rd", "status": "NORMAL"},

        # Under seg_lbs_marg (Zone Bhandup - Pipeline Contamination Cluster: Scenario 2)
        {"id": "bld_silver_oak", "type": "building_tank", "name": "Silver Oak Society (Wing A-D)", "location": "LBS Marg, Bhandup", "lat": 19.1460, "lon": 72.9390, "parent": "seg_lbs_marg", "status": "CONTAMINATED"},
        {"id": "bld_radha_krishna", "type": "building_tank", "name": "Radha Krishna Residency", "location": "LBS Marg, Bhandup", "lat": 19.1455, "lon": 72.9400, "parent": "seg_lbs_marg", "status": "CONTAMINATED"},
        {"id": "bld_kailash_hub", "type": "building_tank", "name": "Kailash Commercial Hub", "location": "LBS Marg, Bhandup", "lat": 19.1445, "lon": 72.9385, "parent": "seg_lbs_marg", "status": "CONTAMINATED"},

        # Under seg_station_rd (Home Fault: Scenario 3 on Flat 301)
        {"id": "bld_shreeji", "type": "building_tank", "name": "Shreeji Heights CHS", "location": "Station Rd, Bhandup", "lat": 19.1415, "lon": 72.9335, "parent": "seg_station_rd", "status": "NORMAL"},
        {"id": "bld_metro_plaza", "type": "building_tank", "name": "Metro Plaza Complex", "location": "Station Rd, Bhandup", "lat": 19.1405, "lon": 72.9345, "parent": "seg_station_rd", "status": "NORMAL"},

        # Level 7: Consumer Households
        # In bld_silver_oak (affected by pipeline segment)
        {"id": "hh_silver_101", "type": "household", "name": "Silver Oak Flat 101", "location": "1st Floor, Wing A", "lat": 19.1461, "lon": 72.9391, "parent": "bld_silver_oak", "status": "DIRTY_WATER"},
        {"id": "hh_silver_304", "type": "household", "name": "Silver Oak Flat 304", "location": "3rd Floor, Wing B", "lat": 19.1462, "lon": 72.9392, "parent": "bld_silver_oak", "status": "DIRTY_WATER"},

        # In bld_radha_krishna (affected by pipeline segment)
        {"id": "hh_radha_202", "type": "household", "name": "Radha Krishna Flat 202", "location": "2nd Floor", "lat": 19.1456, "lon": 72.9401, "parent": "bld_radha_krishna", "status": "DIRTY_WATER"},

        # In bld_kailash_hub (affected by pipeline segment)
        {"id": "hh_kailash_canteen", "type": "household", "name": "Kailash Food Canteen", "location": "Ground Floor", "lat": 19.1446, "lon": 72.9386, "parent": "bld_kailash_hub", "status": "DIRTY_WATER"},

        # In bld_shreeji (Household plumbing fault demo: hh_shreeji_301 has rusty tap, hh_shreeji_102 is normal)
        {"id": "hh_shreeji_301", "type": "household", "name": "Shreeji Heights Flat 301", "location": "3rd Floor, Flat 301", "lat": 19.1416, "lon": 72.9336, "parent": "bld_shreeji", "status": "DIRTY_WATER"},
        {"id": "hh_shreeji_102", "type": "household", "name": "Shreeji Heights Flat 102", "location": "1st Floor, Flat 102", "lat": 19.1414, "lon": 72.9334, "parent": "bld_shreeji", "status": "NORMAL"},

        # In bld_green_valley (Normal clean controls)
        {"id": "hh_green_405", "type": "household", "name": "Green Valley Flat 405", "location": "4th Floor", "lat": 19.1701, "lon": 72.9411, "parent": "bld_green_valley", "status": "NORMAL"},
    ]

    for n in nodes:
        cursor.execute("""
        INSERT INTO nodes (id, type, name, location, lat, lon, parent, status)
        VALUES (?, ?, ?, ?, ?, ?, ?, ?);
        """, (n["id"], n["type"], n["name"], n["location"], n["lat"], n["lon"], n["parent"], n["status"]))

    print(f"Inserted {len(nodes)} hierarchical supply chain nodes.")

    # -------------------------------------------------------------
    # Distribution Pipes
    # -------------------------------------------------------------
    pipes = [
        {"id": "pipe_src_plant", "from_node": "src_bhatsa", "to_node": "plant_bhandup", "length_m": 4200, "diameter_mm": 1800, "material": "Mild Steel", "install_year": 2008},
        {"id": "pipe_plant_res", "from_node": "plant_bhandup", "to_node": "res_bhandup_master", "length_m": 1200, "diameter_mm": 1400, "material": "Ductile Iron", "install_year": 2012},
        {"id": "pipe_res_zoneM", "from_node": "res_bhandup_master", "to_node": "zone_mulund", "length_m": 2100, "diameter_mm": 800, "material": "Ductile Iron", "install_year": 2015},
        {"id": "pipe_res_zoneB", "from_node": "res_bhandup_master", "to_node": "zone_bhandup", "length_m": 1600, "diameter_mm": 900, "material": "Cast Iron", "install_year": 1994},
        {"id": "pipe_zoneM_nehru", "from_node": "zone_mulund", "to_node": "seg_nehru_rd", "length_m": 800, "diameter_mm": 450, "material": "Ductile Iron", "install_year": 2017},
        {"id": "pipe_zoneB_lbs", "from_node": "zone_bhandup", "to_node": "seg_lbs_marg", "length_m": 950, "diameter_mm": 450, "material": "Old Cast Iron", "install_year": 1984}, # Contaminated segment!
        {"id": "pipe_zoneB_station", "from_node": "zone_bhandup", "to_node": "seg_station_rd", "length_m": 750, "diameter_mm": 400, "material": "Ductile Iron", "install_year": 2016},
        {"id": "pipe_lbs_silveroak", "from_node": "seg_lbs_marg", "to_node": "bld_silver_oak", "length_m": 180, "diameter_mm": 150, "material": "Cast Iron", "install_year": 1988},
        {"id": "pipe_lbs_radha", "from_node": "seg_lbs_marg", "to_node": "bld_radha_krishna", "length_m": 210, "diameter_mm": 150, "material": "Cast Iron", "install_year": 1989},
        {"id": "pipe_lbs_kailash", "from_node": "seg_lbs_marg", "to_node": "bld_kailash_hub", "length_m": 160, "diameter_mm": 150, "material": "Cast Iron", "install_year": 1988},
        {"id": "pipe_station_shreeji", "from_node": "seg_station_rd", "to_node": "bld_shreeji", "length_m": 150, "diameter_mm": 150, "material": "HDPE", "install_year": 2018},
        {"id": "pipe_station_metro", "from_node": "seg_station_rd", "to_node": "bld_metro_plaza", "length_m": 190, "diameter_mm": 150, "material": "HDPE", "install_year": 2019},
        {"id": "pipe_nehru_green", "from_node": "seg_nehru_rd", "to_node": "bld_green_valley", "length_m": 140, "diameter_mm": 150, "material": "HDPE", "install_year": 2020},
    ]

    for p in pipes:
        cursor.execute("""
        INSERT INTO pipes (id, from_node, to_node, length_m, diameter_mm, material, install_year)
        VALUES (?, ?, ?, ?, ?, ?, ?);
        """, (p["id"], p["from_node"], p["to_node"], p["length_m"], p["diameter_mm"], p["material"], p["install_year"]))

    # -------------------------------------------------------------
    # Water Quality Sensors
    # -------------------------------------------------------------
    sensors = [
        ("sens_plant", "plant_bhandup", "PLANT_CLEARWATER_OUTLET"),
        ("sens_res", "res_bhandup_master", "RESERVOIR_OUTLET"),
        ("sens_zone_m", "zone_mulund", "ZONE_DISTRIBUTOR"),
        ("sens_zone_b", "zone_bhandup", "ZONE_DISTRIBUTOR"),
        ("sens_seg_lbs", "seg_lbs_marg", "STREET_SEGMENT_TELEMETRY"), # Sensor on LBS Marg
        ("sens_seg_station", "seg_station_rd", "STREET_SEGMENT_TELEMETRY"),
        ("sens_bld_shreeji", "bld_shreeji", "BUILDING_INLET"),
    ]

    for s_id, n_id, s_type in sensors:
        cursor.execute("INSERT INTO sensors (id, node_id, type) VALUES (?, ?, ?);", (s_id, n_id, s_type))

    # -------------------------------------------------------------
    # 14 Days Hourly Sensor Telemetry (336 hours)
    # Planted Scenario 1: Plant turbidity spike 2 hours ago
    # Planted Scenario 2: LBS segment turbidity spike 6 hours ago
    # Planted Scenario 3: Station road and Shreeji inlet normal
    # -------------------------------------------------------------
    now = datetime.now().replace(minute=0, second=0, microsecond=0)
    start_time = now - timedelta(days=14)
    readings = []

    print("Generating hourly telemetry readings...")
    for h in range(14 * 24):
        cur_ts = start_time + timedelta(hours=h)
        ts_str = cur_ts.isoformat()
        hours_ago = (now - cur_ts).total_seconds() / 3600.0

        for s_id, n_id, _ in sensors:
            ph = 7.35 + random.uniform(-0.06, 0.06)
            turb = 0.65 + random.uniform(-0.05, 0.05) # Normal < 1.0 NTU
            tds = 220 + random.uniform(-8, 8)         # Normal < 500 mg/L
            cl = 0.55 + random.uniform(-0.03, 0.03)   # Normal > 0.2 mg/L

            # Scenario 1 check: Plant outlet sensor has acute turbidity spike (6.8 NTU) in last 4 hours
            if s_id == "sens_plant" and hours_ago <= 4:
                turb = 6.8 + random.uniform(-0.2, 0.2)
                cl = 0.12 # Chlorine stripped

            # Scenario 2 check: LBS Marg segment has severe localized turbidity (7.4 NTU) in last 8 hours
            # (while plant_bhandup was previously normal before hour 4)
            if s_id == "sens_seg_lbs" and 4 < hours_ago <= 10:
                turb = 7.4 + random.uniform(-0.3, 0.3)
                cl = 0.05 # Chlorine depleted

            # Shreeji Heights inlet is consistently pure:
            if s_id == "sens_bld_shreeji":
                turb = 0.58 + random.uniform(-0.02, 0.02)
                cl = 0.52 + random.uniform(-0.02, 0.02)

            readings.append((s_id, ts_str, round(ph, 2), round(turb, 2), round(tds, 1), round(cl, 2)))

    cursor.executemany("""
    INSERT INTO readings (sensor_id, timestamp, pH, turbidity_NTU, TDS_mgL, residual_chlorine_mgL)
    VALUES (?, ?, ?, ?, ?, ?);
    """, readings)

    # -------------------------------------------------------------
    # Seed Complaints for the 3 Demo Scenarios
    # -------------------------------------------------------------
    print("Seeding complaints for demo scenarios...")
    complaints = [
        # Scenario 2: Pipeline Fault Complaints (3 buildings under seg_lbs_marg within 2 hours)
        {
            "id": "CMP-2026-001",
            "timestamp": (now - timedelta(hours=3)).isoformat(),
            "household_node_id": "hh_silver_101",
            "symptom": "brown_discolored",
            "taps_affected": "all",
            "since": (now - timedelta(hours=4)).strftime("%Y-%m-%d %H:%M"),
            "neighbors_affected": 1,
            "illness_reported": 0,
            "text": "Water in kitchen and bathroom is thick reddish-brown. Filters clogged with silt."
        },
        {
            "id": "CMP-2026-002",
            "timestamp": (now - timedelta(hours=2, minutes=45)).isoformat(),
            "household_node_id": "hh_radha_202",
            "symptom": "brown_discolored",
            "taps_affected": "all",
            "since": (now - timedelta(hours=3, minutes=30)).strftime("%Y-%m-%d %H:%M"),
            "neighbors_affected": 1,
            "illness_reported": 0,
            "text": "Muddy yellow tap water across all apartments. Severe sewage smell."
        },
        {
            "id": "CMP-2026-003",
            "timestamp": (now - timedelta(hours=2, minutes=15)).isoformat(),
            "household_node_id": "hh_kailash_canteen",
            "symptom": "brown_discolored",
            "taps_affected": "all",
            "since": (now - timedelta(hours=3)).strftime("%Y-%m-%d %H:%M"),
            "neighbors_affected": 1,
            "illness_reported": 0,
            "text": "Commercial canteen tap water is completely brown. Had to stop food preparation."
        },

        # Scenario 3: Single Household Plumbing Fault (hh_shreeji_301 has rusty water, flat 102 normal)
        {
            "id": "CMP-2026-004",
            "timestamp": (now - timedelta(minutes=40)).isoformat(),
            "household_node_id": "hh_shreeji_301",
            "symptom": "metallic_taste",
            "taps_affected": "kitchen_only",
            "since": (now - timedelta(hours=2)).strftime("%Y-%m-%d %H:%M"),
            "neighbors_affected": 0,
            "illness_reported": 0,
            "text": "Water in my kitchen tap tastes metallic and rusty. Flat next door says their water is crystal clear."
        }
    ]

    for c in complaints:
        cursor.execute("""
        INSERT INTO complaints (id, timestamp, household_node_id, symptom, taps_affected, since, neighbors_affected, illness_reported, text, status)
        VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?);
        """, (c["id"], c["timestamp"], c["household_node_id"], c["symptom"], c["taps_affected"], c["since"], c["neighbors_affected"], c["illness_reported"], c["text"], "reported"))

    # -------------------------------------------------------------
    # Seed Pre-built Case for Scenario 2 (Pipeline Fault on seg_lbs_marg)
    # -------------------------------------------------------------
    evidence_s2 = [
        "3 separate buildings (Silver Oak, Radha Krishna, Kailash Hub) reported brown water within 2 hours",
        "All 3 buildings connect downstream of Segment 2: LBS Marg Distribution Main (seg_lbs_marg)",
        "Street segment sensor sens_seg_lbs logged peak turbidity 7.4 NTU (breaching 5.0 NTU permissible limit)",
        "Upstream Bhandup Master Reservoir (res_bhandup_master) showed normal turbidity (0.68 NTU)"
    ]
    std_s2 = {
        "doc": "IS 10500:2012",
        "clause": "Clause 4.1, Table 1 (Item 2)",
        "text": "Turbidity: Acceptable limit 1.0 NTU, Permissible limit 5.0 NTU. Exceeding 5 NTU indicates physical contamination."
    }
    thresh_s2 = {
        "parameter": "turbidity_NTU",
        "value": 7.4,
        "limit": 5.0,
        "verdict": "BREACHED"
    }
    timeline_s2 = [
        {"ts": (now - timedelta(hours=3)).isoformat(), "event": "First complaint filed by Silver Oak Flat 101", "by": "Citizen Portal"},
        {"ts": (now - timedelta(hours=2, minutes=30)).isoformat(), "event": "Clustering rule fired: 3 buildings share seg_lbs_marg", "by": "System Engine"},
        {"ts": (now - timedelta(hours=2)).isoformat(), "event": "Case WQ-2026-LBS routed to BMC Maintenance Engineer", "by": "System Engine"},
        {"ts": (now - timedelta(hours=1)).isoformat(), "event": "BMC Field inspection team dispatched to LBS Marg main valve", "by": "Officer K. Shinde (BMC)"}
    ]

    cursor.execute("""
    INSERT INTO cases (
        case_id, household_node, symptom, taps_affected, since, neighbors_affected, illness_reported,
        located_node, fault_stage, confidence, evidence, standard_cited, threshold_check, routed_to,
        status, actions, timeline, created_at, updated_at
    ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?);
    """, (
        "WQ-2026-LBS", "hh_silver_101", "brown_discolored", "all", (now - timedelta(hours=4)).isoformat(),
        1, 0, "seg_lbs_marg", "distribution_pipeline", "high",
        json.dumps(evidence_s2), json.dumps(std_s2), json.dumps(thresh_s2), "BMC",
        "in progress", json.dumps(["Dispatched Field Crew", "Issue Scour Valve Flushing Notice"]),
        json.dumps(timeline_s2), (now - timedelta(hours=2)).isoformat(), (now - timedelta(hours=1)).isoformat()
    ))

    # -------------------------------------------------------------
    # Seed Pre-built Case for Scenario 3 (Home Plumbing Fault)
    # -------------------------------------------------------------
    evidence_s3 = [
        "Single household complaint at Shreeji Heights Flat 301",
        "Kitchen tap affected; bathroom taps normal",
        "Neighboring flat (hh_shreeji_102) and building inlet sensor sens_bld_shreeji show normal water (turbidity 0.58 NTU, chlorine 0.52 mg/L)",
        "Zero other complaints on Segment 3 (seg_station_rd)"
    ]
    std_s3 = {
        "doc": "WHO Guidelines (4th Ed.)",
        "clause": "Chapter 8.4 (Building Systems)",
        "text": "Isolated single-tap complaints indicate localized domestic galvanic corrosion or internal faucet strainer clogging."
    }
    thresh_s3 = {
        "parameter": "internal_plumbing",
        "value": 0.0,
        "limit": 0.0,
        "verdict": "DOMESTIC_ISOLATED"
    }
    timeline_s3 = [
        {"ts": (now - timedelta(minutes=40)).isoformat(), "event": "Complaint filed by Flat 301", "by": "Citizen Portal"},
        {"ts": (now - timedelta(minutes=35)).isoformat(), "event": "Localization rule: No upstream breach detected. Isolated to household.", "by": "System Engine"},
        {"ts": (now - timedelta(minutes=30)).isoformat(), "event": "Routed to Citizen with 5 nearby verified plumbers.", "by": "System Engine"}
    ]

    cursor.execute("""
    INSERT INTO cases (
        case_id, household_node, symptom, taps_affected, since, neighbors_affected, illness_reported,
        located_node, fault_stage, confidence, evidence, standard_cited, threshold_check, routed_to,
        status, actions, timeline, created_at, updated_at
    ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?);
    """, (
        "WQ-2026-HOME", "hh_shreeji_301", "metallic_taste", "kitchen_only", (now - timedelta(hours=2)).isoformat(),
        0, 0, "hh_shreeji_301", "household_plumbing", "high",
        json.dumps(evidence_s3), json.dumps(std_s3), json.dumps(thresh_s3), "Citizen",
        "resolved", json.dumps(["Recommended Plumber Contacted"]),
        json.dumps(timeline_s3), (now - timedelta(minutes=35)).isoformat(), (now - timedelta(minutes=30)).isoformat()
    ))

    conn.commit()
    conn.close()
    print("[SUCCESS] AquaTrace dataset initialized with full supply tree, plumbers, standards, and demo scenarios.")

if __name__ == "__main__":
    seed_database()
