from pathlib import Path
p=Path('imported-backend/hackops2/backend/app.py');s=p.read_text().replace('app.mount("/static", StaticFiles(directory=str(WEB)), name="static")','if WEB.is_dir():\n    app.mount("/static", StaticFiles(directory=str(WEB)), name="static")');p.write_text(s)
p=Path('backend/integration.py');s=p.read_text();s+='''
# Industry samples have their own persistence; recording does not change seeded sensors.
from typing import Literal
from datetime import datetime,timezone
from fastapi.staticfiles import StaticFiles
class SampleIn(BaseModel):
 facility:Literal['treatment','wastewater']
 point:str=Field(min_length=1,max_length=120)
 ph:float=Field(ge=0,le=14,allow_inf_nan=False)
 turbidity:float=Field(ge=0,le=1000,allow_inf_nan=False)
 tds:float=Field(ge=0,le=10000,allow_inf_nan=False)
 chlorine:float=Field(ge=0,le=20,allow_inf_nan=False)
 notes:str=Field('',max_length=1000)
def sample_table(c):
 c.execute('CREATE TABLE IF NOT EXISTS facility_samples(id TEXT PRIMARY KEY,record TEXT NOT NULL)');c.commit()
@app.get('/api/integration/samples')
def samples():
 with connect() as c:
  sample_table(c);return [json.loads(r['record']) for r in all_rows(c,'SELECT record FROM facility_samples ORDER BY rowid DESC')]
@app.post('/api/integration/samples',status_code=201)
def save_sample(data:SampleIn):
 record={**data.model_dump(),'id':str(uuid.uuid4()),'time':datetime.now(timezone.utc).isoformat()}
 with connect() as c:
  sample_table(c);c.execute('INSERT INTO facility_samples VALUES(?,?)',(record['id'],json.dumps(record)));c.commit()
 return record
@app.get('/api/integration/connection')
def connection():
 with connect() as c:
  return {'service':'aquatrace-integration','version':2,'storage':'SQLite compatibility database','nodes':one(c,'SELECT count(*) AS total FROM nodes')['total'],'clock':iso(demo_now(c))}
# The uploaded / route pointed at an excluded legacy web folder. Serve React instead.
app.router.routes[:]=[r for r in app.router.routes if getattr(r,'path',None) not in ['/','/static']]
DIST=ROOT/'frontend/dist'
if DIST.is_dir():app.mount('/',StaticFiles(directory=str(DIST),html=True),name='react')
''';p.write_text(s)
p=Path('frontend/vite.config.js');p.write_text('''import {defineConfig} from 'vite';
import react from '@vitejs/plugin-react';
import tailwindcss from '@tailwindcss/vite';
const proxy={'/api':{target:process.env.AQUATRACE_API_TARGET||'http://127.0.0.1:8002',changeOrigin:true}};
export default defineConfig({plugins:[react(),tailwindcss()],server:{port:5174,strictPort:true,proxy},preview:{port:4174,strictPort:true,proxy}});
''')
p=Path('frontend/src/api.js');s=p.read_text();start=s.index('async function request(');end=s.index('\nlet nodes=',start);s=s[:start]+'''async function request(path,method='GET',body){
 const controller=new AbortController();const timer=setTimeout(()=>controller.abort(),15000);
 try{
  const response=await fetch('/api'+path,{method,signal:controller.signal,headers:{'Content-Type':'application/json'},...(body?{body:JSON.stringify(body)}:{})});
  const text=await response.text();let data;
  try{data=JSON.parse(text)}catch{throw Error('The API did not return JSON. Start the integrated backend and check the /api proxy.')}
  if(!response.ok)throw Error(typeof data.detail==='string'?data.detail:data.error?.message||'API request failed ('+response.status+').');return data;
 }catch(e){if(e.name==='AbortError')throw Error('Backend request timed out. Check the server and retry.');if(e instanceof TypeError)throw Error('Cannot reach the backend. Start python run.py or check the API proxy.');throw e}finally{clearTimeout(timer)}
}'''+s[end:];s+='''
export const loadSamples=()=>request('/integration/samples');
export const saveSample=data=>request('/integration/samples','POST',data);
''';p.write_text(s)
