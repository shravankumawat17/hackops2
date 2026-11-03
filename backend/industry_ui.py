from pathlib import Path
p=Path('frontend/src/main.jsx');s=p.read_text().replace("import AuthorityDashboard from './AuthorityDashboard';", "import AuthorityDashboard from './AuthorityDashboard';\nimport FacilityWorkspace from './FacilityWorkspace';")
s=s.replace('if(!user)return;let active=true;const load=()=>loadReportPoints',"if(!user||user.role==='industry')return;let active=true;const load=()=>loadReportPoints")
s=s.replace("const links=[", "const links=role==='industry'?[['dashboard','Facility overview',Factory],['readings','Sample register',FlaskConical],['cases','Corrective cases',ClipboardList],['maintenance','Equipment maintenance',Settings]]:[")
s=s.replace("{page==='dashboard'&&role!=='authority'", "{page==='dashboard'&&role==='citizen'")
needle="{page==='dashboard'&&role==='authority'"
s=s.replace(needle,"{role==='industry'&&['dashboard','maintenance'].includes(page)&&<FacilityWorkspace page={page} samples={samples} cases={rows} onNavigate={navigate} onOpen={openCase}/>}\n"+needle)
s=s.replace("title={role==='citizen'?'Your reports, all in one place.':'Keep every case moving.'}", "title={role==='citizen'?'Your reports, all in one place.':role==='industry'?'Assigned corrective cases':'Keep every case moving.'}")
s=s.replace("navigate(role==='citizen'?'report':'network')", "navigate(role==='citizen'?'report':role==='industry'?'readings':'network')")
s=s.replace("{role==='citizen'?'New report':'Inspect network'}", "{role==='citizen'?'New report':role==='industry'?'Record follow-up sample':'Inspect network'}")
s=s.replace("onClick={()=>navigate('notifications')}", "onClick={()=>navigate(role==='industry'?'cases':'notifications')}")
s=s.replace('aria-label="Open notifications"', 'aria-label={role===\'industry\'?\'Open corrective cases\':\'Open notifications\'}')
# The scenario clock selector is for authority evidence testing, not operator or citizen actions.
s=s.replace('<select aria-label="Synthetic evidence scenario"', "{role==='authority'&&<select aria-label=\"Synthetic evidence scenario\"")
s=s.replace('<option value="home">Isolated report � Nov 7</option></select>', '<option value="home">Isolated report - Nov 7</option></select>}')
p.write_text(s)
