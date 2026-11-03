from pathlib import Path
p=Path('frontend/src/main.jsx');s=p.read_text().replace('loadHistory,selectEvidenceScenario}', 'loadHistory,selectEvidenceScenario,loadSamples,saveSample}')
s=s.replace("[samples,setSamples]=useState(()=>readStore('aq-samples',[]))", "[samples,setSamples]=useState([])")
s=s.replace("const load=()=>refreshCases().then(setCases).catch(e=>setToast(e.message));", "const load=()=>Promise.all([refreshCases(),loadSamples()]).then(([records,measurements])=>{setCases(records);setSamples(measurements)}).catch(e=>{setConnection('Backend unavailable: '+e.message);setToast(e.message)});")
s=s.replace("setSamples(readStore('aq-samples',[]))", "loadSamples().then(setSamples).catch(e=>setToast(e.message))")
a=s.index('onSave={sample=>{const next=');b=s.index('/>}',a);s=s[:a]+"onSave={async sample=>{const saved=await saveSample(sample);setSamples(prev=>[saved,...prev]);setToast('Facility reading saved to the backend.')}}"+s[b:]
s=s.replace("function Readings({samples,onSave}){const", "function Readings({samples,onSave}){const [saving,setSaving]=useState(false),[saveError,setSaveError]=useState('');const")
s=s.replace("onSubmit={e=>{e.preventDefault();onSave({...Object.fromEntries(new FormData(e.target)),facility});e.target.reset()}}", "onSubmit={async e=>{e.preventDefault();const form=e.currentTarget;setSaving(true);setSaveError('');try{await onSave({...Object.fromEntries(new FormData(form)),facility});form.reset()}catch(error){setSaveError(error.message)}finally{setSaving(false)}}}")
s=s.replace('Operational samples are kept locally until the backend is connected.', 'Operational samples are saved to the backend database and remain available after reload.')
s=s.replace('<button className="primary">Save sample<Plus size={17}/></button>', '{saveError&&<p className="error" role="alert">{saveError}</p>}<button className="primary" disabled={saving}>{saving?\'Saving sample…\':\'Save sample\'}<Plus size={17}/></button>')
s=s.replace("'Local sample drafts':'Network stations'", "'Recorded samples':'Network stations'")
p.write_text(s)
