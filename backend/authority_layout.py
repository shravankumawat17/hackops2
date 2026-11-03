from pathlib import Path
p=Path('frontend/src/main.jsx');s=p.read_text();s=s.replace("import AddressFields from './AddressFields';", "import AddressFields from './AddressFields';\nimport AuthorityDashboard from './AuthorityDashboard';")
s=s.replace("{page==='dashboard'&&<>", "{page==='dashboard'&&role==='authority'&&<AuthorityDashboard rows={rows} stations={stations} nodes={networkNodes} reports={reportPoints} onOpen={openCase} onManage={()=>navigate('cases')} onStation={id=>{setSelected(id);setPage('station')}}/>}\n{page==='dashboard'&&role!=='authority'&&<>")
p.write_text(s)
