"""Local credential accounts and short-lived, revocable sessions."""
import hashlib,hmac,secrets,time,re
from contextvars import ContextVar
from fastapi import APIRouter,HTTPException
from pydantic import BaseModel,Field
router=APIRouter(prefix='/api/auth');identity=ContextVar('identity',default=None)
def current():
 user=identity.get()
 if not user:raise HTTPException(401,'Sign in to continue.')
 return user
def tables(c):
 c.executescript('''CREATE TABLE IF NOT EXISTS auth_accounts(id TEXT PRIMARY KEY,role TEXT NOT NULL,login TEXT NOT NULL,name TEXT NOT NULL,salt TEXT NOT NULL,secret_hash TEXT NOT NULL,UNIQUE(role,login));CREATE TABLE IF NOT EXISTS auth_sessions(token_hash TEXT PRIMARY KEY,account_id TEXT NOT NULL,expires REAL NOT NULL);CREATE TABLE IF NOT EXISTS auth_attempts(key TEXT PRIMARY KEY,failures INTEGER NOT NULL,until REAL NOT NULL);CREATE TABLE IF NOT EXISTS case_owners(case_id TEXT NOT NULL,account_id TEXT NOT NULL,PRIMARY KEY(case_id,account_id));''')
def derive(secret,salt):return hashlib.pbkdf2_hmac('sha256',secret.encode(),bytes.fromhex(salt),310000).hex()
def public(row):return {'id':row['id'],'role':row['role'],'identifier':row['login'],'name':row['name'],'email':row['id']}
def create_account(c,role,login,name,secret):
 tables(c);salt=secrets.token_hex(16);id=secrets.token_hex(16)
 c.execute('INSERT INTO auth_accounts VALUES(?,?,?,?,?,?)',(id,role,login,name,salt,derive(secret,salt)));c.commit();return id
def issue(c,row):
 token=secrets.token_urlsafe(32);c.execute('INSERT INTO auth_sessions VALUES(?,?,?)',(hashlib.sha256(token.encode()).hexdigest(),row['id'],time.time()+3600));c.commit();return {'token':token,'user':public(row),'expires_in':3600}
class Login(BaseModel):
 role:str
 identifier:str=Field(min_length=3,max_length=80)
 credential:str=Field(min_length=6,max_length=128)
@router.post('/login')
def login(data:Login):
 from integration import connect,one
 if data.role not in ['citizen','authority','industry']:raise HTTPException(422,'Choose a valid workspace.')
 with connect() as c:
  tables(c);key=data.role+':'+data.identifier.strip();a=one(c,'SELECT * FROM auth_attempts WHERE key=?',(key,))
  if a and a['until']>time.time():raise HTTPException(429,'Too many attempts. Try again in 15 minutes.')
  row=one(c,'SELECT * FROM auth_accounts WHERE role=? AND login=?',(data.role,data.identifier.strip()))
  candidate=derive(data.credential,row['salt'] if row else '0'*32)
  if not row or not hmac.compare_digest(candidate,row['secret_hash']):
   failures=(a['failures'] if a else 0)+1;c.execute('INSERT OR REPLACE INTO auth_attempts VALUES(?,?,?)',(key,failures,time.time()+900 if failures>=5 else 0));c.commit();raise HTTPException(401,'ID or credential is incorrect for this workspace.')
  c.execute('DELETE FROM auth_attempts WHERE key=?',(key,));return issue(c,row)
class Registration(BaseModel):
 mobile:str
 name:str=Field(min_length=2,max_length=80)
 pin:str
@router.post('/register',status_code=201)
def register(data:Registration):
 from integration import connect,one
 if not re.fullmatch(r'[6-9][0-9]{9}',data.mobile) or not re.fullmatch(r'[0-9]{6}',data.pin):raise HTTPException(422,'Enter a 10-digit Indian mobile number and a 6-digit PIN.')
 if len(set(data.pin))==1 or data.pin in ['123456','654321']:raise HTTPException(422,'Choose a less predictable PIN.')
 with connect() as c:
  tables(c)
  if one(c,"SELECT id FROM auth_accounts WHERE role='citizen' AND login=?",(data.mobile,)):raise HTTPException(409,'This mobile number is registered. Sign in instead.')
  create_account(c,'citizen',data.mobile,data.name.strip(),data.pin);return issue(c,one(c,"SELECT * FROM auth_accounts WHERE role='citizen' AND login=?",(data.mobile,)))
@router.post('/logout')
def logout():
 from integration import connect
 user=current()
 with connect() as c:c.execute('DELETE FROM auth_sessions WHERE token_hash=?',(user['_token_hash'],));c.commit()
 return {'signed_out':True}
@router.get('/me')
def me():return {k:v for k,v in current().items() if not k.startswith('_')}
def authenticate(header):
 from integration import connect,one
 token=header.removeprefix('Bearer ');digest=hashlib.sha256(token.encode()).hexdigest()
 with connect() as c:
  tables(c);row=one(c,'SELECT a.* FROM auth_sessions s JOIN auth_accounts a ON a.id=s.account_id WHERE s.token_hash=? AND s.expires>?',(digest,time.time()))
 if not row:raise HTTPException(401,'Session expired or invalid. Sign in again.')
 return {**public(row),'_token_hash':digest}
def can_read(c,case_id,user):
 from integration import one,packet
 if user['role']=='authority':return True
 if user['role']=='industry':return packet(c,case_id)['routing']['role']=='industry'
 return bool(one(c,'SELECT 1 AS found FROM case_owners WHERE case_id=? AND account_id=?',(case_id,user['id'])))
def filter_queue(c,records):
 user=current();return [p for p in records if can_read(c,p['case']['id'],user)]

