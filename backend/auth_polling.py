from pathlib import Path
p=Path('frontend/src/main.jsx');s=p.read_text().replace('Promise.all([refreshCases(),loadSamples()])',"Promise.all([refreshCases(),user.role==='industry'?loadSamples():Promise.resolve([])])");s=s.replace("useEffect(()=>{const handler=()=>{refreshCases()", "useEffect(()=>{if(!user)return;const handler=()=>{refreshCases()");s=s.replace("loadSamples().then(setSamples).catch(e=>setToast(e.message))", "if(user.role==='industry')loadSamples().then(setSamples).catch(e=>setToast(e.message))")
s=s.replace("window.removeEventListener('storage',handler)},[]);", "window.removeEventListener('storage',handler)},[user?.id]);")
p.write_text(s)
