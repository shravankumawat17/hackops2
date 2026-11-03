from pathlib import Path
p=Path('backend/facility.py');s=p.read_text().replace("id=str(uuid.uuid4())", "if len(data.asset.strip())<2:raise HTTPException(422,'Enter an equipment name.')\n id=str(uuid.uuid4())");s=s.replace("table(c);c.execute('BEGIN IMMEDIATE');job=", "table(c)\n  if len(data.notes.strip())<3:raise HTTPException(422,'Describe the work performed.')\n  c.execute('BEGIN IMMEDIATE');job=")
s=s.replace("(data.status,data.notes,datetime.now", "(data.status,job['notes']+'\\n'+data.status+': '+data.notes,datetime.now")
p.write_text(s)
p=Path('frontend/src/main.jsx');s=p.read_text();s=s.replace('<strong>A clearer picture.<br/>A healthier community.</strong><p>Every report helps connect the dots.</p>', "<strong>{role==='industry'?<>Process integrity.<br/>Consistent operations.</>:<>A clearer picture.<br/>A healthier community.</>}</strong><p>{role==='industry'?'Keep measurements, equipment work and corrective cases connected.':'Every report helps connect the dots.'}</p>")
s=s.replace('<button className="icon-button" aria-label={role===\'industry\'?\'Open corrective cases\':\'Open notifications\'}', "{role!=='industry'&&<button className=\"icon-button\" aria-label=\"Open notifications\"")
s=s.replace('<Bell size={19}/></button><span className="avatar mini">', '<Bell size={19}/></button>}<span className="avatar mini">')
p.write_text(s)
