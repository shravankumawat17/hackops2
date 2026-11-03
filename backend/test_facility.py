import sys,tempfile,shutil,secrets
from pathlib import Path
from contextlib import closing
sys.path.insert(0,'backend')
from integration import app
from uploaded_engine import db
from authentication import create_account
from fastapi.testclient import TestClient
with tempfile.TemporaryDirectory() as folder:
 original=db.DB_PATH;db.DB_PATH=Path(folder)/'facility.db';shutil.copy2(original,db.DB_PATH)
 try:
  with TestClient(app) as client:
   headers=[]
   for i in range(2):
    login='facility-test-'+secrets.token_hex(8);code=secrets.token_urlsafe(20)
    with closing(db.connect()) as c:create_account(c,'industry',login,'Operator '+str(i),code)
    r=client.post('/api/auth/login',json={'role':'industry','identifier':login,'credential':code});assert r.status_code==200
    headers.append({'Authorization':'Bearer '+r.json()['token']})
   data={'facility':'wastewater','asset':'ETP pump 2','task':'Pump service','due':'2026-11-05','notes':'Inspect seals and pressure.'}
   saved=client.post('/api/facility/maintenance',headers=headers[0],json=data);assert saved.status_code==201,saved.text
   job=saved.json();assert client.get('/api/facility/maintenance',headers=headers[0]).json()[0]['id']==job['id']
   assert not client.get('/api/facility/maintenance',headers=headers[1]).json()
   assert client.patch('/api/facility/maintenance/'+job['id'],headers=headers[1],json={'status':'Completed','notes':'Unauthorized attempt','version':1}).status_code==404
   started=client.patch('/api/facility/maintenance/'+job['id'],headers=headers[0],json={'status':'In progress','notes':'Pump isolated','version':1});assert started.status_code==200
   assert client.patch('/api/facility/maintenance/'+job['id'],headers=headers[0],json={'status':'Completed','notes':'Old version','version':1}).status_code==409
   done=client.patch('/api/facility/maintenance/'+job['id'],headers=headers[0],json={'status':'Completed','notes':'Seals replaced, pressure checked','version':2});assert done.status_code==200,done.text
   assert done.json()['completed_at'] and 'Inspect seals' in done.json()['notes']
   assert client.get('/api/facility/maintenance').status_code==401
   print('PASS: equipment scheduling, persistence, account isolation, start/completion notes, optimistic version checks, anonymous rejection')
 finally:db.DB_PATH=original
