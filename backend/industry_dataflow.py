from pathlib import Path
p=Path('frontend/src/main.jsx');s=p.read_text();s=s.replace("useEffect(()=>{if(!user)return;let active=true;initialize()", "useEffect(()=>{if(!user)return;if(user.role==='industry'){setConnection('Facility records: authenticated backend storage');return}let active=true;initialize()")
s=s.replace("onClick={()=>initialize().then(d=>", "onClick={()=>(role==='industry'?Promise.all([refreshCases(),loadSamples()]).then(([cases,measurements])=>{setSamples(measurements);return {cases,nodes:[],clock:'facility register'}}):initialize()).then(d=>")
p.write_text(s)
