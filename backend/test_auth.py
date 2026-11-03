import sys,tempfile,shutil,secrets,time,uuid
from pathlib import Path
from contextlib import closing
sys.path.insert(0,'backend')
from integration import app
from uploaded_engine import db
from authentication import tables,create_account
from fastapi.testclient import TestClient
with tempfile.TemporaryDirectory() as folder:
 original=db.DB_PATH;db.DB_PATH=Path(folder)/'auth.db';shutil.copy2(original,db.DB_PATH)
 try:
  with closing(db.connect()) as c:
   tables(c);code=secrets.token_urlsafe(20);create_account(c,'authority','TEST-OFFICER','Test Officer',code)
  with TestClient(app) as client:
   assert client.get('/api/integration/queue').status_code==401
   citizen=client.post('/api/auth/register',json={'mobile':'9876543298','name':'Auth Test','pin':'928371'});assert citizen.status_code==201,citizen.text
   citizen_headers={'Authorization':'Bearer '+citizen.json()['token']}
   assert client.patch('/api/cases/fake/status',headers=citizen_headers,json={'status':'Resolved'}).status_code in [403,404]
   assert client.post('/api/integration/scenario',headers=citizen_headers,json={'scenario':'plant'}).status_code==403
   assert client.get('/api/integration/queue',headers=citizen_headers).json()==[]
   report=client.post('/api/geo/reports',headers=citizen_headers,json={'request_id':str(uuid.uuid4()),'area':'Malad','locality':'Malad West','address':'Ownership test building','lat':19.187,'lon':72.848,'confirmed':True,'category':'Cloudy water','text':'Auth ownership test'})
   assert report.status_code==200,report.text
   own_id=report.json()['case']['id'];assert client.get('/api/integration/cases/'+own_id,headers=citizen_headers).status_code==200
   other=client.post('/api/auth/register',json={'mobile':'9876543297','name':'Other Citizen','pin':'837291'});assert other.status_code==201
   other_headers={'Authorization':'Bearer '+other.json()['token']}
   assert client.get('/api/integration/cases/'+own_id,headers=other_headers).status_code==403
   assert not client.get('/api/integration/queue',headers=other_headers).json()

   authority=client.post('/api/auth/login',json={'role':'authority','identifier':'TEST-OFFICER','credential':code});assert authority.status_code==200,authority.text
   headers={'Authorization':'Bearer '+authority.json()['token']}
   assert client.get('/api/integration/queue',headers=headers).status_code==200
   assert client.post('/api/auth/login',json={'role':'citizen','identifier':'TEST-OFFICER','credential':code}).status_code==401
   assert client.post('/api/auth/logout',headers=headers).status_code==200
   assert client.get('/api/integration/queue',headers=headers).status_code==401
   for i in range(5):assert client.post('/api/auth/login',json={'role':'authority','identifier':'TEST-OFFICER','credential':'wrong-code'}).status_code==401
   assert client.post('/api/auth/login',json={'role':'authority','identifier':'TEST-OFFICER','credential':code}).status_code==429
   with closing(db.connect()) as c:
    row=c.execute("SELECT secret_hash FROM auth_accounts WHERE login='TEST-OFFICER'").fetchone();assert row['secret_hash']!=code
   print('PASS: credential validation, hashing, workspace separation, anonymous denial, citizen permission checks, logout revocation, brute-force cooldown')
 finally:db.DB_PATH=original
