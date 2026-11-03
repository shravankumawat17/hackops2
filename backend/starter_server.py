"""Local integration of the supplied starter dataset. No production authentication."""
import csv,json,sqlite3,uuid,statistics,math
from pathlib import Path
from datetime import datetime,timedelta,timezone
from fastapi import FastAPI,Header,HTTPException,Request
from fastapi.responses import JSONResponse
from fastapi.middleware.cors import CORSMiddleware
ROOT=Path(__file__).resolve().parents[1]
DATA=ROOT/'AquaTrace_Database_Starter/aquatrace_database/data'
NODES=json.loads((DATA/'graph.json').read_text())['nodes']; INDEX={n['id']:n for n in NODES}
READINGS=list(csv.DictReader((DATA/'readings.csv').open()))
SCENARIOS=json.loads((DATA/'scenarios.json').read_text()); SEEDS=json.loads((DATA/'complaints.json').read_text())
DB=Path(__file__).with_name('starter_cases.sqlite3')
def conn():
 c=sqlite3.connect(DB);c.row_factory=sqlite3.Row;return c
with conn() as c:
 c.executescript('CREATE TABLE IF NOT EXISTS sessions(id TEXT PRIMARY KEY,scenario TEXT NOT NULL); CREATE TABLE IF NOT EXISTS cases(id INTEGER PRIMARY KEY AUTOINCREMENT,session TEXT,request_id TEXT UNIQUE,payload TEXT,record TEXT); CREATE TABLE IF NOT EXISTS samples(id TEXT PRIMARY KEY,payload TEXT);')
app=FastAPI(title='AquaTrace starter integration')
app.add_middleware(CORSMiddleware,allow_origins=['http://127.0.0.1:5174','http://127.0.0.1:5173','http://localhost:5173'],allow_methods=['GET','POST','PATCH'],allow_headers=['Content-Type','X-Demo-Session'])
@app.exception_handler(HTTPException)
async def error_handler(request,exc):return JSONResponse(status_code=exc.status_code,content={'error':{'code':str(exc.status_code),'message':str(exc.detail)}})
def dt(s):
 d=datetime.fromisoformat(s);return d.replace(tzinfo=timezone(timedelta(hours=5,minutes=30))) if not d.tzinfo else d

def session(s):
 try:uuid.UUID(s or '')
 except ValueError:raise HTTPException(400,'A valid session is required.')
 with conn() as c:r=c.execute('SELECT scenario FROM sessions WHERE id=?',(s,)).fetchone()
 if not r:raise HTTPException(409,'Select a scenario first.')
 return next(x for x in SCENARIOS if x['id']==r['scenario'])
def path(node):
 result=[]
 while node:
  n=INDEX.get(node)
  if not n:break
  result.append(n);node=n['parent']
 return result

def latest(node,now):
 rows=[r for r in READINGS if r['node_id']==node and dt(r['timestamp'])<=dt(now)]
 return max(rows,key=lambda r:dt(r['timestamp'])) if rows else None

