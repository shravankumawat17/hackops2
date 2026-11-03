"""
Synthetic data generator for the Water Quality Fault Localization project.

Generates (into ./data):
  graph.json       dependency tree: source -> plant -> reservoir -> zone -> segment -> building -> household
  readings.csv     hourly sensor readings at plant / reservoir / zone nodes, with injected fault window
  complaints.json  scripted complaints for 3 demo scenarios + a few background ones
  plumbers.json    fake plumbers with coordinates
  scenarios.json   the "now" time and expected outcome for each demo scenario

Run:  python generate_data.py
Only uses the Python standard library. Seeded, so output is reproducible.

IMPORTANT: baseline ranges below are rough values for realism only.
Verify every limit against the actual IS 10500 document before using it in the threshold table.
"""
import csv
import json
import math
import os
import random
from datetime import datetime, timedelta

random.seed(42)
OUT = "data"
os.makedirs(OUT, exist_ok=True)

START = datetime(2026, 11, 1, 0, 0)  # readings start (7 days, hourly)
DAYS = 7

# ----------------------------------------------------------------------------
# 1. GRAPH
# ----------------------------------------------------------------------------
# Real-sounding Mumbai names for plausibility. Network itself is SIMULATED.
ZONES = [
    {"id": "zone_01", "name": "K-West Zone (Andheri W), simulated", "lat": 19.1364, "lon": 72.8296},
    {"id": "zone_02", "name": "G-North Zone (Dadar), simulated", "lat": 19.0178, "lon": 72.8478},
]
SEGMENTS_PER_ZONE = 2
BUILDINGS_PER_SEGMENT = 2
HOUSEHOLDS_PER_BUILDING = 2


def jitter(v, spread=0.003):
    return round(v + random.uniform(-spread, spread), 5)


nodes = []


def add(nid, ntype, name, parent, lat=None, lon=None, has_sensor=False):
    nodes.append({
        "id": nid, "type": ntype, "name": name, "parent": parent,
        "lat": lat, "lon": lon, "has_sensor": has_sensor,
    })


add("src_01", "source", "Upper Vaitarna Lake (simulated)", None, 19.75, 73.35)
add("plant_01", "plant", "Treatment Plant A (simulated)", "src_01", 19.22, 72.97, True)
add("res_01", "reservoir", "Service Reservoir 1 (simulated)", "plant_01", 19.10, 72.90, True)

seg_counter = bld_counter = hh_counter = 0
for z in ZONES:
    add(z["id"], "zone", z["name"], "res_01", z["lat"], z["lon"], True)
    for _ in range(SEGMENTS_PER_ZONE):
        seg_counter += 1
        sid = f"seg_{seg_counter:02d}"
        slat, slon = jitter(z["lat"]), jitter(z["lon"])
        add(sid, "street_segment", f"Street Segment {seg_counter}", z["id"], slat, slon)
        for _ in range(BUILDINGS_PER_SEGMENT):
            bld_counter += 1
            bid = f"bld_{bld_counter:02d}"
            blat, blon = jitter(slat, 0.001), jitter(slon, 0.001)
            add(bid, "building_tank", f"Building {bld_counter} Tank", sid, blat, blon)
            for _ in range(HOUSEHOLDS_PER_BUILDING):
                hh_counter += 1
                add(f"hh_{hh_counter:02d}", "household", f"Flat {hh_counter}", bid,
                    jitter(blat, 0.0003), jitter(blon, 0.0003))

with open(f"{OUT}/graph.json", "w") as f:
    json.dump({"note": "SIMULATED network. Names are for realism only.", "nodes": nodes}, f, indent=2)

by_id = {n["id"]: n for n in nodes}
children = {}
for n in nodes:
    children.setdefault(n["parent"], []).append(n["id"])


def households_under(node_id):
    out, stack = [], [node_id]
    while stack:
        cur = stack.pop()
        if by_id[cur]["type"] == "household":
            out.append(cur)
        stack.extend(children.get(cur, []))
    return sorted(out)


