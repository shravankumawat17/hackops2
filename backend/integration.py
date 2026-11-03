"""Bridge the uploaded backend's contract to the existing React application."""
import importlib.util,sys,json,uuid
from pathlib import Path
from fastapi import HTTPException
from pydantic import BaseModel,Field
ROOT=Path(__file__).resolve().parents[1];BASE=ROOT/'imported-backend/hackops2'
spec=importlib.util.spec_from_file_location('uploaded_engine',BASE/'backend/__init__.py',submodule_search_locations=[str(BASE/'backend')]);module=importlib.util.module_from_spec(spec);sys.modules['uploaded_engine']=module;spec.loader.exec_module(module)
from uploaded_engine import app as engine
from contextlib import closing
from uploaded_engine.db import connect as raw_connect,all_rows,one,demo_now,iso
from routing import locate,route_case,packet
def connect():return closing(raw_connect())
from priority_queue import queue as priority_queue
app=engine.app
from authentication import router as auth_router,identity,current,authenticate,filter_queue,can_read
from fastapi import Request
from fastapi.responses import JSONResponse
app.include_router(auth_router)
@app.middleware('http')
async def require_credentials(request:Request,call_next):
 path=request.url.path
 if not path.startswith('/api/') or path in ['/api/auth/login','/api/auth/register','/api/health','/api/integration/connection']:return await call_next(request)
 try:
  user=authenticate(request.headers.get('authorization',''))
  role=user['role']
  if '/cases/' in path:
   case_id=path.split('/cases/')[1].split('/')[0]
   with connect() as c:
    if not can_read(c,case_id,user):raise HTTPException(403,'This case is outside your workspace.')
   if role=='citizen' and request.method!='GET' and not path.endswith('/actions'):raise HTTPException(403,'Only the responsible team can change case status.')
  if path.endswith('/approve') and role!='authority':raise HTTPException(403,'Advisory approval requires authority access.')
  if path.startswith('/api/trace/'):
   with connect() as c:
    if not can_read(c,path.rsplit('/',1)[-1],user):raise HTTPException(403,'This case is outside your workspace.')
  if path=='/api/complaints' and request.method=='GET' and role!='authority':raise HTTPException(403,'Complaint records require authority access.')
  if path in ['/api/cluster/run','/api/integration/scenario'] and role!='authority':raise HTTPException(403,'This action requires authority access.')
  if path.startswith('/api/integration/samples') and role!='industry':raise HTTPException(403,'Facility samples require industry access.')
  if path in ['/api/geo/reports','/api/integration/submit','/api/complaints'] and request.method=='POST' and role!='citizen':raise HTTPException(403,'Submit reports through a citizen account.')
  if path in ['/api/cases','/api/hotspots'] and role!='authority':raise HTTPException(403,'Use your workspace queue.')
  marker=identity.set(user)
  try:return await call_next(request)
  finally:identity.reset(marker)
 except HTTPException as e:return JSONResponse(status_code=e.status_code,content={'detail':e.detail})

@app.get('/api/integration/bootstrap')
def bootstrap():
 with connect() as c:
  records=filter_queue(c,priority_queue(c));network=engine.network(c)
  if current()['role']!='authority':
   allowed={p['case']['node_id'] for p in records}
   network['nodes']=[n for n in network['nodes'] if not n['id'].startswith('address_') or n['id'] in allowed]
  return {'network':network,'cases':records,'meta':engine.meta(c)}
class Intake(BaseModel):
 building_node_id:str
 category:str=Field(min_length=1,max_length=100)
 text:str=Field('',max_length=2000)
 request_id:uuid.UUID
@app.post('/api/integration/submit')
def submit(data:Intake):
 with connect() as c:
  c.execute('CREATE TABLE IF NOT EXISTS integration_requests(id TEXT PRIMARY KEY,payload TEXT,case_id TEXT)')
  payload=json.dumps(data.model_dump(mode='json'),sort_keys=True);old=one(c,'SELECT * FROM integration_requests WHERE id=?',(str(data.request_id),))
  if old:
   if not can_read(c,old['case_id'],current()):raise HTTPException(403,'Request belongs to another account.')
   if old['payload']!=payload:raise HTTPException(409,'Request ID used with different input.')
   return packet(c,old['case_id'])
  created=engine.create_complaint(engine.ComplaintIn(building_node_id=data.building_node_id,category=data.category,text=data.text),c)
  decision=locate(c,data.building_node_id)
  if decision['stage']=='plant':
   evidence=engine.rules._evidence(c,decision['node_id'],[created['complaint']],decision['evidence'])
   evidence['routing']=decision
   _,plant_case=engine.rules._upsert_case(c,decision['node_id'],'MUNICIPAL','High','Treatment plant investigation',decision['evidence'],evidence);c.commit()
  else:engine.rules.run(c,window_hours=2,min_buildings=2)
  cid=created['complaint']['id'];found=None
  for r in all_rows(c,'SELECT * FROM cases'):
   if cid in json.loads(r['evidence_json']).get('complaint_ids',[]):found=r['id'];break
  if not found:
   evidence=engine.rules._evidence(c,data.building_node_id,[created['complaint']],'Insufficient corroborating evidence. Manual inspection required.')
   _,found=engine.rules._upsert_case(c,data.building_node_id,'UNDETERMINED','Low','Inspection requested','Manual review',evidence);c.commit()
  route_case(c,found,data.building_node_id)
  c.execute('INSERT OR IGNORE INTO case_owners VALUES(?,?)',(found,current()['id']))
  c.execute('INSERT INTO integration_requests VALUES(?,?,?)',(str(data.request_id),payload,found));c.commit();return packet(c,found)
