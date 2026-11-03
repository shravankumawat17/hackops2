"""
AquaTrace synthetic data generator (Module A).

Runs with the Python standard library only:

    python seed.py

Creates hackops.db next to this file, using schema.sql.
Everything here is SYNTHETIC sample data for a fictional city.

Design notes that matter for the demo:
  * The distribution network is a TREE (parent_id), so "walk upstream" and
    "lowest common ancestor" are exact graph operations, not heuristics.
  * Chlorine decays with first-order kinetics along each pipe:
        C_out = C_in * exp(-k * travel_time)
    where k grows with pipe age and smaller diameter.
  * Four scenarios are planted deterministically so the demo always works.
"""

import json
import math
import os
import random
import sqlite3
from datetime import datetime, timedelta

SEED = 42
HERE = os.path.dirname(os.path.abspath(__file__))
DB_PATH = os.path.join(HERE, "hackops.db")
SCHEMA_PATH = os.path.join(HERE, "schema.sql")

NOW = datetime(2026, 11, 3, 9, 0, 0)
DAYS = 14
HOURS = DAYS * 24
START_TS = NOW - timedelta(hours=HOURS - 1)

rng = random.Random(SEED)


# --------------------------------------------------------------------------
# 1. Network definition
#    (id, name, type, lat, lon, zone_id, parent_id)
# --------------------------------------------------------------------------
NODES = [
    # raw water sources
    ("src_river", "Mula River Intake", "source", 19.115, 72.855, None, None),
    ("src_lake", "Vihar Lake Intake", "source", 19.140, 72.910, None, None),
    ("src_bore1", "Borewell North", "source", 19.080, 72.870, None, None),
    ("src_bore2", "Borewell South", "source", 19.030, 72.930, None, None),

    # treatment
    ("plant_n", "Nagar WTP North", "treatment_plant", 19.100, 72.865, "Z0", None),
    ("plant_s", "Nagar WTP South", "treatment_plant", 19.045, 72.925, "Z0", None),

    # storage
    ("res_hill", "Hill Reservoir", "reservoir", 19.090, 72.880, "Z0", "plant_n"),
    ("res_east", "East Reservoir", "reservoir", 19.040, 72.940, "Z0", "plant_s"),
    ("res_west", "West Reservoir", "reservoir", 19.050, 72.910, "Z0", "plant_s"),

    # pumping
    ("pump_1", "Pump Station P1", "pump", 19.082, 72.885, "Z0", "res_hill"),
    ("pump_2", "Pump Station P2", "pump", 19.042, 72.938, "Z0", "res_east"),
    ("pump_3", "Pump Station P3", "pump", 19.052, 72.905, "Z0", "res_west"),

    # junctions / trunk mains
    ("J01", "Junction J01", "junction", 19.075, 72.890, "Z0", "pump_1"),
    ("J02", "Junction J02", "junction", 19.070, 72.900, "Z0", "J01"),
    ("J03", "Junction J03", "junction", 19.078, 72.895, "Z0", "J01"),
    ("J04", "Junction J04", "junction", 19.062, 72.905, "Z0", "J02"),
    ("J05", "Junction J05", "junction", 19.040, 72.945, "Z0", "pump_2"),
    ("J06", "Junction J06", "junction", 19.035, 72.950, "Z0", "J05"),
    ("J07", "Junction J07", "junction", 19.045, 72.952, "Z0", "J05"),
    ("J08", "Junction J08", "junction", 19.048, 72.958, "Z0", "J07"),
    ("J09", "Junction J09 (dead end)", "junction", 19.085, 72.900, "Z0", "J03"),
    ("J10", "Junction J10 (dead end)", "junction", 19.052, 72.965, "Z0", "J08"),
    ("J11", "Junction J11 (dead end)", "junction", 19.058, 72.900, "Z0", "pump_3"),

    # distributor zones
    ("zone_1", "Zone 1 - Market Ward", "zone", 19.068, 72.905, "zone_1", "J02"),
    ("zone_2", "Zone 2 - School Ward", "zone", 19.080, 72.898, "zone_2", "J03"),
    ("zone_3", "Zone 3 - Station Ward", "zone", 19.058, 72.910, "zone_3", "J04"),
    ("zone_4", "Zone 4 - Mill Ward", "zone", 19.032, 72.955, "zone_4", "J06"),
    ("zone_5", "Zone 5 - Lakeview Ward", "zone", 19.050, 72.962, "zone_5", "J08"),
]

