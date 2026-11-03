from contextlib import closing
import sys,tempfile,shutil,uuid
from pathlib import Path
sys.path.insert(0,'backend')
from integration import app
from uploaded_engine import db
from test_support import RoleTestClient as TestClient
with tempfile.TemporaryDirectory() as folder:
 original=db.DB_PATH;db.DB_PATH=Path(folder)/'queue.db';shutil.copy2(original,db.DB_PATH)
 try:
  with closing(db.connect()) as c:
   for name in ['case_actions','cases','complaints','integration_requests','geo_reports']:
    if c.execute("SELECT 1 FROM sqlite_master WHERE type='table' AND name=?",(name,)).fetchone():c.execute('DELETE FROM '+name)
   c.commit();c.close()
  with TestClient(app) as c:
   def submit(area,locality,lat,lon):
    body={'request_id':str(uuid.uuid4()),'area':area,'locality':locality,'address':'Queue Test '+uuid.uuid4().hex[:8],'lat':lat,'lon':lon,'confirmed':True,'category':'Cloudy water','text':'Priority regression'}
    r=c.post('/api/geo/reports',json=body);assert r.status_code==200,r.text;return body,r.json()['case']['id']
   for i in range(3):submit('Kandivali','Charkop',19.216,72.825)
   body,low=submit('Malad','Malad West',19.187,72.848)
   queue=c.get('/api/integration/queue').json();assert len(queue)==4
   assert [r['priority']['area_reports'] for r in queue]==[3,3,3,1],queue
   assert any(r['case']['id']==low for r in queue)
   c.post('/api/geo/reports',json=body);assert len(c.get('/api/integration/queue').json())==4
   assert len(c.get('/api/integration/bootstrap').json()['cases'])==4
   top=queue[0]['case']['id'];assert c.patch('/api/cases/'+top+'/status',json={'status':'Resolved','note':'Test completed'}).status_code==200
   assert c.get('/api/integration/queue').json()[-1]['case']['id']==top
   print('PASS: committed citizen reports appear in shared queue/bootstrap; area-volume ordering; retries do not inflate counts; resolved work moves last')
 finally:db.DB_PATH=original