# ----------------------------------------------------------------------------
# 2. READINGS
# ----------------------------------------------------------------------------
# Normal behaviour: (mean, noise std, daily swing amplitude). Rough values, VERIFY limits separately.
BASELINE = {
    "turbidity_ntu":      (0.6, 0.12, 0.05),
    "residual_chlorine":  (0.45, 0.05, 0.03),
    "ph":                 (7.4, 0.08, 0.05),
    "tds_mgl":            (150, 10, 5),
}

# Scenario timings (hour index from START)
def hr(day, hour):  # day is 1-based
    return (day - 1) * 24 + hour

S1_NOW = START + timedelta(hours=hr(5, 21))   # plant fault scenario
S2_NOW = START + timedelta(hours=hr(6, 20))   # pipeline fault scenario
S3_NOW = START + timedelta(hours=hr(7, 11))   # home fault scenario

PLANT_FAULT_START = hr(5, 17)
PLANT_FAULT_END = hr(5, 23)


def plant_value(param, h):
    mean, noise, swing = BASELINE[param]
    v = mean + swing * math.sin(2 * math.pi * (h % 24) / 24) + random.gauss(0, noise)
    # Inject plant fault: turbidity jumps, chlorine drops
    if PLANT_FAULT_START <= h <= PLANT_FAULT_END:
        k = min(1.0, (h - PLANT_FAULT_START + 1) / 2)  # ramp up over 2 hours
        if param == "turbidity_ntu":
            v += 5.0 * k + random.gauss(0, 0.3)
        elif param == "residual_chlorine":
            v -= 0.30 * k
        elif param == "tds_mgl":
            v += 60 * k
    return v


plant_series = {p: [plant_value(p, h) for h in range(DAYS * 24)] for p in BASELINE}

# Downstream nodes copy the plant series with a transport lag and small offsets.
LAGS = {"plant_01": 0, "res_01": 1, "zone_01": 2, "zone_02": 3}
CHLORINE_LOSS = {"plant_01": 0.0, "res_01": 0.05, "zone_01": 0.10, "zone_02": 0.12}

rows = []
for node_id, lag in LAGS.items():
    for h in range(DAYS * 24):
        src_h = max(0, h - lag)
        row = {"timestamp": (START + timedelta(hours=h)).isoformat(), "node_id": node_id}
        for p in BASELINE:
            v = plant_series[p][src_h] + random.gauss(0, BASELINE[p][1] * 0.3)
            if p == "residual_chlorine":
                v -= CHLORINE_LOSS[node_id]
            row[p] = round(max(v, 0), 3)
        rows.append(row)

with open(f"{OUT}/readings.csv", "w", newline="") as f:
    w = csv.DictWriter(f, fieldnames=["timestamp", "node_id"] + list(BASELINE))
    w.writeheader()
    w.writerows(rows)

# ----------------------------------------------------------------------------
# 3. COMPLAINTS
# ----------------------------------------------------------------------------
SYMPTOM_TEXT = {
    "brown_discolored": ["Water coming out brown since evening.", "Tap water is yellowish-brown, looks like rust."],
    "cloudy": ["Water looks milky and cloudy.", "Cloudy water, clears slowly in the glass."],
    "bad_smell": ["Strong chlorine-like smell in tap water.", "Water smells off, almost like sewage."],
    "bad_taste": ["Water tastes metallic."],
    "particles": ["Small particles floating in the water."],
}


def complaint(cid, hh, symptom, ts, taps, neighbors, illness=False, scenario=None):
    return {
        "complaint_id": cid,
        "household_node": hh,
        "symptom": symptom,
        "description": random.choice(SYMPTOM_TEXT[symptom]),
        "taps_affected": taps,
        "since": (ts - timedelta(minutes=random.randint(20, 90))).isoformat(),
        "submitted_at": ts.isoformat(),
        "neighbors_affected": neighbors,
        "illness_reported": illness,
        "scenario": scenario,
    }


complaints = []
cid = 0


def next_id():
    global cid
    cid += 1
    return f"C-{cid:03d}"


# Scenario 1: plant fault. Complaints spread across BOTH zones.
s1_hhs = [households_under("zone_01")[0], households_under("zone_01")[5],
          households_under("zone_02")[1], households_under("zone_02")[4],
          households_under("zone_02")[6]]
