# Uploaded backend integration

The React frontend now uses the FastAPI backend supplied in `hackops2.zip`. Selected source files are extracted under `imported-backend/hackops2/`; archive Git metadata and old web UI were excluded.

Run from the repository root:

```powershell
python -m pip install fastapi uvicorn httpx
python backend/import_uploaded.py
python -m uvicorn integration:app --app-dir backend --host 127.0.0.1 --port 8001
```

In another terminal:

```powershell
cd frontend
npm run dev -- --port 5174
```

Open http://127.0.0.1:5174. The Vite proxy sends `/api` to port 8001. Use the existing local workspace login.

The importer creates an isolated SQLite compatibility database only if absent. It imports all 33 nodes, 672 readings and 14 complaints from AquaTrace_Database_Starter. Plant/street/building types and chlorine column names are translated to the uploaded schema; households remain distinct and intake targets a building. It never resets an existing database. The fixed evidence clock is November 6, 2026 at 20:00 Mumbai time. Latest-reading, forecast and clustering queries exclude later evidence.

Supabase's existing `aquatrace` schema remains intact. The uploaded backend uses SQLite; this integration does not claim that its writes reach Supabase. Moving that engine to Postgres requires porting its SQL and transaction handling, rather than sending server credentials to the browser.

Frontend cases, case history, submissions, updates and sensor values use HTTP. The bridge runs clustering after submission, reuses the backend's evidence and case engine, and deduplicates successful retries. A report without enough corroboration creates a manual-review case. Retrying after an interrupted partial write is not yet transactionally idempotent. No production authorization is provided by role selection. Industry sample drafts and profile preferences remain local because the supplied backend has no write APIs for them.

Uploaded configured limits are illustrative references requiring official verification; they are not verified regulatory certifications. The previous frontend standards guidance also requires verification.

Verification: `python backend/test_integration.py`, `npm run build` in frontend. The API test creates a synthetic complaint and updates its generated case in the compatibility database.
