"""Account-scoped facility maintenance, independent from citizen case handling."""
import uuid
from datetime import date,datetime,timezone
from typing import Literal
from fastapi import APIRouter,HTTPException,Depends
from pydantic import BaseModel,Field
from authentication import current

def operator():
 user=current()
 if user['role']!='industry':raise HTTPException(403,'Facility operations require an industry account.')
 return user
router=APIRouter(prefix='/api/facility',dependencies=[Depends(operator)])
def table(c):
 c.execute('''CREATE TABLE IF NOT EXISTS maintenance_jobs(id TEXT PRIMARY KEY,account_id TEXT NOT NULL,facility TEXT NOT NULL,asset TEXT NOT NULL,task TEXT NOT NULL,due TEXT NOT NULL,status TEXT NOT NULL DEFAULT 'Scheduled',notes TEXT NOT NULL DEFAULT '',completed_at TEXT,version INTEGER NOT NULL DEFAULT 1,created_at TEXT NOT NULL)''');c.commit()
class JobIn(BaseModel):
 facility:Literal['treatment','wastewater']
 asset:str=Field(min_length=2,max_length=120)
 task:Literal['Filter inspection','Pump service','Instrument calibration','Tank cleaning','ETP inspection']
 due:date
 notes:str=Field('',max_length=1000)
class JobUpdate(BaseModel):
 status:Literal['In progress','Completed']
 notes:str=Field(min_length=3,max_length=1000)
 version:int=Field(ge=1)
@router.get('/maintenance')
def jobs():
 from integration import connect,all_rows
 with connect() as c:
  table(c);return all_rows(c,"SELECT * FROM maintenance_jobs WHERE account_id=? ORDER BY status='Completed',due,created_at DESC",(current()['id'],))
@router.post('/maintenance',status_code=201)
def create_job(data:JobIn):
 from integration import connect,one
 if len(data.asset.strip())<2:raise HTTPException(422,'Enter an equipment name.')
 id=str(uuid.uuid4())
 with connect() as c:
  table(c);c.execute('INSERT INTO maintenance_jobs(id,account_id,facility,asset,task,due,notes,created_at) VALUES(?,?,?,?,?,?,?,?)',(id,current()['id'],data.facility,data.asset.strip(),data.task,data.due.isoformat(),data.notes,datetime.now(timezone.utc).isoformat()));c.commit();return one(c,'SELECT * FROM maintenance_jobs WHERE id=?',(id,))
@router.patch('/maintenance/{id}')
def update_job(id:str,data:JobUpdate):
 from integration import connect,one
 with connect() as c:
  table(c)
  if len(data.notes.strip())<3:raise HTTPException(422,'Describe the work performed.')
  c.execute('BEGIN IMMEDIATE');job=one(c,'SELECT * FROM maintenance_jobs WHERE id=? AND account_id=?',(id,current()['id']))
  if not job:raise HTTPException(404,'Maintenance record not found in your facility.')
  if job['version']!=data.version:raise HTTPException(409,'This record changed. Reload the maintenance list and retry.')
  if job['status']=='Completed' or (job['status']=='In progress' and data.status=='In progress'):raise HTTPException(422,'Choose the next maintenance status.')
  c.execute('UPDATE maintenance_jobs SET status=?,notes=?,completed_at=?,version=version+1 WHERE id=?',(data.status,job['notes']+'\n'+data.status+': '+data.notes,datetime.now(timezone.utc).isoformat() if data.status=='Completed' else None,id));c.commit();return one(c,'SELECT * FROM maintenance_jobs WHERE id=?',(id,))
