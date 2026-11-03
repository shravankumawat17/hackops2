# AquaTrace database and frontend integration guide

Designed from your uploaded plan, Python dataset generator, and frontend design principles. This is a database starter and an implementation guide; it does not create a cloud project or deploy an app. The SQL and importer are implementation files. `backend_reference.py` contains repository helpers, not a complete API server or localization engine.

## 1. Recommended stack

**React + Tailwind + Recharts → Python FastAPI → Supabase PostgreSQL.**

Use Supabase as the hosted relational database. Keep localization, thresholds, anomaly calculation, and complaint intake in your backend. This fits your Python generator and the planned team ownership. If your frontend is Next.js from v0, it can call this same API: only the environment-variable syntax changes. You do not need a separate graph database, vector database, or real-time subscription for a 7-hour demo.

The browser sends a complaint; the backend queries the graph and evidence, computes a recommendation, saves the case, and returns the exact field names your UI expects. Both role views fetch the same case URL. The Citizen/Authority toggle changes presentation only.

Use a private/local demo with synthetic records: the role toggle and `X-Demo-Session` header are **not authentication or access control**. They cannot protect real citizen records or a publicly exposed authority API.

## 2. Fix these dataset/contract mismatches first

| Finding in supplied files | Decision for this design |
|---|---|
| Plan says roughly 20–30 nodes; generator creates 33 | Keep all 33. No schema change needed. |
| Pipeline scenario says 3 affected buildings, but each segment has only 2 | Use **at least 2 distinct buildings under one segment within 2 hours** for the demo rule and update the UI/pitch text. Four complaints across two buildings are not four independent buildings. |
| `seg_07` is referenced but only `seg_01`–`seg_04` exist | Generator already falls back to `seg_03`; preserve that fallback. |
| Readings have timezone-free timestamps | Importer interprets them as Mumbai time (`Asia/Kolkata`), not UTC, and stores `timestamptz`. |
| Demo is Nov 5–7, while real clock may differ | Use `scenarios.as_of` for readings, complaint windows, simulated event times and UI ages. Never use the machine clock to select demo evidence. |
| Plan lists four fault stages but demos cover three | Add a building-fault fixture before claiming all four branches work. |
| UI has “Don't know” for neighbors | Store `null`, not `false`. Reported neighbor concern is context, not independent corroboration. |
| Generator uses `single_tap`; UI says “One tap” | Send `single_tap`; keep readable labels in UI. |
| Generator scenario stages/routes contain spaces/slashes | Importer converts them to canonical enum strings below. |
| Generator has synthetic plumber ratings | Omit ratings from storage/UI to match the design spec. Disable Call for these fake entries. |
| UI examples contain threshold numbers | They are examples only. This starter contains **no asserted drinking-water limit values**. |

Your supplied generator is included unchanged as `generate_data.py`. Its misleading “3 buildings” comment remains visible; change it to “2 buildings” in your project. The importer does not invent a third building.

## 3. Database tables

| Table | Purpose / key columns | Relation |
|---|---|---|
| `nodes` | `id`, `type`, `name`, `parent_id`, coordinates, sensor flag | `parent_id → nodes.id` represents the supply tree |
| `readings` | sensor values plus `observed_at` | composite primary key `(node_id, observed_at)`; node FK |
| `scenarios` | fixed demo clock, expected result | expected result is test metadata, never engine evidence |
| `demo_sessions` | selected scenario per browser session | scenario FK |
| `complaints` | intake fields, independent reports, seed/session scope | household node FK; unique `request_id` |
| `cases` | case number, workflow status, version, processing timestamps | one case per complaint |
| `case_analyses` | immutable evidence, limits, citation and anomaly snapshots | multiple revisions per case |
| `case_events` | append-only actions, notes and status events | many events per case |
| `standard_passages` | real document edition, clause, passage, source, verification | original source text |
| `parameter_limits` | parameter, unit, lower/upper bound, applicability | FK to the supporting passage |
| `plumbers` | simulated directory | coordinates used for Haversine distance |

Use relational columns for links, timestamps and filters. Use JSONB for variable-length **analysis snapshots**. You should not need migrations whenever an evidence item gains another supporting field.

`cases.id` is an internal number; its generated public identifier is `WQ-001`, `WQ-002`, etc. Gaps after rolled-back transactions are normal. The frontend never invents or increments case IDs.

The schema validates direct parent references and prevents self-parenting. `import_data.py` additionally validates the exact stage ordering, which makes imported trees acyclic. There is no network-editing API in this scope. If you add one, enforce that same rule in a database trigger or its only mutation path; a foreign key alone cannot prevent arbitrary cycles.