def analysis(hh,sc,s):
 chain=path(hh);plant=next((n for n in chain if n['type']=='plant'),None);segment=next(n for n in chain if n['type']=='street_segment');building=INDEX[hh]['parent'];now=dt(sc['now'])
 reading=latest(plant['id'],sc['now']) if plant else None
 evidence=[];anomaly=False;z=None
 if reading:
  history=sorted([r for r in READINGS if r['node_id']==plant['id'] and dt(r['timestamp'])<dt(reading['timestamp'])],key=lambda r:dt(r['timestamp']))[-24:]
  values=[float(r['turbidity_ntu']) for r in history]
  if len(values)>=12 and statistics.pstdev(values)>0:z=(float(reading['turbidity_ntu'])-statistics.mean(values))/statistics.pstdev(values);anomaly=abs(z)>3
  evidence.append(f"Plant turbidity {reading['turbidity_ntu']} NTU at {reading['timestamp']} (Mumbai). Z-score: {round(z,2) if z is not None else 'insufficient baseline'}; previous {len(values)} samples, anomaly rule |z| > 3.")
 with conn() as c:live=[json.loads(r['payload']) for r in c.execute('SELECT payload FROM cases WHERE session=?',(s,))]
 reports=[r for r in SEEDS if r['scenario'] in [sc['id'],'background'] and now-timedelta(hours=2)<=dt(r['submitted_at'])<=now]+live
 households={hh}|{r['household_node'] for r in reports if r['household_node'] in INDEX}
 buildings={INDEX[h]['parent'] for h in households if any(n['id']==segment['id'] for n in path(h))}
 same={h for h in households if INDEX[h]['parent']==building}
 stale=not reading or (now-dt(reading['timestamp'])).total_seconds()>5400
 if stale:stage,owner,node='undetermined','manual_review',None
 elif anomaly:stage,owner,node='plant_source','plant_operators',plant['id']
 elif len(buildings)>=2:stage,owner,node='distribution_pipeline','bmc',segment['id']
 elif len(same)>=2:stage,owner,node='building','housing_society',building
 else:stage,owner,node='household','citizen',hh
 evidence.append(f'{len(buildings)} distinct buildings on {segment["id"]}; {len(same)} distinct households in {building}. Two-hour seed evidence window; this session reports included once per household.')
 evidence.append('Standard not configured. Compliance not evaluated. Reported neighbor concerns are context, not independent corroboration.')
 return dict(located_node=node,fault_stage=stage,routed_to=owner,confidence='low' if stale else 'medium',evidence=evidence,standard_cited=None,threshold_check=None,citations=[],threshold_checks=[],anomaly_summary={'z_score':z,'is_anomaly':anomaly,'baseline_count':len(values) if reading else 0})
@app.get('/api/network')
def network(x_demo_session:str=Header(None)):
 sc=session(x_demo_session);nodes=[]
 for n in NODES:
  r=latest(n['id'],sc['now']);nodes.append({**n,'readings':r,'age_minutes':round((dt(sc['now'])-dt(r['timestamp'])).total_seconds()/60) if r else None})
 return {'nodes':nodes}
@app.get('/api/scenarios')
def scenarios():return [{'id':s['id'],'now':s['now'],'label':s['id'].replace('_',' ')} for s in SCENARIOS]
@app.post('/api/demo/scenario')
def select(data:dict,x_demo_session:str=Header(None)):
 try:uuid.UUID(x_demo_session or '')
 except ValueError:raise HTTPException(400,'Invalid session ID.')
 sc=next((s for s in SCENARIOS if s['id']==data.get('scenario_id')),None)
 if not sc:raise HTTPException(422,'Unknown scenario.')
 with conn() as c:
  old=c.execute('SELECT scenario FROM sessions WHERE id=?',(x_demo_session,)).fetchone()
  if old and old['scenario']!=sc['id']:raise HTTPException(409,'Start a fresh session to switch scenarios.')
  c.execute('INSERT OR IGNORE INTO sessions VALUES (?,?)',(x_demo_session,sc['id']))
 return {'scenario_id':sc['id'],'now':sc['now']}
@app.get('/api/cases')
def cases(x_demo_session:str=Header(None)):
 session(x_demo_session)
 with conn() as c:return [json.loads(r['record']) for r in c.execute('SELECT record FROM cases WHERE session=? ORDER BY id DESC LIMIT 100',(x_demo_session,))]
def get_record(c,id,s):
 r=c.execute('SELECT * FROM cases WHERE session=? AND id=?',(s,int(id.removeprefix('WQ-')) if id.removeprefix('WQ-').isdigit() else -1)).fetchone()
 if not r:raise HTTPException(404,'Case not found in this session.')
 return r,json.loads(r['record'])
@app.get('/api/cases/{id}')
def get_case(id:str,x_demo_session:str=Header(None)):
 session(x_demo_session)
 with conn() as c:return get_record(c,id,x_demo_session)[1]
