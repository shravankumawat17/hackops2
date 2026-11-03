# Uploaded backend integration

The React frontend now uses the FastAPI backend supplied in `hackops2.zip`. Selected source files are extracted under `imported-backend/hackops2/`; archive Git metadata and old web UI were excluded.

Run from the repository root:

```powershell
python -m pip install fastapi uvicorn httpx
python backend/import_uploaded.py
python -m uvicorn integration:app --app-dir backend --host 127.0.0.1 --port 8002
```

In another terminal:

```powershell
cd frontend
npm run dev -- --port 5174
```

Open http://127.0.0.1:5174. The Vite proxy sends `/api` to port 8002. Use the existing local workspace login.

The importer creates an isolated SQLite compatibility database only if absent. It imports all 33 nodes, 672 readings and 14 complaints from AquaTrace_Database_Starter. Plant/street/building types and chlorine column names are translated to the uploaded schema; households remain distinct and intake targets a building. It never resets an existing database. The fixed evidence clock is November 6, 2026 at 20:00 Mumbai time. Latest-reading, forecast and clustering queries exclude later evidence.

Supabase's existing `aquatrace` schema remains intact. The uploaded backend uses SQLite; this integration does not claim that its writes reach Supabase. Moving that engine to Postgres requires porting its SQL and transaction handling, rather than sending server credentials to the browser.

Frontend cases, case history, submissions, updates and sensor values use HTTP. The bridge runs clustering after submission, reuses the backend's evidence and case engine, and deduplicates successful retries. A report without enough corroboration creates a manual-review case. Retrying after an interrupted partial write is not yet transactionally idempotent. No production authorization is provided by role selection. Industry sample drafts and profile preferences remain local because the supplied backend has no write APIs for them.

Uploaded configured limits are illustrative references requiring official verification; they are not verified regulatory certifications. The previous frontend standards guidance also requires verification.

Verification: `python backend/test_integration.py`, `npm run build` in frontend. The API test creates a synthetic complaint and updates its generated case in the compatibility database.

Routing fix: backend/routing.py prioritizes upstream plant evidence, then counts distinct buildings on the shared segment. API packets include recipient role, owner and evidence. Industry receives plant cases; authorities coordinate pipeline/building/manual-review cases. The evidence selector changes the shared synthetic clock, so use it only in this local environment. Client queues refresh on role change, focus and every ten seconds. Workspace selection is not production authorization.


## Connection audit and reliable startup

From the repository root, run `python run.py`. This builds React, initializes the compatibility database only if missing, and serves UI plus API at http://127.0.0.1:8002. If that port is occupied, use `python run.py --port 8003`. Do not open frontend/index.html directly. `--skip-build` reuses an existing frontend/dist build.

Development: start `python -m uvicorn integration:app --app-dir backend --port 8002`, then `npm --prefix frontend run dev`. Vite uses strict port 5174. Preview now proxies /api too. Override AQUATRACE_API_TARGET when the backend runs on a different port. A production deployment must serve /api with the application or configure a reverse proxy; a static-file host alone cannot run Python.

GET /api/integration/connection identifies the active service/version/storage and node count. Industry samples now persist in SQLite facility_samples through GET/POST /api/integration/samples; they no longer depend on localStorage. They are separate operator-submitted records, not replacements for seeded network telemetry. API errors/timeouts are shown inline and failed forms retain their inputs.

Additional checks: python backend/test_connectivity.py; node tests/connectivity-browser.mjs from frontend (combined server on 8003). These cover same-origin delivery, sample persistence/reload, numeric validation and API failure handling.

## Report geography and neighborhood density

The community and network maps now overlay complaint coordinates. All reports up to the synthetic dataset clock are shown by default, with a past-24-hour filter on the dashboard. A radius is 500 metres; 2–4 reports show amber and 5+ show red. Reports are counted, not verified people. Successful request retries do not add complaints. Nearby counts are geographic evidence only and do not certify contamination or supply connectivity.

The area catalogue provides approximate centers for Kandivali, Malad, Borivali, Andheri, Dadar, Bandra, Powai, Bhandup and Goregaon, plus a custom-location option. This is a starter locality catalogue, not an exhaustive address registry or geocoder. Users enter any building/street address and confirm or move its pin. Mumbai bounds are validated server-side. Custom addresses create standalone building nodes with no invented supply parent, so cases route to municipal manual review until mapped to a verified branch.