BUILDING_NAMES = [
    "Sai Darshan CHS", "Shivneri Apartments", "Ganesh Kripa", "Om Sai Residency",
    "Ashiyana CHS", "Neelkanth Heights", "Shreeji Arcade", "Vasant Vihar",
    "Rajhans Society", "Anand Nagar CHS", "Deepak CHS", "Suryodaya Apartments",
    "Chandan CHS", "Kavita Society", "Mahalaxmi CHS", "Pravin Nagar",
    "Siddhi CHS", "Gokul Residency", "Tulsi CHS", "Yashodhan CHS",
    "Sagar CHS", "Nirmal Heights", "Jyoti CHS", "Suvidha CHS",
    "Pooja Apartments", "Aakash CHS", "Riddhi CHS", "Shanti Niketan",
    "Basera CHS", "Utsav CHS",
]

# buildings per zone: zone_1: 6, zone_2: 7, zone_3: 6, zone_4: 6, zone_5: 5
ZONE_BUILDING_COUNTS = {"zone_1": 6, "zone_2": 7, "zone_3": 6, "zone_4": 6, "zone_5": 5}

ZONE_CENTRES = {
    "zone_1": (19.068, 72.905),
    "zone_2": (19.080, 72.898),
    "zone_3": (19.058, 72.910),
    "zone_4": (19.032, 72.955),
    "zone_5": (19.050, 72.962),
}


def build_buildings():
    """Attach 30 last-leg buildings to their distributor zones."""
    buildings = []
    idx = 0
    for zone_id, count in ZONE_BUILDING_COUNTS.items():
        clat, clon = ZONE_CENTRES[zone_id]
        for _ in range(count):
            idx += 1
            bid = f"B{idx:02d}"
            name = BUILDING_NAMES[idx - 1]
            # small deterministic jitter so the SVG/map layout is not a perfect grid
            lat = round(clat + rng.uniform(-0.004, 0.004), 6)
            lon = round(clon + rng.uniform(-0.004, 0.004), 6)
            buildings.append((bid, name, "building", lat, lon, zone_id, zone_id))
    return buildings


NODES += build_buildings()


# --------------------------------------------------------------------------
# 2. Pipes
# --------------------------------------------------------------------------
def pipe_attrs(from_node, to_node):
    """Deterministic realistic pipe attributes. Older trunk mains, newer last leg."""
    old_trunk = {"src_river", "src_lake", "plant_n", "plant_s", "res_hill", "res_east", "res_west"}
    if from_node in old_trunk or to_node in ("pump_1", "pump_2", "pump_3"):
        year = rng.randint(1984, 1996)
        diameter = rng.choice([400, 450, 500, 600])
        material = rng.choice(["DI", "MS", "CI"])
        length = rng.randint(600, 1400)
    elif to_node.startswith("zone_"):
        year = rng.randint(1990, 2004)
        diameter = rng.choice([150, 200, 250])
        material = rng.choice(["CI", "GI", "DI"])
        length = rng.randint(500, 1100)
    elif to_node.startswith("B"):
        year = rng.randint(1996, 2016)
        diameter = rng.choice([50, 63, 80, 100])
        material = rng.choice(["GI", "PVC", "HDPE"])
        length = rng.randint(40, 220)
    else:
        year = rng.randint(1992, 2010)
        diameter = rng.choice([150, 200, 250, 300])
        material = rng.choice(["CI", "DI", "GI"])
        length = rng.randint(300, 900)
    return length, diameter, material, year


