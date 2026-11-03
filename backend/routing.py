"""Responsibility decisions for the uploaded synthetic supply network."""
from datetime import datetime,timedelta
import json
from uploaded_engine.db import all_rows,one,latest_reading,demo_now,iso

def locate(c,building):
 chain=[];node=one(c,'SELECT * FROM nodes WHERE id=?',(building,))
 while node:
  chain.append(node);node=one(c,'SELECT * FROM nodes WHERE id=?',(node['parent_id'],)) if node['parent_id'] else None
 plant=next((n for n in chain if n['type']=='treatment_plant'),None)
 reading=latest_reading(c,plant['id']) if plant else None
 if not reading or (demo_now(c)-datetime.fromisoformat(reading['timestamp'])).total_seconds()>5400:
  return {'stage':'undetermined','owner':'Manual review','role':'authority','node_id':building,'evidence':'Upstream plant reading missing or older than 90 minutes. Inspection required.'}
 # Application threshold from uploaded configuration; this is not a verified regulatory verdict.
 from uploaded_engine.db import load_config
 limit=load_config('limits.json')['parameters']['turbidity_ntu']['permissible_max']
 if reading['turbidity_ntu']>limit:
  return {'stage':'plant','owner':'Plant operators','role':'industry','node_id':plant['id'],'evidence':f"Plant {plant['id']} turbidity {reading['turbidity_ntu']} NTU at {reading['timestamp']} exceeds configured reference {limit} NTU. Upstream plant rule takes priority. Limits require verification."}
 segment=next((n for n in chain if n['type']=='junction'),None)
 rows=all_rows(c,'SELECT DISTINCT building_node_id FROM complaints WHERE timestamp>? AND timestamp<=?',(iso(demo_now(c)-timedelta(hours=2)),iso(demo_now(c))))
 buildings=set()
 for r in rows:
  b=one(c,'SELECT * FROM nodes WHERE id=?',(r['building_node_id'],))
  if b and segment and b['parent_id']==segment['id']:buildings.add(b['id'])
 if len(buildings)>=2:
  return {'stage':'pipeline','owner':'BMC / distribution maintenance','role':'authority','node_id':segment['id'],'evidence':f"Plant turbidity {reading['turbidity_ntu']} NTU is below configured reference {limit}. {len(buildings)} distinct buildings on {segment['id']} reported within two hours: {', '.join(sorted(buildings))}."}
 return {'stage':'building','owner':'Housing society / building maintenance','role':'authority','node_id':building,'evidence':f"Plant turbidity {reading['turbidity_ntu']} NTU is below configured reference {limit}; no multi-building cluster on the shared segment. Building inspection recommended. Household localization requires household-level evidence absent from this backend."}

def route_case(c,id,building):
 decision=locate(c,building);case=one(c,'SELECT * FROM cases WHERE id=?',(id,));e=json.loads(case['evidence_json'] or '{}');e['routing']=decision
 c.execute('UPDATE cases SET evidence_json=? WHERE id=?',(json.dumps(e),id));c.commit();return decision

def packet(c,id):
 from uploaded_engine import app as engine
 result=engine.case_detail(id,c)
 if 'routing' not in result['evidence']:
  building=next((r['building_node_id'] for r in result['complaints']),None)
  if building:route_case(c,id,building);result=engine.case_detail(id,c)
 result['routing']=result['evidence'].get('routing',{'stage':'undetermined','owner':'Manual review','role':'authority','node_id':result['case']['node_id'],'evidence':'No source complaint linked. Manual review required.'})
 return result