New endpoints: GET /api/geo/areas, GET /api/geo/reports?hours=24, GET /api/geo/nearby?lat=...&lon=..., POST /api/geo/reports. geo_reports persists coordinates and links each report to its case. Map responses omit building address and complaint text. These endpoints currently belong to the existing local development access model, not production authentication.

Run python backend/test_geography.py for isolated API checks. The browser workflow test is frontend/tests/geography-browser.mjs and defaults to the combined server at port 8004. Synthetic fixtures created by that test are labeled as browser verification reports.

## Authority report priority queue

The dashboard and case list now consume GET /api/integration/queue; bootstrap uses the same database query. The four-case dashboard cutoff has been removed. New custom-address reports are committed atomically to complaints, cases and geo_reports and appear in the shared municipal queue. Existing authority tabs refresh every five seconds and on focus; a same-browser update signal also refreshes other tabs.

Priority order: unresolved cases before resolved cases; then total persisted complaint count in the selected area (e.g. Kandivali), descending; then the number of reports within 500 metres; then newest insertion order. Counts include seed and submitted reports, not verified distinct people. The queue deliberately includes all persisted cases even when the synthetic evidence clock changes. Its all-time volume differs from the map's optional 24-hour evidence filter. Each row exposes rank, area count and nearby count; the selected locality is searchable.

Database storage remains the uploaded backend's SQLite compatibility database. No browser-only queue or Supabase synchronization is implied. Tests: python backend/test_priority_queue.py and frontend/tests/priority-browser.mjs (combined app default port 8005).

## Credential access and phase tracking

The website always opens at sign-in, including reloads. The legacy aq-session localStorage role is ignored. Access tokens are held only in page memory, never localStorage; backend sessions expire after one hour and logout revokes the token. Independent tabs can sign in to different workspaces. Credentials are validated by the backend; selecting a role alone grants no access.

Citizens register with a 10-digit Indian mobile identifier, full name and six-digit PIN. This does not verify control of the phone number: SMS/OTP delivery is not configured. Officer and industry accounts are issued administratively using Officer ID / Facility ID and a random access code. Initial local accounts are created by python backend/issue_accounts.py. Their codes are in backend/issued_credentials.txt, excluded from Git. Keep the file private and distribute credentials through a trusted channel. There are no default public codes. Lost credentials currently require administrative recovery; no fake reset-email flow is provided.

Secrets are salted and hashed with PBKDF2-SHA256 (310,000 iterations); sessions store only token hashes. Five failed sign-in attempts trigger a 15-minute account/identifier cooldown. Backend role checks protect status changes and facility samples. Citizen queues and case detail are restricted to linked case ownership; historical shared synthetic cases remain visible to authorities, not newly registered citizens. Operator samples are scoped to the issuing account. HTTPS and a verified identity/SMS provider are still needed before real-world deployment.

The case detail now shows a four-phase vertical application-status tracker: Submitted, Assigned, In progress, Resolved. Filled circles indicate completed phases, an outlined ring indicates the current phase, and empty circles indicate pending phases. Action history remains expandable below it. The tracker is derived from stored status, not the number of history events. Same-status notes no longer add a duplicate status-change event, and actor names come from authenticated accounts.

Tests: python backend/test_auth.py; authenticated legacy regression tests use backend/test_support.py. Browser check: node tests/auth-browser.mjs from frontend (expects port 8006). It reads the ignored issued-credential file without logging codes.

## Facility operations workspace

Industry navigation is now Facility overview, Sample register, Corrective cases and Equipment maintenance. The industry homepage has no map, geographic report feed, standards tab or duplicate notification centre. It displays the latest sample for the selected treatment/wastewater process, assigned plant/source cases, and equipment tasks due. Sample records, corrective cases and maintenance jobs have separate purposes; equipment completion does not automatically resolve a case or modify sensor data.

GET/POST /api/facility/maintenance and PATCH /api/facility/maintenance/{id} persist account-scoped jobs. Asset, task, process, due date, instructions, status and completion notes are retained. Updates require the current record version; stale updates return 409. Completion stores a real timestamp, independent of the synthetic dataset clock. Completed tasks cannot be reopened through this workflow. Facility samples remain account-scoped. Wastewater measurements do not receive a discharge-compliance verdict without permit-specific limits.

Verification: python backend/test_facility.py and frontend/tests/industry-browser.mjs (local app at port 8007). The browser check covers industry navigation, no map, sample entry, job scheduling/completion, persistence after re-login and mobile overflow.