PIPES = []
pipe_id = 0


def add_pipe(from_node, to_node, length=None, diameter=None, material=None, year=None):
    global pipe_id
    pipe_id += 1
    if length is None:
        length, diameter, material, year = pipe_attrs(from_node, to_node)
    PIPES.append((f"P{pipe_id:03d}", from_node, to_node, length, diameter, material, year))


# source -> plant
add_pipe("src_river", "plant_n", 1200, 600, "MS", 1986)
add_pipe("src_lake", "plant_n", 1500, 500, "MS", 1988)
add_pipe("src_bore1", "plant_n", 700, 400, "DI", 1994)
add_pipe("src_bore2", "plant_s", 900, 450, "DI", 1992)

# every node with a parent gets a pipe from its parent
for node in NODES:
    node_id, _name, ntype, _lat, _lon, _zone, parent = node
    if ntype in ("source", "treatment_plant"):
        continue
    if parent:
        # scenario-specific pipes (see the planted scenarios below)
        if parent == "J04" and node_id == "zone_3":
            add_pipe(parent, node_id, 900, 150, "GI", 1991)   # old, undersized: scenario 1
        elif parent == "J07" and node_id == "J08":
            add_pipe(parent, node_id, 1400, 100, "GI", 1998)  # long dead-end run: scenario 4
        elif parent == "J08" and node_id == "zone_5":
            add_pipe(parent, node_id, 1500, 100, "GI", 1998)
        elif parent == "J08" and node_id == "J10":
            add_pipe(parent, node_id, 1600, 80, "GI", 1995)
        elif parent == "J03" and node_id == "J09":
            add_pipe(parent, node_id, 1300, 100, "CI", 1993)
        elif parent == "pump_3" and node_id == "J11":
            add_pipe(parent, node_id, 1500, 100, "CI", 1990)
        else:
            add_pipe(parent, node_id)


# --------------------------------------------------------------------------
# 3. Hydraulics: water age and first-order chlorine decay
# --------------------------------------------------------------------------
NODE_BY_ID = {n[0]: n for n in NODES}
PIPE_BY_TO = {p[2]: p for p in PIPES}
CHILDREN = {}
for n in NODES:
    if n[6]:
        CHILDREN.setdefault(n[6], []).append(n[0])


def residence_hours(ntype):
    return {
        "reservoir": 1.2,
        "pump": 0.2,
        "junction": 0.2,
        "zone": 0.4,
        "building": 0.5,
    }.get(ntype, 0.0)


def decay_k(pipe):
    """1/h. Older, smaller, metallic pipe walls consume more chlorine."""
    _pid, _frm, _to, _length, diameter, material, year = pipe
    age = max(0, 2026 - year)
    k = 0.03 + 0.0022 * age
    if material in ("GI", "CI", "MS"):
        k += 0.05
    k += 0.10 * (150.0 / max(diameter, 50))
    return min(k, 0.40)


# baseline[ node_id ] = dict(age_h, chlorine, turbidity, ph, tds)
baseline = {}
for plant in ("plant_n", "plant_s"):
    baseline[plant] = {
        "age_h": 0.0, "chlorine": 0.85, "turbidity": 0.25, "ph": 7.35, "tds": 300.0,
    }