Network topology and readings remain separate: a node has no permanent “safe” status. Compute health **as of the chosen scenario time**, with `unknown` for missing/stale data. Report “sensor breach” separately from “suspected fault from complaints.”

## 4. Create the database and load the generator

1. Create a Supabase project, or use an existing empty demo database. Do not run this schema over unrelated project tables.
2. Open its SQL Editor, paste **all of `schema.sql`**, and run once. It creates only the `aquatrace` schema. Running it twice deliberately fails instead of silently hiding schema differences.
3. In the project's Connect panel, copy a **Session pooler** Postgres URI for your persistent FastAPI backend if your environment needs IPv4. Direct connection is also suitable where supported. Copy the supplied URI rather than constructing a hostname.
4. Keep that URI in the backend's `.env` as `DATABASE_URL`, with SSL enabled. URL-encode special characters in the password. Keep `.env` out of Git. `VITE_` and `NEXT_PUBLIC_` variables must never contain this URI.
5. Install the driver and run the generator and importer from this folder:

```bash
python -m venv .venv
```

Activate the environment: Windows PowerShell `.venv\Scripts\Activate.ps1`; macOS/Linux `source .venv/bin/activate`.

```bash
python -m pip install "psycopg[binary]"
python generate_data.py
```

Set the connection string in your shell (the sample file is not auto-loaded):

```powershell
# Windows PowerShell
$env:DATABASE_URL = 'YOUR_DATABASE_CONNECTION_URI'
python import_data.py data
```

```bash
# macOS/Linux
export DATABASE_URL='YOUR_DATABASE_CONNECTION_URI'
python import_data.py data
```

6. Check the import using the verification SQL below. Re-running the importer upserts seed records without deleting user-created cases or complaints. It does not remove old seed IDs if you redesign the generator: for topology changes, use a fresh demo database or write an explicit seed migration.
7. Add verified standard passages/limits separately. Until then, render “Standard not configured” and `not_evaluated`; do not fabricate a citation or show green compliance.

```sql
SELECT 'nodes' AS item,count(*) FROM aquatrace.nodes
UNION ALL SELECT 'readings',count(*) FROM aquatrace.readings
UNION ALL SELECT 'complaints',count(*) FROM aquatrace.complaints
UNION ALL SELECT 'plumbers',count(*) FROM aquatrace.plumbers;
-- Unmodified generator: 33 nodes, 672 readings, 14 complaints, 12 plumbers.
SELECT id,as_of AT TIME ZONE 'Asia/Kolkata' AS mumbai_time
FROM aquatrace.scenarios WHERE id <> 'background' ORDER BY id;
-- Nov 5 21:00; Nov 6 20:00; Nov 7 11:00, 2026.
```

The private schema is not intended for Supabase's browser Data API. Leave it out of exposed schemas. RLS is enabled with no public policies. A trusted database owner connection can perform the backend operations; a normal unprivileged login will need explicit grants and suitable policies. For the hackathon, keep the owner connection strictly server-side. Before real deployment, use a least-privilege backend login and real authorization.

## 5. Backend API contract to freeze with your frontend teammate

All paths below are under `/api`. These are **contracts to implement**, not routes already supplied by this starter. Use ISO 8601 timestamps with timezone, and serialize timestamps/numeric values to JSON. With FastAPI return ordinary dictionaries using its JSON encoding support.

| Method / route | Input | Response / UI |
|---|---|---|
| `GET /network` | none | `{nodes: [...]}`; expose `parent` mapped from `parent_id` for existing map component |
| `GET /scenarios` | none | `[{id, now, label}]`; map `as_of → now`; omit expected outcomes and background |
| `POST /demo/scenario` | `{scenario_id}` + `X-Demo-Session` | create `demo_sessions(id,scenario_id)`, return `{scenario_id,now}`; existing same selection is idempotent; require fresh session ID to switch |
| `GET /conditions?household_node=hh_01` | session header | nearest zone's latest reading at/before demo now, units, limits, `measured_at`, `age_minutes`, `stale`, `is_simulated` |
| `POST /complaints` | intake JSON below + session header | full case record, `201`; same request retry returns same record with `200` |
| `GET /cases` | session + optional status/route/urgent filters | array of full cases for that session/scenario; cap demo list at 100 |
| `GET /cases/{case_id}` | session header | same full case record for both role views |
| `PATCH /cases/{case_id}/status` | `{status,expected_version}` | updated full record, or `409` conflict |
| `POST /cases/{case_id}/actions` | `{kind: "note" or "dispatch",text,expected_version}` | updated case after event appended in same transaction; increment version |
| `GET /readings?node_id=plant_01&parameter=turbidity_ntu&hours=24` | session header | `{node_id,parameter,unit,points:[{timestamp,value,z_score,is_anomaly}],limits,as_of}` |
| `GET /standards?q=turbidity` | search text | verified passages only, or empty array; quote retrieved text without generating claims |
| `GET /plumbers?household_node=hh_01&radius_km=5` | validated node/radius | sorted `{id,name,distance_km,specialty,is_simulated}` objects; fake phones not callable |

