# AquaTrace

Environmental intelligence and compliance management for a municipal drinking-water
distribution network. Built for **Infomatrix HackOps 2**.

Citizens report water problems. AquaTrace links those complaints through the pipe
network, finds the shared upstream node, routes the case to the right owner, cites the
applicable standard, and tracks the response to closure.

> **Decision support only.** Automated findings support human judgment; they are not
> official regulatory decisions. All data is **synthetic sample data** for a fictional city.

---

## Quick start

```powershell
cd C:\Users\Intel\Desktop\projects\hackops2
python seed.py
python -m uvicorn backend.app:app --port 8000
```

Open **http://127.0.0.1:8000**.

No npm, no external API key, no network required. Python 3.12 + FastAPI + SQLite only.

If FastAPI is missing:

```powershell
pip install fastapi uvicorn
```

---

## The six tabs

| Tab | What it shows | Key interaction |
|---|---|---|
| **Dashboard** | KPIs, triage queue, hotspot ranking, latest reports | **Run clustering** |
| **Network** | Pipe graph, WQI colours, animated flow | Click a node; **Trace upstream** |
| **Citizen** | Complaint form + area status | Submit a report |
| **Cases** | Case list + full case detail | Evidence, standard, advisory, status, history |
| **Standards** | IS 10500 reference rows | Explain any sensor node |
| **Building admin** | Building-side cases + checklist | Open a building-side case |

---

## Demo path (3 minutes)

1. **Dashboard** - 8 reports in the last 24h, Zone 3 already red.
2. **Citizen** - file a complaint at a Zone 3 building; the area panel shows the readings.
3. **Dashboard -> Run clustering** - 5 complaints collapse into one MUNICIPAL case at `zone_3`.
4. **Cases** - open `CASE-2026-003`: evidence, rule that fired, 5 buildings, standards rows.
5. **Show on network** - red path draws from `zone_3` back through `J04 -> J02 -> J01 -> pump_1 -> res_hill -> plant_n`.
6. **Network -> Zone 5** - chlorine `0.235` now, forecast crosses `0.2` in ~21h: act before the breach.
7. **Cases -> Generate draft advisory -> Approve** - DRAFT becomes published, action logged.
8. **Move the case** - Investigating -> Action Taken -> Resolved; every step appears in history.

The wow moment is step 5: **5 complaints -> 1 old pipe segment**, not a dashboard.

---

## How it works

```
Complaint -> building node
          -> walk upstream in the pipe tree
          -> deepest node shared by >= 3 buildings
          -> MUNICIPAL case + evidence + trace
          -> else: single building + normal siblings -> BUILDING_SIDE
          -> else: 2 buildings -> UNDETERMINED inspection
```

- **Network model:** 58 nodes, 56 pipes, a tree (`nodes.parent_id`), so upstream and
  lowest-common-ancestor are exact graph operations.
- **Chlorine decay:** first-order `C_out = C_in * exp(-k * t)`, with `k` rising for older
  and smaller metallic pipes.
- **WQI:** weighted arithmetic sub-index, exposed as a **risk score** (0 = perfect,
  100 = worst). Any permissible-limit breach or coliform presence triggers a
  worst-parameter override that cannot be averaged away.
- **Standards:** bundled IS 10500 limit rows with locators. The numeric verdict is
  rule-based; the standards panel only explains it.
- **No LLM in the runtime path.** Deterministic, offline, defensible in Q&A.

---

## Project layout

```
backend/
  app.py          FastAPI routes + static frontend mount
  db.py           SQLite helpers, demo clock
  graph.py        upstream chain, LCA, trace
  wqi.py          sub-indices + worst-parameter override
  rules.py        clustering + routing + evidence
  forecast.py     decay forecast + time-of-day anomaly
  standards.py    bundled IS 10500 rows
web/
  index.html      six tabs
  app.js          all UI logic (no build step)
  style.css       dark instrument-panel theme
config/
  limits.json     single source of truth for numeric limits
  rules.json      clustering / severity / forecast / escalation
seed.py           deterministic synthetic city + 4 planted scenarios
schema.sql        DDL
verify_seed.py    asserts the planted scenarios
test_api.py       end-to-end API smoke test
```

---

## Planted scenarios (deterministic, seed 42)

| # | Scenario | Expected result |
|---|---|---|
| 1 | Contamination in Zone 3: old 1991 GI pipe, turbidity 8.3 NTU, chlorine 0.03 mg/L, coliform present | MUNICIPAL case at `zone_3`, 5 complaints, trace to plant |
| 2 | Sewage smell at one building, sibling readings normal | BUILDING_SIDE case at `B11` with checklist |
| 3 | Normal day: 3 unrelated routine complaints | No case, no anomaly |
| 4 | Zone 5 dead-end chlorine decay | Not breached now (0.235), forecast crosses 0.2 within 24h |

---

## API

```
GET    /api/meta
GET    /api/network
GET    /api/complaints
POST   /api/complaints
POST   /api/cluster/run
GET    /api/cases
GET    /api/cases/{id}
PATCH  /api/cases/{id}/status
POST   /api/cases/{id}/actions
GET    /api/cases/{id}/trace
GET    /api/nodes/{id}
GET    /api/nodes/{id}/readings
GET    /api/nodes/{id}/forecast
GET    /api/hotspots
GET    /api/standards/{node_id}
POST   /api/cases/{id}/draft
POST   /api/cases/{id}/approve
```

Interactive docs: **http://127.0.0.1:8000/docs**

---

## Verification

```powershell
python seed.py          # rebuild a clean demo database
python verify_seed.py   # graph + scenario assertions
python test_api.py      # end-to-end API smoke test (server must be running)
```

Expected: Zone 3 WQI `75.1 Unsafe`, 5 linked complaints, LCA `zone_3`,
Zone 5 forecast crossing at ~21h.

---

## Limitations and honest claims

- All sensor, lab, building and officer data is synthetic.
- There is no hydraulic solver; flow is represented by the tree and the decay model.
- The standards panel is a bundled excerpt, not the full BIS document. Verify every
  limit against the official IS 10500:2012 before presenting.
- Free residual chlorine is a **process-control** parameter, not a health-based standard.
- No authentication or role permissions in this prototype.
- The LLM-assisted features described in the original brief are intentionally replaced
  by deterministic keyword rules and retrieval, so the demo works offline.

## AI disclosure

This prototype was built with AI-assisted coding. The running system does **not** call
an LLM: all verdicts are rule-based and all standards explanations come from bundled
reference rows.