queue = ["plant_n", "plant_s"]
while queue:
    parent = queue.pop(0)
    for child in CHILDREN.get(parent, []):
        pipe = PIPE_BY_TO[child]
        length_m, diameter_mm = pipe[3], pipe[4]
        velocity_ms = 0.9 if diameter_mm >= 200 else 0.6
        travel_h = (length_m / velocity_ms) / 3600.0
        dt = travel_h + residence_hours(NODE_BY_ID[child][2])
        k = decay_k(pipe)
        pb = baseline[parent]
        age = pb["age_h"] + dt
        chlorine = max(0.02, pb["chlorine"] * math.exp(-k * dt))
        turbidity = pb["turbidity"] + 0.08
        if 2026 - pipe[6] > 25:
            turbidity += 0.12
        baseline[child] = {
            "age_h": age,
            "chlorine": chlorine,
            # keep normal-day baseline comfortably below the 1 NTU acceptable
            # limit (daily pattern + noise can add ~0.2), so a "normal day" is
            # clean and the building-side rule is not tripped by normal noise
            "turbidity": min(0.65, turbidity),
            "ph": max(6.9, min(7.9, pb["ph"] + rng.uniform(-0.06, 0.06))),
            "tds": min(520.0, pb["tds"] + rng.uniform(2, 12)),
        }
        queue.append(child)


# --------------------------------------------------------------------------
# 4. Sensors
# --------------------------------------------------------------------------
SENSOR_NODES = [
    "plant_n", "plant_s",
    "res_hill", "res_east", "res_west",
    "pump_1", "pump_2",
    "J01", "J04", "J05", "J07", "J08",
    "zone_1", "zone_2", "zone_3", "zone_4", "zone_5",
]
SENSORS = [(f"S_{node}", node, "multi", 2019) for node in SENSOR_NODES]


# --------------------------------------------------------------------------
# 5. Planted scenarios (deterministic)
# --------------------------------------------------------------------------
# The event must still be ACTIVE at the demo timestamp, otherwise the latest
# reading looks normal and the whole story collapses on stage.
EVENT_END = NOW
EVENT_START = EVENT_END - timedelta(hours=12)

SCENARIOS = [
    ("sc_contamination", "Contamination event in Zone 3",
     "Old 1991 GI pipe feeding Zone 3. Turbidity climbs and chlorine collapses over 12 h; "
     "5 buildings complain within 6 h; lab test finds total coliform.",
     "zone_3", EVENT_START.isoformat(sep=" "), EVENT_END.isoformat(sep=" ")),
    ("sc_building", "Building-side problem at B11",
     "Single building reports sewage smell. Sibling buildings and the zone sensor are normal, "
     "pointing to the internal tank / building plumbing.",
     "B11", (NOW - timedelta(hours=21)).isoformat(sep=" "), (NOW - timedelta(hours=20)).isoformat(sep=" ")),
    ("sc_normal", "Normal day baseline",
     "No sensor anomalies. Three unrelated routine complaints that must not cluster into a case.",
     None, None, None),
    ("sc_chlorine", "Chlorine decay risk on the Zone 5 dead-end",
     "Long 1998 GI dead-end run. Residual chlorine is trending down but has NOT breached the "
     "0.2 mg/L minimum yet. The 24 h forecast crosses the limit.",
     "zone_5", (NOW - timedelta(hours=96)).isoformat(sep=" "), NOW.isoformat(sep=" ")),
]

# scenario 4: force a declining chlorine series over the last 48 h.
# 48 h (not 96 h) because the 24 h forecast must actually cross 0.2 mg/L.
FORECAST_START = NOW - timedelta(hours=48)
FORECAST_END_CHLORINE = 0.235   # just above the 0.2 minimum
zone5_start_chlorine = baseline["zone_5"]["chlorine"]
j08_start_chlorine = baseline["J08"]["chlorine"]


def scenario_chlorine(node_id, ts, value):
    if node_id not in ("zone_5", "J08"):
        return value
    if ts < FORECAST_START:
        return value
    span = (NOW - FORECAST_START).total_seconds()
    progress = min(1.0, max(0.0, (ts - FORECAST_START).total_seconds() / span))
    start = zone5_start_chlorine if node_id == "zone_5" else j08_start_chlorine
    return start + (FORECAST_END_CHLORINE - start) * progress


