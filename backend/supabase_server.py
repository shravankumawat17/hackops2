import os,sys,uuid,statistics,math
from pathlib import Path
from datetime import datetime,timedelta,timezone
from typing import Literal
import psycopg
from psycopg.rows import dict_row
from psycopg.types.json import Jsonb
from dotenv import load_dotenv
from fastapi import FastAPI,Header,HTTPException
from fastapi.responses import JSONResponse
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel,Field,ConfigDict
ROOT=Path(__file__).resolve().parents[1]
sys.path.insert(0,str(ROOT/'AquaTrace_Database_Starter/aquatrace_database'))
from backend_reference import get_case,persist_analyzed_case,update_status
load_dotenv(Path(__file__).with_name('.env'))
def db():
 if not os.getenv('DATABASE_URL'):raise HTTPException(503,'Set DATABASE_URL in backend/.env and restart the backend.')
 return psycopg.connect(os.environ['DATABASE_URL'],autocommit=True,row_factory=dict_row,prepare_threshold=None,connect_timeout=10)
app=FastAPI(title='AquaTrace Supabase integration')
app.add_middleware(CORSMiddleware,allow_origins=['http://127.0.0.1:5174','http://127.0.0.1:5173'],allow_methods=['GET','POST','PATCH'],allow_headers=['Content-Type','X-Demo-Session'])
@app.exception_handler(HTTPException)
async def handled(req,e):return JSONResponse(status_code=e.status_code,content={'error':{'code':str(e.status_code),'message':str(e.detail)}})
@app.exception_handler(psycopg.Error)
async def database_error(req,e):return JSONResponse(status_code=503,content={'error':{'code':'DATABASE_UNAVAILABLE','message':'Database request failed. Check the backend connection and retry.'}})
def sid(value):
 try:return str(uuid.UUID(value or ''))
 except ValueError:raise HTTPException(400,'A valid session is required.')
def scope(c,s):
 r=c.execute('SELECT s.* FROM aquatrace.scenarios s JOIN aquatrace.demo_sessions d ON d.scenario_id=s.id WHERE d.id=%s',(sid(s),)).fetchone()
 if not r:raise HTTPException(409,'Select a scenario first.')
 return r
@app.get('/api/scenarios')
def scenarios():
 with db() as c:return c.execute("SELECT id,as_of AS now,replace(id,'_',' ') AS label FROM aquatrace.scenarios WHERE id <> 'background' ORDER BY id").fetchall()
@app.post('/api/demo/scenario')
def select(data:dict,x_demo_session:str=Header(None)):
 s=sid(x_demo_session)
 with db() as c:
  r=c.execute('SELECT id,as_of AS now FROM aquatrace.scenarios WHERE id=%s AND id<>%s',(data.get('scenario_id'),'background')).fetchone()
  if not r:raise HTTPException(422,'Unknown scenario.')
  c.execute('INSERT INTO aquatrace.demo_sessions(id,scenario_id) VALUES(%s,%s) ON CONFLICT DO NOTHING',(s,r['id']))
  sc=scope(c,s)
  if sc['id']!=r['id']:raise HTTPException(409,'Start a fresh session to change scenarios.')
  return {'scenario_id':r['id'],'now':r['now']}
@app.get('/api/network')
def network(x_demo_session:str=Header(None)):
 with db() as c:
  sc=scope(c,x_demo_session);nodes=c.execute('SELECT *,parent_id AS parent FROM aquatrace.nodes ORDER BY id').fetchall()
  for n in nodes:
   r=c.execute('SELECT *,observed_at AS timestamp FROM aquatrace.readings WHERE node_id=%s AND observed_at<=%s ORDER BY observed_at DESC LIMIT 1',(n['id'],sc['as_of'])).fetchone()
   n['readings']=r;n['age_minutes']=(sc['as_of']-r['observed_at']).total_seconds()/60 if r else None
  return {'nodes':nodes}
