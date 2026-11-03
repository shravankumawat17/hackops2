"""One-process startup: build React, initialize missing seed DB, serve UI and API."""
import argparse,subprocess,sys,shutil
from pathlib import Path
ROOT=Path(__file__).resolve().parent
parser=argparse.ArgumentParser();parser.add_argument('--port',type=int,default=8002);parser.add_argument('--skip-build',action='store_true');args=parser.parse_args()
if not (ROOT/'imported-backend/hackops2/hackops.db').exists():subprocess.run([sys.executable,'backend/import_uploaded.py'],cwd=ROOT,check=True)
if not args.skip_build:
 npm=shutil.which('npm.cmd') or shutil.which('npm')
 if not npm:raise SystemExit('Node/npm is required. Install frontend dependencies with npm --prefix frontend install.')
 subprocess.run([npm,'--prefix','frontend','run','build'],cwd=ROOT,check=True)
print(f'Open http://127.0.0.1:{args.port} (React and API served together)',flush=True)
subprocess.run([sys.executable,'-m','uvicorn','integration:app','--app-dir',str(ROOT/'backend'),'--host','127.0.0.1','--port',str(args.port)],cwd=ROOT,check=True)