# --------------------------------------------------------------------------
# 6. Readings
# --------------------------------------------------------------------------
READINGS = []
for s_idx, (sensor_id, node_id, _stype, _year) in enumerate(SENSORS):
    srng = random.Random(SEED * 1000 + s_idx)
    base = baseline[node_id]
    for h in range(HOURS):
        ts = START_TS + timedelta(hours=h)
        hour_of_day = ts.hour
        daily = math.sin(2 * math.pi * (hour_of_day - 6) / 24.0)

        turb = base["turbidity"] * (1 + 0.15 * daily) + srng.gauss(0, 0.05)
        cl = base["chlorine"] * (1 - 0.08 * daily) + srng.gauss(0, 0.008)
        ph = base["ph"] + 0.06 * math.sin(2 * math.pi * hour_of_day / 24.0) + srng.gauss(0, 0.03)
        tds = base["tds"] + 8 * daily + srng.gauss(0, 3)

        # scenario 1: contamination propagating down the Zone 3 branch
        if node_id in ("J04", "zone_3") and EVENT_START <= ts <= EVENT_END:
            frac = (ts - EVENT_START).total_seconds() / max(
                1, (EVENT_END - EVENT_START).total_seconds()
            )
            strength = 1.0 if node_id == "zone_3" else 0.6
            turb += 7.5 * frac * strength
            cl -= 0.32 * frac * strength
            ph -= 0.25 * frac * strength

        # scenario 4: chlorine decay forecast
        cl = scenario_chlorine(node_id, ts, cl)

        READINGS.append((
            sensor_id,
            ts.isoformat(sep=" "),
            round(max(6.2, min(8.9, ph)), 3),
            round(max(0.05, turb), 3),
            round(max(80.0, tds), 1),
            round(max(0.01, cl), 3),
        ))


# --------------------------------------------------------------------------
# 7. Lab tests (weekly per zone + the planted positive)
# --------------------------------------------------------------------------
LAB_TESTS = []
lab_id = 0
for zone_id in ZONE_BUILDING_COUNTS:
    for days_ago in (13, 6):
        lab_id += 1
        LAB_TESTS.append((
            f"LAB{lab_id:03d}", zone_id,
            (NOW - timedelta(days=days_ago)).date().isoformat(),
            "absent", "absent", "Routine weekly zone sample",
        ))

lab_id += 1
LAB_TESTS.append((
    f"LAB{lab_id:03d}", "zone_3",
    (NOW - timedelta(hours=6)).date().isoformat(),
    "present", "absent",
    "Total coliform present in 100 mL. Repeat sample requested.",
))


# --------------------------------------------------------------------------
# 8. Complaints: 5 clustered + 1 building-side + 3 routine
# --------------------------------------------------------------------------
COMPLAINTS = []


def add_complaint(cid, hours_ago, building, category, text, status="NEW"):
    COMPLAINTS.append((
        cid,
        (NOW - timedelta(hours=hours_ago)).isoformat(sep=" "),
        building, category, text, status, None, None,
    ))


# Scenario 1: five buildings in Zone 3 within a 6-hour window
add_complaint("CMP001", 11.0, "B14", "Muddy / turbid water",
              "Water is coming yellow-brown since last night. Cannot use it for cooking.")
add_complaint("CMP002", 10.0, "B15", "Muddy / turbid water",
              "Tap water looks muddy. Filter is clogging within minutes.")
add_complaint("CMP003", 9.5, "B16", "Suspected contamination",
              "Water is dirty and has a strange smell. Children in the building have stomach upset.")
add_complaint("CMP004", 8.0, "B17", "Bad taste",
              "Water tastes metallic and looks cloudy today.")
add_complaint("CMP005", 7.5, "B18", "Muddy / turbid water",
              "Same problem as neighbours - brown water from all taps.")

# Scenario 2: building-only problem
add_complaint("CMP006", 20.0, "B11", "Bad smell",
              "Water from the tap smells like sewage since yesterday. Neighbours say their water is fine.")

