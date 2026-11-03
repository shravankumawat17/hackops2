import sys,tempfile,shutil,uuid
from pathlib import Path
sys.path.insert(0,'backend')
from integration import app
from uploaded_engine import db
from test_support import RoleTestClient as TestClient
with tempfile.TemporaryDirectory() as folder:
 original=db.DB_PATH;db.DB_PATH=Path(folder)/'geo.db';shutil.copy2(original,db.DB_PATH)
 try:
  with TestClient(app) as c:
   assert 'Kandivali' in c.get('/api/geo/areas').json()
   body={'request_id':str(uuid.uuid4()),'area':'Kandivali','locality':'Charkop','address':'Test Building, Sector 2','lat':19.216,'lon':72.825,'confirmed':True,'category':'Cloudy water','text':'Geographic test'}
   first=c.post('/api/geo/reports',json=body);assert first.status_code==200,first.text;id=first.json()['case']['id'];assert first.json()['routing']['stage']=='undetermined'
   assert c.post('/api/geo/reports',json=body).json()['case']['id']==id
   for i in range(5):
    r=c.post('/api/geo/reports',json={**body,'request_id':str(uuid.uuid4()),'address':f'Nearby Building {i}'});assert r.status_code==200,r.text
   nearby=c.get('/api/geo/nearby?lat=19.216&lon=72.825').json();assert nearby['count']>=6,nearby
   points=c.get('/api/geo/reports').json();assert points['hotspot_threshold']==5
   assert sum(p['area']=='Kandivali' for p in points['points'])>=6
   assert c.post('/api/geo/reports',json={**body,'lat':0,'request_id':str(uuid.uuid4())}).status_code==422
   assert c.post('/api/geo/reports',json={**body,'address':'Changed address'}).status_code==409
   print('PASS: area catalogue, custom address persistence, retry deduplication, six-report proximity, heatmap data, coordinate validation, conflict handling, manual routing')
 finally:db.DB_PATH=original
