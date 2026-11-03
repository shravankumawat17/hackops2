"""Test-only users: requests use the role appropriate to the endpoint under test."""
import uuid,secrets
from contextlib import closing
from fastapi.testclient import TestClient
class RoleTestClient(TestClient):
 def __enter__(self):
  result=super().__enter__()
  from uploaded_engine import db
  from authentication import create_account
  self.role_headers={}
  for role in ['citizen','authority','industry']:
   login='test-'+uuid.uuid4().hex;secret=secrets.token_urlsafe(20)
   with closing(db.connect()) as c:create_account(c,role,login,'Integration Test',secret)
   response=super().request('POST','/api/auth/login',json={'role':role,'identifier':login,'credential':secret})
   assert response.status_code==200,response.text
   self.role_headers[role]={'Authorization':'Bearer '+response.json()['token']}
  return result
 def request(self,method,url,*args,**kwargs):
  path=str(url)
  if hasattr(self,'role_headers') and '/api/' in path and '/api/auth/' not in path:
   role='industry' if '/samples' in path else 'citizen' if method.upper()=='POST' and (path.endswith('/geo/reports') or path.endswith('/integration/submit') or path.endswith('/complaints')) else 'authority'
   kwargs['headers']={**self.role_headers[role],**(kwargs.get('headers') or {})}
  return super().request(method,url,*args,**kwargs)