# Scenario 3: routine, unrelated, must not cluster
add_complaint("CMP007", 30.0, "B02", "No / low pressure",
              "Very low pressure in the morning for the last two days.")
add_complaint("CMP008", 8.0, "B21", "No / low pressure",
              "Water comes only for ten minutes in the evening.")
add_complaint("CMP009", 3.0, "B27", "Other",
              "Supply timing changed from morning to evening this week.")


# --------------------------------------------------------------------------
# 9. Historical resolved cases (so history pages are not empty)
# --------------------------------------------------------------------------
def days_ago(n):
    return (NOW - timedelta(days=n)).isoformat(sep=" ")


CASES = [
    ("CASE-2026-001", "zone_1", "MUNICIPAL", "Resolved", "High",
     "Turbidity spike on the Zone 1 trunk main", days_ago(20), days_ago(18),
     "3+ complaints shared upstream node zone_1",
     json.dumps({"complaints": ["H1", "H2", "H3"], "shared_node": "zone_1",
                 "max_turbidity_ntu": 6.4, "rule": "3+ buildings share upstream node"})),
    ("CASE-2026-002", "B24", "BUILDING_SIDE", "Resolved", "Medium",
     "Colour complaint isolated to one building", days_ago(35), days_ago(33),
     "Single building, sibling buildings normal",
     json.dumps({"complaints": ["H4"], "shared_node": "B24",
                 "sibling_readings_normal": True, "rule": "building-side isolation"})),
]

CASE_ACTIONS = [
    ("ACT001", "CASE-2026-001", days_ago(20), "Priya Nair", "Municipal Officer", "Case opened",
     "Cluster detected from 3 complaints on the Zone 1 trunk."),
    ("ACT002", "CASE-2026-001", days_ago(19), "Ramesh Patil", "Field Crew", "Investigating",
     "Line flushed and resampled at zone_1."),
    ("ACT003", "CASE-2026-001", days_ago(18), "Priya Nair", "Municipal Officer", "Resolved",
     "Turbidity back under 1 NTU for two consecutive samples."),
    ("ACT004", "CASE-2026-002", days_ago(35), "Asha Desai", "Building Admin", "Case opened",
     "Single-building colour complaint; internal tank inspected."),
    ("ACT005", "CASE-2026-002", days_ago(34), "Asha Desai", "Building Admin", "Action Taken",
     "Overhead tank cleaned and internal filter replaced."),
    ("ACT006", "CASE-2026-002", days_ago(33), "Priya Nair", "Municipal Officer", "Resolved",
     "No recurrence after 48 hours; case closed."),
]


# --------------------------------------------------------------------------
# 10. Maintenance checks
# --------------------------------------------------------------------------
MAINTENANCE = []
m_id = 0
check_types = ["Valve check", "Line flushing", "Tank cleaning"]
for i, node_id in enumerate(
    ["zone_1", "zone_2", "zone_3", "zone_4", "zone_5",
     "pump_1", "pump_2", "pump_3", "res_hill", "res_east"]
):
    m_id += 1
    days_ago = [5, 11, 19, 27, 38, 46, 8, 14, 22, 31][i]
    MAINTENANCE.append((
        f"M{m_id:03d}", node_id,
        (NOW - timedelta(days=days_ago)).date().isoformat(),
        check_types[i % len(check_types)],
        "minor issue" if node_id == "zone_5" else "pass",
        "Sediment noticed, flushing scheduled" if node_id == "zone_5" else "Within tolerance",
    ))


