"""Location-based reports, separate from verified supply topology."""
import math,json,uuid
from datetime import timedelta
from fastapi import APIRouter,HTTPException,Query
from pydantic import BaseModel,Field,ConfigDict
# Delayed import avoids circular startup.
router=APIRouter(prefix='/api/geo')
# Approximate locality centers for pin placement; not geocoding results.
AREAS={
 'Kandivali':{'Kandivali West':[19.2045,72.841],'Kandivali East':[19.209,72.866],'Charkop':[19.216,72.825]},
 'Malad':{'Malad West':[19.187,72.848],'Malad East':[19.187,72.862],'Malvani':[19.192,72.818]},
 'Borivali':{'Borivali West':[19.231,72.85],'Borivali East':[19.232,72.867]},
 'Andheri':{'Andheri West':[19.1364,72.8296],'Andheri East':[19.12,72.87],'Marol':[19.117,72.883]},
 'Dadar':{'Dadar West':[19.0178,72.8478],'Dadar East':[19.018,72.856]},
 'Bandra':{'Bandra West':[19.06,72.833],'Bandra East':[19.059,72.852]},
 'Powai':{'Powai':[19.118,72.906],'Chandivali':[19.109,72.896]},
 'Bhandup':{'Bhandup West':[19.151,72.936],'Bhandup East':[19.143,72.946]},
 'Goregaon':{'Goregaon West':[19.164,72.849],'Goregaon East':[19.166,72.866]},
 'Other Mumbai area':{'Custom location':[19.076,72.8777]}}
def distance(a,b,c,d):
 r=math.pi/180;x=math.sin((c-a)*r/2)**2+math.cos(a*r)*math.cos(c*r)*math.sin((d-b)*r/2)**2
 return 6371000*2*math.asin(min(1,math.sqrt(x)))
def table(c):
 c.execute('CREATE TABLE IF NOT EXISTS geo_reports(id TEXT PRIMARY KEY,case_id TEXT,building_id TEXT,area TEXT,locality TEXT,address TEXT,lat REAL,lon REAL,confirmed INTEGER,recorded_at TEXT)');c.commit()
def records(c,hours=None):
 from integration import all_rows,demo_now,iso
 table(c);now=demo_now(c);lower=iso(now-timedelta(hours=hours)) if hours else '0000'
 custom=all_rows(c,'SELECT id,lat,lon,recorded_at AS timestamp,area,locality,confirmed FROM geo_reports WHERE recorded_at>=? AND recorded_at<=?',(lower,iso(now)))
 seed=all_rows(c,'SELECT p.id,n.lat,n.lon,p.timestamp FROM complaints p JOIN nodes n ON n.id=p.building_node_id WHERE p.timestamp>=? AND p.timestamp<=? AND p.id NOT IN (SELECT id FROM geo_reports)',(lower,iso(now)))
 return custom+[{**r,'area':'Simulated supply network','locality':'Seed report location','confirmed':False} for r in seed if r['lat'] is not None and r['lon'] is not None]
@router.get('/areas')
def areas():return AREAS
@router.get('/reports')
def reports(hours:int|None=Query(None,ge=1,le=8760)):
 from integration import connect,iso,demo_now
 with connect() as c:return {'points':records(c,hours),'radius_m':500,'hotspot_threshold':5,'as_of':iso(demo_now(c)),'window_hours':hours}
@router.get('/nearby')
def nearby(lat:float=Query(ge=18.8,le=19.6),lon:float=Query(ge=72.7,le=73.2)):
 from integration import connect
 with connect() as c:
  points=records(c,24);count=sum(distance(lat,lon,r['lat'],r['lon'])<=500 for r in points)
 return {'count':count,'radius_m':500,'hours':24,'message':f'{count} nearby reports within 500 m in the past 24 hours. Counts represent reports, not verified distinct users.'}
class GeoReport(BaseModel):
 model_config=ConfigDict(extra='forbid')
 request_id:uuid.UUID
 area:str=Field(min_length=1,max_length=80)
 locality:str=Field(min_length=1,max_length=100)
 address:str=Field(min_length=3,max_length=300)
 lat:float=Field(ge=18.8,le=19.6,allow_inf_nan=False)
 lon:float=Field(ge=72.7,le=73.2,allow_inf_nan=False)
 confirmed:bool=False
 category:str=Field(min_length=1,max_length=100)
 text:str=Field('',max_length=2000)
@router.post('/reports')
def submit(data:GeoReport):
 from integration import connect,one,engine,iso,demo_now,packet
 with connect() as c:
  table(c);c.execute('CREATE TABLE IF NOT EXISTS integration_requests(id TEXT PRIMARY KEY,payload TEXT,case_id TEXT)');c.commit()
  payload=json.dumps(data.model_dump(mode='json'),sort_keys=True);old=one(c,'SELECT * FROM integration_requests WHERE id=?',(str(data.request_id),))
  if old:
   from authentication import current,can_read
   if not can_read(c,old['case_id'],current()):raise HTTPException(403,'Request belongs to another account.')
   if old['payload']!=payload:raise HTTPException(409,'Request ID used for different report. Retry with the original fields.')
   result=packet(c,old['case_id']);result['address']=data.address;return result
  if data.area not in AREAS or data.locality not in AREAS[data.area]:raise HTTPException(422,'Select a valid area and locality.')
  id='GEO-'+uuid.uuid4().hex;building='address_'+uuid.uuid4().hex;now=iso(demo_now(c))
  try:
   c.execute('BEGIN IMMEDIATE')
   c.execute("INSERT INTO nodes(id,name,type,lat,lon) VALUES(?,?,'building',?,?)",(building,data.address,data.lat,data.lon))
   c.execute('INSERT INTO complaints(id,timestamp,building_node_id,category,text,status) VALUES(?,?,?,?,?,?)',(id,now,building,data.category,data.text,'NEW'))
   evidence={'complaint_ids':[id],'buildings':[building],'rule':'Address pin is not mapped to a verified supply branch. Municipal review required. Nearby reports are geographic context only.','routing':{'stage':'undetermined','owner':'Municipal location review','role':'authority','node_id':building,'evidence':'Supply connection not established for this new address. Do not infer a plant or pipeline from proximity.'}}
   case=engine.rules._next_case_id(c)
   c.execute("INSERT INTO cases(id,node_id,scope,status,severity,title,created_at,updated_at,rule_fired,evidence_json) VALUES(?,?,'UNDETERMINED','Open','Low',?,?,?,?,?)",(case,building,data.category+' · '+data.locality,now,now,evidence['rule'],json.dumps(evidence)))
   c.execute('INSERT INTO geo_reports VALUES(?,?,?,?,?,?,?,?,?,?)',(id,case,building,data.area,data.locality,data.address,data.lat,data.lon,int(data.confirmed),now))
   from authentication import current
   c.execute('INSERT INTO case_owners VALUES(?,?)',(case,current()['id']))
   c.execute('INSERT INTO integration_requests VALUES(?,?,?)',(str(data.request_id),payload,case));c.commit()
  except Exception:c.rollback();raise
  result=packet(c,case);result['address']=data.address;return result
