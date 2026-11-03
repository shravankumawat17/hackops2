from pathlib import Path
p=Path('frontend/src/api.js');s=p.read_text();s=s.replace("if(!response.ok)throw Error(","if(response.status===401)window.dispatchEvent(new Event('aq-session-expired'));\n  if(!response.ok)throw Error(")
s=s.replace("await request('/cases/'+c.id+'/status','PATCH',{status:mapped,note});", "if(status===c.status)await request('/cases/'+c.id+'/actions','POST',{action:'Case update',note});else await request('/cases/'+c.id+'/status','PATCH',{status:mapped,note});")
p.write_text(s)
p=Path('frontend/src/main.jsx');s=p.read_text().replace("import {signOut}","import {signOut,setAccessToken}");needle="const [reportPoints,setReportPoints]";s=s.replace(needle,"useEffect(()=>{const expired=()=>{setAccessToken('');setUser(null);setCases([]);setToast('Your session expired. Sign in again.')};window.addEventListener('aq-session-expired',expired);return()=>window.removeEventListener('aq-session-expired',expired)},[]);\n"+needle)
a=s.index('function CaseDetail');start=s.index('<div className="case-progress">',a);end=s.index('<div className="detail-grid">',start);s=s[:start]+s[end:];p.write_text(s)
