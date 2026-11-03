import sys,uuid
sys.path.insert(0,'backend')
from fastapi.testclient import TestClient
from integration import app
with TestClient(app) as c:
 r=c.get('/api/integration/bootstrap');assert r.status_code==200,r.text
 d=r.json();assert len(d['network']['nodes'])==33
 assert sum(len(c.get('/api/integration/readings/'+n['id']).json()) for n in d['network']['nodes'] if n.get('latest'))>0
 body={'request_id':str(uuid.uuid4()),'building_node_id':'bld_03','category':'Discolored water','text':'Brown water from all taps; integration test.'}
 r=c.post('/api/integration/submit',json=body);assert r.status_code==200,r.text;id=r.json()['case']['id']
 retry=c.post('/api/integration/submit',json=body);assert retry.json()['case']['id']==id
 r=c.patch('/api/cases/'+id+'/status',json={'status':'Investigating','note':'Inspection queued'});assert r.status_code==200,r.text
 assert c.get('/api/cases/'+id).json()['case']['status']=='Investigating'
 print('PASS: 33-node bootstrap, readings, report persistence, retry idempotency, case update')