for i, hh in enumerate(s1_hhs):
    ts = S1_NOW - timedelta(minutes=random.randint(5, 150))
    complaints.append(complaint(next_id(), hh, random.choice(["brown_discolored", "cloudy"]),
                                ts, "all", True, scenario="S1_plant_fault"))

# Scenario 2: pipeline fault. Complaints from 3 buildings under ONE segment; plant is normal.
target_seg = "seg_02"
bld_under = children[target_seg]
s2_hhs = []
for b in bld_under:
    s2_hhs.extend(children[b][:2])
for hh in s2_hhs[:4]:
    ts = S2_NOW - timedelta(minutes=random.randint(5, 110))
    complaints.append(complaint(next_id(), hh, "brown_discolored", ts, "all", True, scenario="S2_pipeline_fault"))

# Scenario 3: home fault. One household, a different segment, no neighbors.
s3_hh = households_under("seg_07")[0] if "seg_07" in by_id else households_under("seg_03")[0]
complaints.append(complaint(next_id(), s3_hh, "particles", S3_NOW - timedelta(minutes=30),
                            "single_tap", False, scenario="S3_home_fault"))

# Background noise: a few scattered older complaints (useful so the system isn't only scripted)
all_hh = [n["id"] for n in nodes if n["type"] == "household"]
for _ in range(4):
    ts = START + timedelta(hours=random.randint(5, hr(4, 20)))
    complaints.append(complaint(next_id(), random.choice(all_hh),
                                random.choice(["bad_taste", "cloudy"]), ts,
                                random.choice(["all", "single_tap"]), False, scenario="background"))

complaints.sort(key=lambda c: c["submitted_at"])
with open(f"{OUT}/complaints.json", "w") as f:
    json.dump(complaints, f, indent=2)

# ----------------------------------------------------------------------------
# 4. PLUMBERS (fake)
# ----------------------------------------------------------------------------
first = ["Ramesh", "Suresh", "Imran", "Prakash", "Anil", "Salim", "Deepak", "Vijay", "Rafiq", "Mahesh", "Santosh", "Nitin"]
last = ["Patil", "Shaikh", "Yadav", "More", "Khan", "Jadhav", "Gupta", "Pawar"]
plumbers = []
for i in range(12):
    zone = ZONES[i % 2]
    plumbers.append({
        "id": f"pl_{i+1:02d}",
        "name": f"{random.choice(first)} {random.choice(last)}",
        "phone": f"+91 90000 000{i+10:02d}",  # clearly fake
        "lat": jitter(zone["lat"], 0.012),
        "lon": jitter(zone["lon"], 0.012),
        "rating": round(random.uniform(3.6, 4.9), 1),
        "specialty": random.choice(["tank cleaning", "pipe repair", "filter install", "general plumbing"]),
        "note": "FAKE DATA",
    })
with open(f"{OUT}/plumbers.json", "w") as f:
    json.dump(plumbers, f, indent=2)

# ----------------------------------------------------------------------------
# 5. SCENARIOS (the demo "now" time and expected result)
# ----------------------------------------------------------------------------
scenarios = [
    {"id": "S1_plant_fault", "now": S1_NOW.isoformat(), "expected_stage": "plant/source",
     "expected_route": "plant operators", "why": "plant turbidity spike + complaints in multiple zones"},
    {"id": "S2_pipeline_fault", "now": S2_NOW.isoformat(), "expected_stage": "distribution pipeline",
     "expected_route": "BMC", "why": f"plant normal, several buildings under {target_seg} complaining"},
    {"id": "S3_home_fault", "now": S3_NOW.isoformat(), "expected_stage": "household plumbing",
     "expected_route": "citizen + nearby plumbers", "why": "plant normal, single household, no neighbors"},
]
with open(f"{OUT}/scenarios.json", "w") as f:
    json.dump(scenarios, f, indent=2)

print(f"graph: {len(nodes)} nodes | readings: {len(rows)} rows | complaints: {len(complaints)} | plumbers: {len(plumbers)}")
print(f"S2 target segment: {target_seg}, S3 household: {s3_hh}")