class Complaint(BaseModel):
 model_config=ConfigDict(extra='forbid')
 request_id:uuid.UUID
 household_node:str
 symptom:Literal['brown_discolored','cloudy','bad_smell','bad_taste','particles']
 description:str=Field('',max_length=2000)
 taps_affected:Literal['all','hot_only','single_tap']
 since:datetime
 neighbors_affected:bool|None=None
 illness_reported:bool=False
 meter_reading:float|None=Field(None,ge=0,allow_inf_nan=False)
def analyze(c,d,sc,s):
 nodes=c.execute('SELECT *,parent_id AS parent FROM aquatrace.nodes').fetchall();index={n['id']:n for n in nodes}
 def path(id):
  result=[]
  while id:result.append(index[id]);id=index[id]['parent']
  return result
 chain=path(d['household_node']);plant=next(n for n in chain if n['type']=='plant');segment=next(n for n in chain if n['type']=='street_segment');building=index[d['household_node']]['parent']
 history=c.execute('SELECT * FROM aquatrace.readings WHERE node_id=%s AND observed_at<=%s ORDER BY observed_at DESC LIMIT 25',(plant['id'],sc['as_of'])).fetchall()
 current=history[0] if history else None;values=[r['turbidity_ntu'] for r in history[1:] if r['turbidity_ntu'] is not None];z=None
 if current and current['turbidity_ntu'] is not None and len(values)>=12 and statistics.pstdev(values)>0:z=(current['turbidity_ntu']-statistics.mean(values))/statistics.pstdev(values)
 reports=c.execute('''SELECT complaint_id,household_node FROM aquatrace.complaints WHERE submitted_at>%s-interval '2 hours' AND submitted_at<=%s AND (request_id IS NULL OR request_id<>%s) AND ((is_seed AND scenario_id IN (%s,'background')) OR (NOT is_seed AND demo_session_id=%s AND scenario_id=%s))''',(sc['as_of'],sc['as_of'],d['request_id'],sc['id'],s,sc['id'])).fetchall()
 homes={d['household_node']}|{r['household_node'] for r in reports};buildings={index[h]['parent'] for h in homes if any(n['id']==segment['id'] for n in path(h))};same={h for h in homes if index[h]['parent']==building}
 stale=not current or (sc['as_of']-current['observed_at']).total_seconds()>5400
 if stale:stage,route,node='undetermined','manual_review',None
 elif z is not None and abs(z)>3:stage,route,node='plant_source','plant_operators',plant['id']
 elif len(buildings)>=2:stage,route,node='distribution_pipeline','bmc',segment['id']
 elif len(same)>=2:stage,route,node='building','housing_society',building
 else:stage,route,node='household','citizen',d['household_node']
 evidence=[{'kind':'sensor','text':f"Plant turbidity: {current['turbidity_ntu'] if current else 'unknown'} NTU. Z-score {round(z,2) if z is not None else 'unavailable'} from {len(values)} preceding samples; anomaly rule |z| > 3. Missing or older than 90 minutes requires manual review.",'node_id':plant['id'],'measured_at':current['observed_at'].isoformat() if current else None},{'kind':'complaint_cluster','text':f'{len(buildings)} distinct buildings on {segment["id"]}; {len(same)} households in {building}; preceding two-hour window. Incoming household counted once.','complaint_ids':[r['complaint_id'] for r in reports]},{'kind':'standard','text':'Standard not configured. Compliance not evaluated. Routing is a recommendation for human review.'}]
 return {'rule_version':'localization-v1','located_node':node,'fault_stage':stage,'routed_to':route,'confidence':'low' if stale else 'medium','evidence':evidence,'threshold_checks':[],'citations':[],'anomaly_summary':{'z_score':z,'baseline_count':len(values),'is_anomaly':z is not None and abs(z)>3}}
