import {sessionHeaders} from './session';
import {stations,locations,seedCases,createCase} from './domain';

async function request(path,method='GET',body){
  const controller=new AbortController();
  const timer=setTimeout(()=>controller.abort(),15000);
  try{
    const response=await fetch('/api'+path,{method,signal:controller.signal,headers:{'Content-Type':'application/json',...sessionHeaders()},...(body?{body:JSON.stringify(body)}:{})});
    const text=await response.text();
    let data;
    try{data=JSON.parse(text)}catch{throw Error('The API did not return JSON. Start the integrated backend and check the /api proxy.')}
    if(response.status===401)window.dispatchEvent(new Event('aq-session-expired'));
    if(!response.ok)throw Error(typeof data.detail==='string'?data.detail:data.error?.message||'API request failed ('+response.status+').');
    return data;
  }catch(e){
    if(e.name==='AbortError')throw Error('Backend request timed out. Check the server and retry.');
    if(e instanceof TypeError)throw Error('Cannot reach the backend. Start python run.py or check the API proxy.');
    throw e;
  }finally{
    clearTimeout(timer);
  }
}

let nodes=[];

export function mapCase(packet){
  if(!packet) return null;
  const c=packet.case||packet;
  const e=packet.evidence||{};
  const routing=packet.routing||e.routing;
  const building=packet.complaints?.[0]?.building_node_id||c.node_id||c.location;
  return {
    priority:packet.priority||{rank:1,area:c.location||'Area',area_reports:1,nearby_reports:1},
    address:packet.address||packet.node?.name||locations[building]?.label||c.address||building,
    recipientRole:routing?.role||c.recipientRole||'authority',
    id:c.id,
    location:building,
    flat:c.flat||packet.address||'Building report',
    email:packet.viewer_id||c.email||'',
    name:c.name||'Citizen workspace',
    symptom:c.title||c.symptom||'Water quality report',
    status:({Open:'Submitted',Investigating:'Assigned','Action Taken':'In progress',Resolved:'Resolved'})[c.status]||c.status||'Submitted',
    since:c.created_at||c.since||'Recent',
    notes:packet.complaints?.map(x=>x.text).filter(Boolean).join('\n')||c.notes||'',
    diagnosis:c.diagnosis||{
      stage:routing?.stage||(packet.node?.type==='treatment_plant'?'plant':c.scope==='BUILDING_SIDE'?'building':c.scope==='MUNICIPAL'?'pipeline':'undetermined'),
      title:(c.scope||'Municipal network').replaceAll('_',' '),
      owner:routing?.owner||(c.scope==='MUNICIPAL'?'Municipal operations':c.scope==='BUILDING_SIDE'?'Housing society':'Manual review'),
      evidence:[routing?.evidence||e.rule||'Review required',...(packet.complaints||[]).map(x=>`${x.id}: ${x.building_name} · ${x.timestamp}`)],
      action:'Review the upstream trace and arrange a qualified inspection.'
    },
    history:(packet.actions||c.history||[]).map(a=>({
      time:a.timestamp?(a.timestamp.replace(' ','T')+'+05:30'):(a.time||new Date().toISOString()),
      actor:a.actor||'System',
      text:a.text||(a.action+(a.note?' · '+a.note:''))
    })),
    packet
  };
}

export async function initialize(){
  try {
    const data=await request('/integration/bootstrap');
    nodes=data.network.nodes||[];
    for(const k of Object.keys(locations))delete locations[k];
    nodes.filter(n=>n.type==='building').forEach(n=>locations[n.id]={label:n.name});
    const sensorNodes=nodes.filter(n=>n.latest);
    if(sensorNodes.length){
      stations.splice(0,stations.length,...sensorNodes.map((n,i)=>({id:n.id,name:n.name,area:n.zone_id||n.type,type:n.type,ph:n.latest.ph,turbidity:n.latest.turbidity_ntu,tds:n.latest.tds_mgl,chlorine:n.latest.residual_chlorine_mgl,lat:n.lat,lon:n.lon,history:[],wqi:n.wqi})));
    }
    return {cases:(data.cases||[]).map(mapCase),clock:data.meta?.demo_now||'2026-11-06 20:00:00',nodes,pipes:data.network.pipes||[],bounds:data.network.bounds};
  }catch(e){
    console.warn('Backend unavailable, falling back to local dataset:', e.message);
    return {cases:seedCases,clock:'2026-11-06 20:00:00',nodes:[],pipes:[],bounds:null,fallback:true};
  }
}

