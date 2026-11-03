import sys,shutil,tempfile
from pathlib import Path
sys.path.insert(0,'backend')
from integration import app
from uploaded_engine import db
from test_support import RoleTestClient as TestClient
with tempfile.TemporaryDirectory() as folder:
 original=db.DB_PATH;db.DB_PATH=Path(folder)/'test.db';shutil.copy2(original,db.DB_PATH)
 try:
  with TestClient(app) as c:
   assert c.get('/').status_code==200
   connection=c.get('/api/integration/connection');assert connection.status_code==200;assert connection.json()['nodes']>=33
   body={'facility':'wastewater','point':'ETP outlet','ph':7.1,'turbidity':2,'tds':400,'chlorine':.2,'notes':'Connectivity regression'}
   saved=c.post('/api/integration/samples',json=body);assert saved.status_code==201,saved.text
   id=saved.json()['id'];assert any(r['id']==id for r in c.get('/api/integration/samples').json())
   assert c.post('/api/integration/samples',json={**body,'ph':20}).status_code==422
   assert c.get('/api/integration/bootstrap').status_code==200
   print('PASS: same-origin frontend, backend identity, 33-node bootstrap, server sample persistence, invalid sample rejection')
 finally:db.DB_PATH=original