Use `400` malformed input, `404` missing/session-mismatched case, `409` stale version or scenario mismatch, `422` invalid domain fields/transition, `503` analysis unavailable. Error body: `{"error":{"code":"VERSION_CONFLICT","message":"This case changed. Reload it and try again."}}`. Do not send database errors/stack traces to UI.

```json
{
  "request_id": "e6d6cb20-8dce-469e-9259-0bbb5b9db486",
  "household_node": "hh_05",
  "symptom": "brown_discolored",
  "description": "Brown water from all taps.",
  "taps_affected": "all",
  "since": "2026-11-06T19:00:00+05:30",
  "neighbors_affected": true,
  "illness_reported": false,
  "meter_reading": null
}
```

`hh_05` belongs to `bld_03` under `seg_02`, suitable for the pipeline demo. For every submission: validate node exists **and is a household**; validate enums, boolean/null values, onset ≤ scenario now, finite nonnegative meter reading, description length (e.g. 2,000 characters), UUID, session and scenario. Browser clients must not submit status, route, confidence, citations or other computed fields. Server sets submission time from the session's scenario clock.

### POST /complaints orchestration

1. Resolve `X-Demo-Session` to `demo_sessions`; load `scenarios.as_of`. Do not read `expected_stage` or `expected_route` during analysis.
2. Check `request_id`; if already used in this session, return that case. A retry with different input should return `409` rather than modify the original complaint.
3. Validate the complaint. Gather evidence with `queries.sql`: restrict to the scenario clock, same scenario's seed reports, background reports, and this session's live reports. Include the incoming report exactly once, in memory. Count distinct households/buildings; repeated reports from the same flat never inflate counts.
4. Run top-down localization and return the analysis object shape below. Run CPU/external work before opening a long write transaction. For the demo this recommendation is a snapshot; concurrent new reports can be included on an explicit re-analysis.
5. Call `persist_analyzed_case()` to atomically save complaint, case, analysis and initial events. Call `get_case()` for the response. Use a fresh autocommit connection or clean transaction boundary for these helpers, with `row_factory=dict_row`. Example connection setup:

```python
import os
import psycopg
from psycopg.rows import dict_row

with psycopg.connect(os.environ['DATABASE_URL'], autocommit=True,
                     row_factory=dict_row, prepare_threshold=None) as conn:
    # validate -> compute analysis -> persist_analyzed_case -> get_case
    pass
```

6. If analysis fails, return `503` with retry, with no partial case saved. Reuse the request ID when retrying. Do not claim a case was created until the transaction commits. A later version can persist a pending case and process asynchronously; it is unnecessary for this demo.

```json
{
  "rule_version": "localization-v1",
  "located_node": "seg_02",
  "fault_stage": "distribution_pipeline",
  "confidence": "medium",
  "routed_to": "bmc",
  "evidence": [
    {"kind":"complaint_cluster","node_id":"seg_02","text":"2 distinct buildings under seg_02 reported within 2 hours.","count":2,"window_minutes":120}
  ],
  "threshold_checks": [],
  "citations": [],
  "anomaly_summary": {}
}
```

This is a storage-shape example, not the output of an implemented engine. Evidence should also store contributing complaint IDs and reading timestamps/values when available. If there is no verified threshold, normal-looking plant readings must be described as “near simulated baseline,” not “compliant.” A plant-fault recommendation can be supported by an anomaly while its compliance verdict remains `not_evaluated`. Missing upstream evidence should reduce confidence and may warrant `undetermined`/manual review instead of blaming a home by default.

## 6. Preserve your existing frontend field names

`get_case()` assembles your original JSON contract without forcing UI components to understand joins:

| Frontend field | Source |
|---|---|
| `case_id`, `status` | `cases` |
| `household_node`, `symptom`, `since`, taps, neighbors, illness | associated `complaints` row |
| `located_node`, `fault_stage`, `confidence`, `routed_to` | latest `case_analyses` revision |
| `evidence[]` | analysis evidence `text` strings; details available as `evidence_details[]` |
| `standard_cited` | first citation object; null if none |
| `threshold_check` | first threshold check; null if none |
| `actions[]` | action/note/status events |
| `timeline[]` | all events, newest first, with `ts`, `event`, `by` |