@app.post('/api/complaints')
def submit(data:Complaint,x_demo_session:str=Header(None)):
 s=sid(x_demo_session);d=data.model_dump()
 with db() as c:
  sc=scope(c,s)
  if not data.since.tzinfo or data.since>sc['as_of']:raise HTTPException(422,'Onset must have a timezone and be no later than the scenario clock.')
  n=c.execute("SELECT id FROM aquatrace.nodes WHERE id=%s AND type='household'",(data.household_node,)).fetchone()
  if not n:raise HTTPException(422,'Select a household from the network.')
  old=c.execute('SELECT * FROM aquatrace.complaints WHERE request_id=%s',(data.request_id,)).fetchone()
  if old:
   if str(old['demo_session_id'])!=s or any(old[k]!=v for k,v in d.items() if k!='request_id'):raise HTTPException(409,'Request ID already used with different input.')
  a=analyze(c,d,sc,s);id=persist_analyzed_case(c,d,a,sc['as_of'],s,sc['id']);return get_case(c,id,s)
@app.get('/api/cases')
def cases(x_demo_session:str=Header(None)):
 with db() as c:
  scope(c,x_demo_session);ids=c.execute('SELECT c.case_id FROM aquatrace.cases c JOIN aquatrace.complaints p USING(complaint_id) WHERE p.demo_session_id=%s ORDER BY c.id DESC LIMIT 100',(x_demo_session,)).fetchall();return [get_case(c,r['case_id'],x_demo_session) for r in ids]
@app.get('/api/cases/{id}')
def case(id:str,x_demo_session:str=Header(None)):
 with db() as c:
  scope(c,x_demo_session)
  try:return get_case(c,id,x_demo_session)
  except LookupError:raise HTTPException(404,'Case not found.')
@app.patch('/api/cases/{id}/status')
def status(id:str,data:dict,x_demo_session:str=Header(None)):
 with db() as c:
  sc=scope(c,x_demo_session)
  try:return update_status(c,id,x_demo_session,data.get('status'),data.get('expected_version'),'demo_authority',sc['as_of'])
  except LookupError:raise HTTPException(404,'Case not found.')
  except RuntimeError:raise HTTPException(409,'This case changed. Reload it and retry.')
  except ValueError:raise HTTPException(422,'Advance one workflow step at a time.')
@app.post('/api/cases/{id}/actions')
def action(id:str,data:dict,x_demo_session:str=Header(None)):
 if data.get('kind') not in ['note','dispatch'] or not 3<=len(data.get('text','').strip())<=2000:raise HTTPException(422,'Enter a valid action note.')
 with db() as c:
  sc=scope(c,x_demo_session)
  with c.transaction():
   row=c.execute('SELECT c.* FROM aquatrace.cases c JOIN aquatrace.complaints p USING(complaint_id) WHERE c.case_id=%s AND p.demo_session_id=%s FOR UPDATE OF c',(id,x_demo_session)).fetchone()
   if not row:raise HTTPException(404,'Case not found.')
   if row['version']!=data.get('expected_version'):raise HTTPException(409,'This case changed. Reload it and retry.')
   c.execute('UPDATE aquatrace.cases SET version=version+1,updated_at=now() WHERE id=%s',(row['id'],));c.execute("INSERT INTO aquatrace.case_events(case_id,event_type,event_at,actor,message) VALUES(%s,%s,%s,'demo_workspace',%s)",(row['id'],'note' if data['kind']=='note' else 'action',sc['as_of'],data['text']))
  return get_case(c,id,x_demo_session)
@app.get('/api/standards')
def standards():
 with db() as c:return c.execute('SELECT * FROM aquatrace.standard_passages WHERE verified_at IS NOT NULL').fetchall()
@app.get('/api/health')
def health():
 with db() as c:return {'storage':'Supabase PostgreSQL','nodes':c.execute('SELECT count(*) AS total FROM aquatrace.nodes').fetchone()['total']}
