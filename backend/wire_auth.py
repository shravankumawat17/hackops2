from pathlib import Path
p=Path('backend/integration.py');s=p.read_text();s=s.replace('app=engine.app','''app=engine.app
from authentication import router as auth_router,identity,current,authenticate,filter_queue,can_read
from fastapi import Request
from fastapi.responses import JSONResponse
app.include_router(auth_router)
@app.middleware('http')
async def require_credentials(request:Request,call_next):
 path=request.url.path
 if not path.startswith('/api/') or path in ['/api/auth/login','/api/auth/register','/api/health','/api/integration/connection']:return await call_next(request)
 try:
  user=authenticate(request.headers.get('authorization',''))
  role=user['role']
  if '/cases/' in path:
   case_id=path.split('/cases/')[1].split('/')[0]
   with connect() as c:
    if not can_read(c,case_id,user):raise HTTPException(403,'This case is outside your workspace.')
   if role=='citizen' and request.method!='GET' and not path.endswith('/actions'):raise HTTPException(403,'Only the responsible team can change case status.')
  if path=='/api/complaints' and request.method=='GET' and role!='authority':raise HTTPException(403,'Complaint records require authority access.')
  if path in ['/api/cluster/run','/api/integration/scenario'] and role!='authority':raise HTTPException(403,'This action requires authority access.')
  if path.startswith('/api/integration/samples') and role!='industry':raise HTTPException(403,'Facility samples require industry access.')
  if path in ['/api/geo/reports','/api/integration/submit','/api/complaints'] and request.method=='POST' and role!='citizen':raise HTTPException(403,'Submit reports through a citizen account.')
  if path in ['/api/cases','/api/hotspots'] and role!='authority':raise HTTPException(403,'Use your workspace queue.')
  marker=identity.set(user)
  try:return await call_next(request)
  finally:identity.reset(marker)
 except HTTPException as e:return JSONResponse(status_code=e.status_code,content={'detail':e.detail})
''');s=s.replace("'cases':priority_queue(c)","'cases':filter_queue(c,priority_queue(c))").replace('with connect() as c:return priority_queue(c)','with connect() as c:return filter_queue(c,priority_queue(c))')
# Override legacy handlers so actor comes from the session, not a submitted name.
needle='# The uploaded / route'
s=s.replace(needle,'''app.router.routes[:]=[r for r in app.router.routes if getattr(r,'path',None) not in ['/api/cases/{case_id}/status','/api/cases/{case_id}/actions']]
@app.patch('/api/cases/{case_id}/status')
def authenticated_status(case_id:str,payload:engine.StatusIn):
 with connect() as c:
  existing=engine._case(c,case_id)
  if existing['status']==payload.status:
   if payload.note:engine.add_action(case_id,engine.ActionIn(actor=current()['name'],role=current()['role'],action='Case note',note=payload.note),c)
   return {'case':existing}
  payload.actor=current()['name'];payload.role=current()['role'];return engine.update_status(case_id,payload,c)
@app.post('/api/cases/{case_id}/actions')
def authenticated_action(case_id:str,payload:engine.ActionIn):
 payload.actor=current()['name'];payload.role=current()['role']
 with connect() as c:return engine.add_action(case_id,payload,c)
'''+needle);p.write_text(s)
p=Path('backend/geography.py');s=p.read_text();s=s.replace("c.execute('INSERT INTO integration_requests VALUES(?,?,?)',(str(data.request_id),payload,case));c.commit()", "from authentication import current\n   c.execute('INSERT INTO case_owners VALUES(?,?)',(case,current()['id']))\n   c.execute('INSERT INTO integration_requests VALUES(?,?,?)',(str(data.request_id),payload,case));c.commit()")
p.write_text(s)