export async function submitReport(data,id){
  try {
    return mapCase(await request('/integration/submit','POST',{request_id:id,building_node_id:data.location,category:data.symptom,text:[data.notes,'Flat: '+data.flat,'Onset: '+data.since,'Taps: '+data.taps,'Neighbors: '+data.neighbors,'Illness reported: '+data.illness].join('\n')}));
  } catch(e) {
    console.warn('Backend submission failed, using local case:', e.message);
    return createCase(data, {name:'Citizen', email:'citizen@aquatrace.local'});
  }
}

export async function updateRecord(c,status,note){
  const mapped={Submitted:'Open',Assigned:'Investigating','In progress':'Action Taken',Resolved:'Resolved'}[status]||status;
  try {
    if(status===c.status)await request('/cases/'+c.id+'/actions','POST',{action:'Case update',note});
    else await request('/cases/'+c.id+'/status','PATCH',{status:mapped,note});
    return mapCase(await request('/integration/cases/'+c.id));
  } catch(e) {
    console.warn('Backend update failed, applying locally:', e.message);
    return {
      ...c,
      status,
      history:[{time:new Date().toISOString(),actor:'User',text:(status!==c.status?`Status updated to ${status}`:'Case update')+(note?` · ${note}`:'')},...(c.history||[])]
    };
  }
}

export async function refreshCases(){
  try {
    return (await request('/integration/queue')).map(mapCase);
  } catch(e) {
    return seedCases;
  }
}

export async function loadHistory(id){
  try {
    return (await request('/integration/readings/'+id)).map(r=>r.turbidity_ntu).slice(-8);
  } catch(e) {
    return stations.find(s=>s.id===id)?.history || [.4,.5,.6,.7,.8,.9,1.1,1.3];
  }
}

export async function selectEvidenceScenario(scenario){
  try {
    await request("/integration/scenario","POST",{scenario});
  } catch(e) {
    console.warn('Scenario switch error:', e.message);
  }
  return initialize();
}

export const loadSamples=async ()=>{
  try {
    return await request('/integration/samples');
  } catch(e) {
    return [];
  }
};

export const saveSample=async data=>{
  try {
    return await request('/integration/samples','POST',data);
  } catch(e) {
    return {...data, id:crypto.randomUUID(), time:new Date().toISOString()};
  }
};

export const loadAreas=async ()=>{
  try {
    return await request('/geo/areas');
  } catch(e) {
    return [];
  }
};

export const loadReportPoints=async (hours=null)=>{
  try {
    return await request('/geo/reports'+(hours?'?hours='+hours:''));
  } catch(e) {
    return {points:[]};
  }
};

export const nearbyReports=async (lat,lon)=>{
  try {
    return await request('/geo/nearby?lat='+lat+'&lon='+lon);
  } catch(e) {
    return {reports:[]};
  }
};

export async function submitAddressReport(data,id){
  try {
    return mapCase(await request('/geo/reports','POST',{request_id:id,area:data.area,locality:data.locality,address:data.address,lat:data.lat,lon:data.lon,confirmed:data.confirmed,category:data.symptom,text:[data.notes,'Flat: '+data.flat,'Onset: '+data.since,'Taps: '+data.taps].join('\n')}));
  } catch(e) {
    console.warn('Geo submit fallback:', e.message);
    return createCase(data, {name:'Citizen', email:'citizen@aquatrace.local'});
  }
}

export const loadMaintenance=async ()=>{
  try {
    return await request('/facility/maintenance');
  } catch(e) {
    return [];
  }
};

export const createMaintenance=async data=>{
  try {
    return await request('/facility/maintenance','POST',data);
  } catch(e) {
    return {...data, id:crypto.randomUUID(), status:'Scheduled', created_at:new Date().toISOString(), version:1};
  }
};

export const updateMaintenance=async (job,status,notes)=>{
  try {
    return await request('/facility/maintenance/'+job.id,'PATCH',{status,notes,version:job.version});
  } catch(e) {
    return {...job, status, notes:job.notes+'\n'+status+': '+notes, version:(job.version||1)+1};
  }
};
