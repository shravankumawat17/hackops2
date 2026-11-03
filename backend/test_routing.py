import sys,tempfile,shutil,uuid
from pathlib import Path
sys.path.insert(0,'backend')
from integration import app
from uploaded_engine import db
from fastapi.testclient import TestClient
from routing import locate
with tempfile.TemporaryDirectory() as folder:
 target=Path(folder)/'routing.db';shutil.copy2(db.DB_PATH,target);db.DB_PATH=target
 with db.connect() as c:
  c.execute('DELETE FROM cases');c.execute('DELETE FROM case_actions');c.execute('DELETE FROM integration_requests');c.commit()
 with TestClient(app) as client:
  for clock,building,stage,role in [('2026-11-05 21:00:00','bld_01','plant','industry'),('2026-11-06 20:00:00','bld_03','pipeline','authority')]:
   with db.connect() as c:c.execute("UPDATE meta SET value=? WHERE key='scenario_now'",(clock,));c.commit()
   body={'request_id':str(uuid.uuid4()),'building_node_id':building,'category':'Cloudy water','text':'Routing regression test'}
   r=client.post('/api/integration/submit',json=body);assert r.status_code==200,r.text
   packet=r.json();assert packet['routing']['stage']==stage,packet['routing'];assert packet['routing']['role']==role
   assert client.get('/api/integration/bootstrap').json()['cases']
   print('PASS',stage,'->',role)
  with db.connect() as c:
   c.execute("DELETE FROM complaints WHERE building_node_id IN ('bld_07','bld_08')");c.commit();assert locate(c,'bld_07')['stage']=='building'
  print('PASS building -> authority/housing society; no household inference without evidence')

  c.close()
  import gc
  gc.collect()

