import json
import urllib.request

BASE = "http://127.0.0.1:8000"


def get(path, method="GET", body=None):
    data = json.dumps(body).encode() if body is not None else None
    req = urllib.request.Request(BASE + path, data=data, method=method,
                                 headers={"Content-Type": "application/json"})
    with urllib.request.urlopen(req) as r:
        return json.loads(r.read())


net = get("/api/network")
print("network nodes/pipes:", len(net["nodes"]), len(net["pipes"]))
z3 = next(n for n in net["nodes"] if n["id"] == "zone_3")
print("zone_3 wqi:", z3["wqi"]["score"], z3["wqi"]["band"], "| override:", (z3["wqi"]["override"] or "")[:70])
z5 = next(n for n in net["nodes"] if n["id"] == "zone_5")
print("zone_5 wqi:", z5["wqi"]["score"], z5["wqi"]["band"])

print("cases before:", [(c["id"], c["scope"], c["status"]) for c in get("/api/cases")])
run = get("/api/cluster/run", "POST", {})
print("cluster run:", json.dumps(run, indent=1)[:900])

cases = get("/api/cases")
print("cases after:", [(c["id"], c["scope"], c["severity"], c["node_name"]) for c in cases])
cid = next(c["id"] for c in cases if c["scope"] == "MUNICIPAL" and c["status"] != "Resolved")
detail = get(f"/api/cases/{cid}")
print("case detail:", detail["case"]["title"])
print(" evidence building count:", len(detail["evidence"]["buildings"]))
print(" complaints:", [c["id"] for c in detail["complaints"]])
print(" trace:", " <- ".join(detail["trace"]["path"]))
print(" std rows:", [r["parameter"] for r in detail["standards"]["rows"]])

fc = get("/api/nodes/zone_5")
print("zone_5 forecast current/crossing:", fc["forecast"]["current"], fc["forecast"]["crossing_hours"])
print("zone_5 anomaly flags:", len(fc["forecast"].get("projected", [])))

print("hotspots:", [(h["zone_name"], h["risk_score"]) for h in get("/api/hotspots")[:3]])

draft = get(f"/api/cases/{cid}/draft", "POST")
print("draft first line:", draft["text"].splitlines()[0])
approved = get(f"/api/cases/{cid}/approve", "POST", {"actor": "Priya Nair"})
print("approved:", approved["approved"], "by", approved["approved_by"])

status = get(f"/api/cases/{cid}/status", "PATCH", {"status": "Action Taken", "note": "Flushing crew dispatched"})
print("status now:", status["case"]["status"])
