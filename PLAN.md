# Plan: Water Quality Fault Localization System (AquaTrace)

Hackathon: Infomatrix, *Environmental Intelligence & Compliance Management System*
Format: 7 hours, team of 4
Chosen concern: suspected water-quality issue (Mumbai)

---

## 1. Objective

Build an end-to-end system that takes a citizen's water-quality complaint, works out **where in the supply chain the fault most likely lies** (source/plant, distribution pipeline, building, or household), backs the conclusion with visible evidence and a cited standard, routes it to the responsible party, and tracks it to closure.

**Specific objectives**
1. Structured intake: location, symptom, context, and display of local water conditions.
2. Fault localization using a dependency graph plus evidence from other nodes.
3. Anomaly detection on plant/zone readings.
4. Compliance interpretation: identify the applicable standard (IS 10500 / WHO) and cite the clause.
5. Threshold check with a recommended next step.
6. Case management: actions, status, timestamped history.
7. Explainability: every conclusion shows its evidence. Findings are recommendations that support human judgment, not official decisions.

**Demo success test:** a judge submits a complaint and in about 2 minutes sees the located fault, the evidence trail, the cited standard, the threshold verdict, the routed action, and the updated case timeline, for all three outcomes.

---

## 2. Architecture

### Actors (by supply stage)

| Stage | Responsible party | Role |
|---|---|---|
| Household | Citizen (plumber optional) | Reports issue, views status, sees nearby plumbers |
| Building | Housing society | Notified for building tank / internal mains faults |
| Source / treatment | Plant operators | Notified when plant readings breach thresholds |
| Distribution network | BMC | Receives pipeline-level cases, dispatches repair |

### Dependency graph (tree hierarchy)

```
Source (lake) -> Treatment plant -> Service reservoir -> Ward zone
              -> Street segment -> Building tank -> Household
```

Each node: `id, type, name, location, parent, readings, status`. Real Mumbai lake/ward names for plausibility, clearly labelled as a **simulated network**.

### Localization rules (top-down)

```python
path = walk_up(household_node)            # household -> ... -> source
evidence = collect(path)                  # readings vs limits, complaint counts, maintenance events

if plant_readings_breach_threshold:
    fault = "plant/source", route = "Plant Operators"
elif multiple_buildings_under_same_segment_or_zone_complaining:
    fault = "distribution pipeline", route = "BMC"
elif other_households_in_same_building_complaining:
    fault = "building tank / internal mains", route = "Housing Society"
else:
    fault = "household plumbing", route = "Citizen + Nearby Plumber List"

return fault, confidence, evidence_trail   # always show the "because"
```

---

## 3. Demo Scenarios

1. **Source / Plant Fault**: Plant turbidity spikes beyond limit (>5 NTU), several areas affected. Expected: routed to Plant Operators, standard cited, anomaly flagged.
2. **Distribution Pipeline Fault**: Plant is normal, 3+ buildings under one street segment complaining. Expected: routed to BMC, evidence trail names the segment.
3. **Household Plumbing Fault**: Plant normal, street normal, no neighbors affected. Expected: household plumbing, nearby plumbers list.

---

## 4. Hard Rules
- Banner on every page: *"Automated findings support human judgment. They are not official regulatory decisions."*
- Every flag, score, and routing decision must show its **evidence** (readings, baseline, limit, rule that fired).
- All data is synthetic and labelled "synthetic sample data".
- 100% offline runnable.

