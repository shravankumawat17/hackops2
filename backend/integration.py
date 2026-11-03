"""Bridge the uploaded backend's contract to the existing React application."""
import importlib.util,sys,json,uuid
from pathlib import Path
from fastapi import HTTPException
from pydantic import BaseModel,Field
ROOT=Path(__file__).resolve().parents[1];BASE=ROOT/'imported-backend/hackops2'
spec=importlib.util.spec_from_file_location('uploaded_engine',BASE/'backend/__init__.py',submodule_search_locations=[str(BASE/'backend')]);module=importlib.util.module_from_spec(spec);sys.modules['uploaded_engine']=module;spec.loader.exec_module(module)
from uploaded_engine import app as engine
from uploaded_engine.db import connect,all_rows,one,demo_now,iso
app=engine.app
@app.get('/api/integration/bootstrap')
def bootstrap():
 with connect() as c:
  return {'network':engine.network(c),'cases':[engine.case_detail(r['id'],c) for r in engine.cases(c)],'meta':engine.meta(c)}
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
   if old['payload']!=payload:raise HTTPException(409,'Request ID used with different input.')
   return engine.case_detail(old['case_id'],c)
  created=engine.create_complaint(engine.ComplaintIn(building_node_id=data.building_node_id,category=data.category,text=data.text),c)
  engine.rules.run(c,window_hours=2,min_buildings=2)
  cid=created['complaint']['id'];found=None
  for r in all_rows(c,'SELECT * FROM cases'):
   if cid in json.loads(r['evidence_json']).get('complaint_ids',[]):found=r['id'];break
  if not found:
   evidence=engine.rules._evidence(c,data.building_node_id,[created['complaint']],'Insufficient corroborating evidence. Manual inspection required.')
   _,found=engine.rules._upsert_case(c,data.building_node_id,'UNDETERMINED','Low','Inspection requested','Manual review',evidence);c.commit()
  c.execute('INSERT INTO integration_requests VALUES(?,?,?)',(str(data.request_id),payload,found));c.commit();return engine.case_detail(found,c)
@app.get('/api/integration/readings/{id}')
def readings(id:str):
 with connect() as c:
  engine._node(c,id);return all_rows(c,'SELECT r.* FROM readings r JOIN sensors s ON s.id=r.sensor_id WHERE s.node_id=? AND timestamp<=? ORDER BY timestamp',(id,iso(demo_now(c))))
