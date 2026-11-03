from pathlib import Path
p=Path('backend/integration.py');s=p.read_text();s=s.replace('app=engine.app','from routing import locate,route_case,packet\napp=engine.app');s=s.replace("[engine.case_detail(r['id'],c) for r in engine.cases(c)]","[packet(c,r['id']) for r in engine.cases(c)]");s=s.replace("return engine.case_detail(old['case_id'],c)","return packet(c,old['case_id'])")
s=s.replace('engine.rules.run(c,window_hours=2,min_buildings=2)',"decision=locate(c,data.building_node_id)\n  if decision['stage']=='plant':\n   evidence=engine.rules._evidence(c,decision['node_id'],[created['complaint']],decision['evidence'])\n   evidence['routing']=decision\n   _,plant_case=engine.rules._upsert_case(c,decision['node_id'],'MUNICIPAL','High','Treatment plant investigation',decision['evidence'],evidence);c.commit()\n  else:engine.rules.run(c,window_hours=2,min_buildings=2)")
s=s.replace("c.execute('INSERT INTO integration_requests VALUES(?,?,?)'", "route_case(c,found,data.building_node_id)\n  c.execute('INSERT INTO integration_requests VALUES(?,?,?)'")
s=s.replace('return engine.case_detail(found,c)','return packet(c,found)')
s+='''
@app.get('/api/integration/cases/{id}')
def routed_detail(id:str):
 with connect() as c:return packet(c,id)
'''
p.write_text(s)
p=Path('frontend/src/api.js');s=p.read_text();s=s.replace("const c=packet.case,e=packet.evidence||{},building=", "const c=packet.case,e=packet.evidence||{},routing=packet.routing||e.routing,building=")
s=s.replace("stage:packet.node?.type", "stage:routing?.stage||(packet.node?.type").replace("?'pipeline':'undetermined',title:","?'pipeline':'undetermined'),title:")
s=s.replace("owner:c.scope===", "owner:routing?.owner||(c.scope===").replace("?'Housing society':'Manual review',evidence:","?'Housing society':'Manual review'),evidence:")
s=s.replace("[e.rule||'Review required',", "[routing?.evidence||e.rule||'Review required',")
s=s.replace("return {id:c.id,", "return {recipientRole:routing?.role||'authority',id:c.id,")
s=s.replace("request('/cases/'+c.id)","request('/integration/cases/'+c.id)").replace("request('/cases/'+r.id)","request('/integration/cases/'+r.id)")
p.write_text(s)
p=Path('frontend/src/domain.js');s=p.read_text();s=s.replace("c.diagnosis.stage==='plant'","(c.recipientRole?c.recipientRole==='industry':c.diagnosis.stage==='plant')");p.write_text(s)
p=Path('frontend/src/main.jsx');s=p.read_text();needle="useEffect(()=>{if(toast)";s=s.replace(needle,"useEffect(()=>{if(!user)return;const load=()=>refreshCases().then(setCases).catch(e=>setToast(e.message));load();const timer=setInterval(load,10000);window.addEventListener('focus',load);return()=>{clearInterval(timer);window.removeEventListener('focus',load)}},[user?.role]);\n"+needle);s=s.replace('locations[c.location].label','locations[c.location]?.label||c.location');p.write_text(s)