@app.post('/api/complaints')
def submit(data:dict,x_demo_session:str=Header(None)):
 sc=session(x_demo_session)
 try:
  uuid.UUID(data['request_id']);hh=data['household_node']
  assert INDEX[hh]['type']=='household'
  assert data['symptom'] in ['brown_discolored','cloudy','bad_smell','bad_taste','particles']
  assert data['taps_affected'] in ['all','hot_only','single_tap']
  assert isinstance(data['illness_reported'],bool)
  assert data.get('neighbors_affected') is None or isinstance(data['neighbors_affected'],bool)
  assert dt(data['since'])<=dt(sc['now'])
  assert len(data.get('description',''))<=2000
 except (KeyError,ValueError,AssertionError):raise HTTPException(422,'Check the household, symptom, onset date, and report fields.')
 payload=json.dumps(data,sort_keys=True)
 with conn() as c:
  old=c.execute('SELECT * FROM cases WHERE request_id=?',(data['request_id'],)).fetchone()
  if old:
   if old['session']!=x_demo_session or old['payload']!=payload:raise HTTPException(409,'Request ID already used with different input.')
   return json.loads(old['record'])
  result=analysis(hh,sc,x_demo_session);cur=c.execute('INSERT INTO cases(session,request_id,payload) VALUES(?,?,?)',(x_demo_session,data['request_id'],payload));id=f'WQ-{cur.lastrowid:03d}'
  record={**data,**result,'case_id':id,'status':'located','version':1,'submitted_at':sc['now'],'created_at':datetime.now(timezone.utc).isoformat(),'timeline':[{'ts':sc['now'],'event':'Report received; evidence assessed. Responsibility is a recommendation, not an external notification.','by':'AquaTrace'}],'actions':[]}
  c.execute('UPDATE cases SET record=? WHERE id=?',(json.dumps(record),cur.lastrowid))
 return record
@app.patch('/api/cases/{id}/status')
def status(id:str,data:dict,x_demo_session:str=Header(None)):
 sc=session(x_demo_session)
 with conn() as c:
  c.execute('BEGIN IMMEDIATE');row,r=get_record(c,id,x_demo_session)
  if data.get('expected_version')!=r['version']:raise HTTPException(409,'This case changed. Reload it and try again.')
  allowed={'located':'assigned','assigned':'in_progress','in_progress':'resolved'}
  if allowed.get(r['status'])!=data.get('status'):raise HTTPException(422,'Advance one workflow step at a time.')
  r['status']=data['status'];r['version']+=1;r['timeline'].append({'ts':sc['now'],'event':'Status changed to '+r['status'],'by':'Local authority'})
  c.execute('UPDATE cases SET record=? WHERE id=?',(json.dumps(r),row['id']))
 return r
@app.post('/api/cases/{id}/actions')
def action(id:str,data:dict,x_demo_session:str=Header(None)):
 sc=session(x_demo_session)
 if data.get('kind') not in ['note','dispatch'] or not 3<=len(data.get('text','').strip())<=2000:raise HTTPException(422,'Enter a valid action note.')
 with conn() as c:
  c.execute('BEGIN IMMEDIATE');row,r=get_record(c,id,x_demo_session)
  if data.get('expected_version')!=r['version']:raise HTTPException(409,'This case changed. Reload it and try again.')
  event={'ts':sc['now'],'event':data['kind']+': '+data['text'],'by':'Local workspace'};r['timeline'].append(event);r['actions'].append(event);r['version']+=1;c.execute('UPDATE cases SET record=? WHERE id=?',(json.dumps(r),row['id']))
 return r
@app.get('/api/standards')
def standards():return []
@app.get('/api/health')
def health():return {'storage':'local SQLite','source':'AquaTrace_Database_Starter','nodes':len(NODES),'readings':len(READINGS),'seed_complaints':len(SEEDS)}