# --------------------------------------------------------------------------
# 11. Write database
# --------------------------------------------------------------------------
def main():
    if os.path.exists(DB_PATH):
        os.remove(DB_PATH)

    conn = sqlite3.connect(DB_PATH)
    with open(SCHEMA_PATH, "r", encoding="utf-8") as f:
        conn.executescript(f.read())

    conn.executemany("INSERT INTO nodes VALUES (?,?,?,?,?,?,?)", NODES)
    conn.executemany("INSERT INTO pipes VALUES (?,?,?,?,?,?,?)", PIPES)
    conn.executemany("INSERT INTO sensors VALUES (?,?,?,?)", SENSORS)
    conn.executemany("INSERT INTO readings VALUES (?,?,?,?,?,?)", READINGS)
    conn.executemany("INSERT INTO lab_tests VALUES (?,?,?,?,?,?)", LAB_TESTS)
    conn.executemany("INSERT INTO complaints VALUES (?,?,?,?,?,?,?,?)", COMPLAINTS)
    conn.executemany("INSERT INTO cases VALUES (?,?,?,?,?,?,?,?,?,?)", CASES)
    conn.executemany("INSERT INTO case_actions VALUES (?,?,?,?,?,?,?)", CASE_ACTIONS)
    conn.executemany("INSERT INTO maintenance_checks VALUES (?,?,?,?,?,?)", MAINTENANCE)
    conn.executemany("INSERT INTO scenarios VALUES (?,?,?,?,?,?)", SCENARIOS)
    conn.executemany("INSERT INTO meta VALUES (?,?)", [
        ("synthetic", "true"),
        ("seed", str(SEED)),
        ("generated_at", NOW.isoformat(sep=" ")),
        ("note", "Synthetic sample data for a fictional city. Not official utility data."),
    ])
    conn.commit()

    # ---- summary ----
    def scalar(sql, *args):
        return conn.execute(sql, args).fetchone()[0]

    print("AquaTrace seed complete ->", DB_PATH)
    print(f"  nodes      : {scalar('SELECT COUNT(*) FROM nodes')}")
    print(f"  pipes      : {scalar('SELECT COUNT(*) FROM pipes')}")
    print(f"  sensors    : {scalar('SELECT COUNT(*) FROM sensors')}")
    print(f"  readings   : {scalar('SELECT COUNT(*) FROM readings')}")
    print(f"  complaints : {scalar('SELECT COUNT(*) FROM complaints')}")
    print(f"  lab tests  : {scalar('SELECT COUNT(*) FROM lab_tests')}")
    print(f"  cases      : {scalar('SELECT COUNT(*) FROM cases')}")
    print()
    print("Planted scenario checks:")
    row = conn.execute(
        "SELECT ROUND(MAX(turbidity_ntu),2), ROUND(MIN(residual_chlorine_mgl),2) "
        "FROM readings WHERE sensor_id='S_zone_3' AND timestamp >= ?",
        ((NOW - timedelta(hours=13)).isoformat(sep=" "),)
    ).fetchone()
    print(f"  [1] zone_3 last 13h: max turbidity {row[0]} NTU, min chlorine {row[1]} mg/L")
    row = conn.execute(
        "SELECT COUNT(*) FROM complaints WHERE building_node_id IN "
        "('B14','B15','B16','B17','B18')"
    ).fetchone()
    print(f"  [1] clustered complaints from 5 Zone 3 buildings: {row[0]}")
    row = conn.execute(
        "SELECT total_coliform FROM lab_tests WHERE node_id='zone_3' ORDER BY date DESC LIMIT 1"
    ).fetchone()
    print(f"  [1] latest zone_3 coliform: {row[0]}")
    row = conn.execute(
        "SELECT COUNT(*) FROM complaints WHERE building_node_id='B11'"
    ).fetchone()
    print(f"  [2] building-side complaints at B11: {row[0]}")
    row = conn.execute(
        "SELECT ROUND(residual_chlorine_mgl,3) FROM readings WHERE sensor_id='S_zone_5' "
        "ORDER BY timestamp DESC LIMIT 1"
    ).fetchone()
    print(f"  [4] zone_5 latest chlorine: {row[0]} mg/L (limit 0.2; forecast should cross)")

    conn.close()


if __name__ == "__main__":
    main()