Keep plural `citations[]` and `threshold_checks[]` as additions for multiple parameters. Sort checks by importance in the engine before saving: the first check is the main UI card. A citation object uses `{doc,edition,clause,text,source_url}`. Preserve exact passage text and document edition in each snapshot, so later source edits do not silently rewrite an old case's explanation.

| Canonical value | Display label |
|---|---|
| `plant_source` | Source / treatment plant |
| `distribution_pipeline` | Distribution pipeline |
| `building` | Building tank / internal mains |
| `household` | Household plumbing |
| `undetermined` | More evidence needed |
| `plant_operators` | Plant operators |
| `bmc` | BMC |
| `housing_society` | Housing society |
| `citizen` | Citizen + nearby plumbers |
| `manual_review` | Manual review |
| `in_progress` | In progress |

Enums are for code; friendly text is for UI. Confidence is a rule-based label, not a measured probability.

## 7. Wire the React frontend

1. Copy `frontend_api.ts` into `src/lib/api.ts`.
2. Set `VITE_API_BASE_URL=http://localhost:8000/api` in your frontend `.env.local`; restart the frontend dev server. For Next.js set `NEXT_PUBLIC_API_BASE_URL` and change the one base-URL line in the adapter. Client components/hooks need `"use client"` in Next.js. The network/session functions access browser storage; call them only from a browser handler/effect.
3. Implement the API routes above. In FastAPI configure CORS with your **exact** frontend origin, `GET/POST/PATCH` methods and `Content-Type`, `X-Demo-Session` headers. Different ports are different origins. For a same-origin reverse proxy, keep `BASE='/api'` and CORS is unnecessary.
4. On initial demo load call `api.scenarios()`, then `api.selectScenario(id)`. Store returned `now` in React state/context; use it for demo dates and ages. On scenario switch/reset call `resetDemo()`, clear selected case and all cached conditions/readings/cases, then select the new scenario in the fresh session.
5. Household dropdown reads `api.network()` and filters `type === 'household'`. After selection, call `/conditions`; do not pretend zone sensor values are household measurements.
6. Replace mock form submission with `api.submit()`. Generate a request ID once per submission attempt and keep it for retries. Disable submit while pending. On success, use the response as the selected case and navigate to My case.
7. Both Citizen and Authority case detail components consume that same `CaseRecord`. Switching roles must not create a new case.
8. Status buttons call `api.status(record,nextStatus)`, then replace the displayed record with the server response. Refresh the queue if visible. On `409`, reload the case. Add-note/dispatch handlers follow the same pattern and append server events, not browser-only timeline items.
9. Keep errors inline, use skeletons while fetching, and render null threshold/citation states honestly. Show status text plus icons, not color alone. Keep the simulated-data badge and recommendation notice on every view.

Example submit logic inside your form component (adapt `form`/`setCase` to your existing state):

```tsx
const [busy, setBusy] = useState(false);
const [error, setError] = useState<string | null>(null);
const pending = useRef<{ requestId: string; formKey: string } | null>(null);

async function submit() {
  if (busy) return;
  setBusy(true); setError(null);
  const formKey = JSON.stringify(form);
  if (!pending.current || pending.current.formKey !== formKey) {
    pending.current = { requestId: crypto.randomUUID(), formKey };
  }
  try {
    const record = await api.submit({
      ...form,
      request_id: pending.current.requestId,
      // datetime-local is timezone-free. Demo's time is explicitly Mumbai.
      since: `${form.since}:00+05:30`, // form.since format YYYY-MM-DDTHH:mm
    });
    pending.current = null;
    setCase(record);
    setActiveTab('my-case');
  } catch (e) {
    setError(e instanceof Error ? e.message : 'Could not submit. Try again.');
  } finally { setBusy(false); }
}
```

React imports: `useState`, `useRef`. Clear `pending.current` on reset/scenario change. Changing form fields after failure starts a new request, rather than reusing a key for different input. For real-time mode, convert local user input with an appropriate timezone-aware datetime function; the explicit `+05:30` concatenation above is for the Mumbai demo only.

## 8. Workflow and consistency

`reported → located → assigned → in_progress → resolved`.

An analysis returning a suggested route is **not an assignment**. Initial successful POST returns `located`, with reported and located timeline entries. Assign advances to `assigned`; repair work advances to `in_progress`. Require an explicit action to resolve. Dispatch logs an action; it does not magically change status unless your backend performs both writes in one transaction.