@app.get('/api/integration/readings/{id}')
def readings(id:str):
 with connect() as c:
  engine._node(c,id);return all_rows(c,'SELECT r.* FROM readings r JOIN sensors s ON s.id=r.sensor_id WHERE s.node_id=? AND timestamp<=? ORDER BY timestamp',(id,iso(demo_now(c))))

@app.get('/api/integration/cases/{id}')
def routed_detail(id:str):
 with connect() as c:return packet(c,id)

@app.post('/api/integration/scenario')
def scenario(data:dict):
 clocks={'plant':'2026-11-05 21:00:00','pipeline':'2026-11-06 20:00:00','home':'2026-11-07 11:00:00'}
 if data.get('scenario') not in clocks:raise HTTPException(422,'Unknown synthetic evidence scenario.')
 with connect() as c:
  c.execute("UPDATE meta SET value=? WHERE key='scenario_now'",(clocks[data['scenario']],));c.commit()
 return bootstrap()

# Industry samples have their own persistence; recording does not change seeded sensors.
from typing import Literal
from datetime import datetime,timezone
from fastapi.staticfiles import StaticFiles
class SampleIn(BaseModel):
 facility:Literal['treatment','wastewater']
 point:str=Field(min_length=1,max_length=120)
 ph:float=Field(ge=0,le=14,allow_inf_nan=False)
 turbidity:float=Field(ge=0,le=1000,allow_inf_nan=False)
 tds:float=Field(ge=0,le=10000,allow_inf_nan=False)
 chlorine:float=Field(ge=0,le=20,allow_inf_nan=False)
 notes:str=Field('',max_length=1000)
def sample_table(c):
 c.execute('CREATE TABLE IF NOT EXISTS facility_samples(id TEXT PRIMARY KEY,record TEXT NOT NULL)');c.commit()
@app.get('/api/integration/samples')
def samples():
 with connect() as c:
  sample_table(c);return [record for r in all_rows(c,'SELECT record FROM facility_samples ORDER BY rowid DESC') if (record:=json.loads(r['record'])).get('account_id')==current()['id']]
@app.post('/api/integration/samples',status_code=201)
def save_sample(data:SampleIn):
 record={**data.model_dump(),'account_id':current()['id'],'id':str(uuid.uuid4()),'time':datetime.now(timezone.utc).isoformat()}
 with connect() as c:
  sample_table(c);c.execute('INSERT INTO facility_samples VALUES(?,?)',(record['id'],json.dumps(record)));c.commit()
 return record
@app.get('/api/integration/connection')
def connection():
 with connect() as c:
  return {'service':'aquatrace-integration','version':2,'storage':'SQLite compatibility database','nodes':one(c,'SELECT count(*) AS total FROM nodes')['total'],'clock':iso(demo_now(c))}
from geography import router as geo_router
app.include_router(geo_router)
@app.get('/api/integration/queue')
def report_queue():
 with connect() as c:return filter_queue(c,priority_queue(c))

app.router.routes[:]=[r for r in app.router.routes if getattr(r,'path',None) not in ['/api/cases/{case_id}/status','/api/cases/{case_id}/actions']]
@app.patch('/api/cases/{case_id}/status')
def authenticated_status(case_id:str,payload:engine.StatusIn):
 with connect() as c:
  existing=engine._case(c,case_id)
  if existing['status']==payload.status:
   if payload.note:engine.add_action(case_id,engine.ActionIn(actor=current()['name'],role=current()['role'],action='Case note',note=payload.note),c)
   return {'case':existing}
  payload.actor=current()['name'];payload.role=current()['role'];return engine.update_status(case_id,payload,c)
@app.post('/api/cases/{case_id}/actions')
def authenticated_action(case_id:str,payload:engine.ActionIn):
 payload.actor=current()['name'];payload.role=current()['role']
 with connect() as c:return engine.add_action(case_id,payload,c)
from facility import router as facility_router
app.include_router(facility_router)

# The uploaded / route pointed at an excluded legacy web folder. Serve React instead.
app.router.routes[:]=[r for r in app.router.routes if getattr(r,'path',None) not in ['/','/static']]
DIST=ROOT/'frontend/dist'
if DIST.is_dir():app.mount('/',StaticFiles(directory=str(DIST),html=True),name='react')
