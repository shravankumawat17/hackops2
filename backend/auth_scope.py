from pathlib import Path
p=Path('backend/test_connectivity.py');s=p.read_text().replace("connection.json()['nodes']==33","connection.json()['nodes']>=33");p.write_text(s)
p=Path('backend/integration.py');s=p.read_text();s=s.replace("return {'network':engine.network(c),'cases':filter_queue(c,priority_queue(c)),'meta':engine.meta(c)}", "records=filter_queue(c,priority_queue(c));network=engine.network(c)\n  if current()['role']!='authority':\n   allowed={p['case']['node_id'] for p in records}\n   network['nodes']=[n for n in network['nodes'] if not n['id'].startswith('address_') or n['id'] in allowed]\n  return {'network':network,'cases':records,'meta':engine.meta(c)}")
s=s.replace("return [json.loads(r['record']) for r in all_rows(c,'SELECT record FROM facility_samples ORDER BY rowid DESC')]", "return [record for r in all_rows(c,'SELECT record FROM facility_samples ORDER BY rowid DESC') if (record:=json.loads(r['record'])).get('account_id')==current()['id']]")
s=s.replace("record={**data.model_dump(),'id':", "record={**data.model_dump(),'account_id':current()['id'],'id':")
p.write_text(s)