`update_status()` locks the case row, validates `expected_version`, applies the allowed next step, increments version, and appends an event in the same transaction. Thus two open Authority views cannot silently overwrite each other. Derive the event actor on the server (`demo_authority` for this private demo), not from a client-supplied claim. All mutating handlers must use this convention; direct database writes could bypass the helper's workflow checks.

Events have both simulated `event_at` and real `recorded_at`; cases have real processing times for performance metrics. Use real `located_at - created_at` for time to locate; use scenario clock and complaint `submitted_at` for reported age. Timestamp ties in demo history are ordered using event ID.

No automatic external notification is implemented. “Routed to BMC” means an internal recommended responsibility, not that BMC has received a real report.

## 9. Thresholds, anomalies and sources

- Store lower and upper bounds: pH is a range; chlorine can have a lower-bound requirement with context. Do not implement every parameter as `value > max`.
- Keep acceptable and permissible limits separate, including applicability and edition. Do not silently fall back to a permissible limit to display green.
- Add only limits manually verified against the actual source. Record exact unit, page/clause, source URL and verification time. `minimum` or `maximum` may be null for a one-sided limit. Retrieve only verified passages. Keep WHO guidance identifiable as guidance rather than labeling it a BIS legal requirement.
- No “near limit” verdict is implemented here because its margin is undefined. If you add one, define a documented application rule; do not imply it is a standard category.
- `within_limit` means **this measured parameter at this node/time** is within the selected limit. These four sensors cannot certify that water is potable or free from pathogens.
- For rolling z-score, use the previous N readings of the same node/parameter, excluding the current point and all future rows. Choose N=24 for this demo, require at least 12 prior samples, and return null when history is insufficient or standard deviation is zero. Store N and the threshold (e.g. `abs(z)>3`) with the analysis; show them in the chart caption.
- Statistical anomaly and standards breach are separate flags. Display both. Filter chart data at `as_of`; missing/stale values are unknown, not zero or safe. A demo freshness rule such as age > 90 minutes is an application choice, not a drinking-water standard.
- For a few verified clauses, start with parameter-to-passage lookup. RAG/embeddings are optional. Never generate a missing clause. A citation card should say “No matching verified passage” when lookup is empty.
- Meter reading has no unit/type in the supplied plan. Keep it informational until the team defines what it measures; never use it as a water-quality sensor value.

## 10. Build order for your 7-hour event

1. Backend member: run schema/importer; implement scenario, network and get-case routes.
2. Frontend member: use `frontend_api.ts`, intake form and shared case detail; keep other screens mocked until core flow works.
3. Data member: implement as-of evidence queries and all four localization branches; test deduplicated building counts.
4. Compliance/glue member: enter verified clauses/limits; add threshold checks and citations to analysis snapshots.
5. Connect POST intake end to end; then status/action writes and shared timeline.
6. Add conditions/chart, queue filters and directory. Leave PDF, live subscriptions and vector search until after core scenarios pass.

Minimum acceptance checks:

- Seed import twice: counts unchanged, no duplicate sensor records.
- Pipeline S2: two distinct buildings under `seg_02` counted within two hours; old/future reports excluded.
- S1: plant anomaly visible at its Nov 5 clock; S2/S3 never use that old spike as the latest reading.
- S3: one household; no corroborating neighbors; household recommendation qualified by evidence availability.
- Add a separate building-only fixture to test that branch.
- Same request retry: exactly one complaint/case; same case ID.
- Different sessions cannot contaminate each other's new complaints or case lists. This is demo isolation, not security.
- Invalid/stale status update: no partial status/event write; `409` on stale version.
- Both role views show the same updated record/timeline; browser reload retains it.
- Missing standard or stale reading produces unknown/not-evaluated UI; no invented clause or green verdict.
- Browser bundle contains no database URI or privileged key.

## 11. Validation and limits of this delivery

See `VALIDATION.md` for checks actually run. This starter has not been connected to your Supabase project or existing frontend. API routes, localization/anomaly functions, verified standards and deployment still need implementation by your team; the guide and repository helpers define how to connect them.

Official references checked for this design:

- [Supabase database connection guide](https://supabase.com/docs/guides/database/connecting-to-postgres)
- [Supabase row level security](https://supabase.com/docs/guides/database/postgres/row-level-security)
- [PostgreSQL constraints](https://www.postgresql.org/docs/current/ddl-constraints.html)
- [FastAPI CORS](https://fastapi.tiangolo.com/tutorial/cors/)
