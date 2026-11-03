import csv,json,sqlite3
from pathlib import Path
ROOT=Path(__file__).resolve().parents[1];BASE=ROOT/'imported-backend/hackops2';DATA=ROOT/'AquaTrace_Database_Starter/aquatrace_database/data'
target=BASE/'hackops.db'
if target.exists():raise SystemExit('Existing compatibility database preserved.')
nodes=json.loads((DATA/'graph.json').read_text())['nodes'];index={n['id']:n for n in nodes}
c=sqlite3.connect(target)
schema=(BASE/'schema.sql').read_text().replace("'source','treatment_plant'","'household','source','treatment_plant'")
c.executescript(schema)
def zone(n):
 while n:
  if n['type']=='zone':return n['id']
  n=index.get(n['parent'])
 return None
mapping={'plant':'treatment_plant','street_segment':'junction','building_tank':'building'}
for n in nodes:c.execute('INSERT INTO nodes VALUES(?,?,?,?,?,?,?)',(n['id'],n['name'],mapping.get(n['type'],n['type']),n['lat'],n['lon'],zone(n),n['parent']))
for n in nodes:
 if n['has_sensor']:c.execute('INSERT INTO sensors VALUES(?,?,?,?)',('sensor_'+n['id'],n['id'],'multi',2026))
for r in csv.DictReader((DATA/'readings.csv').open()):c.execute('INSERT INTO readings VALUES(?,?,?,?,?,?)',('sensor_'+r['node_id'],r['timestamp'].replace('T',' '),r['ph'],r['turbidity_ntu'],r['tds_mgl'],r['residual_chlorine']))
for r in json.loads((DATA/'complaints.json').read_text()):c.execute('INSERT INTO complaints VALUES(?,?,?,?,?,?,?,?)',(r['complaint_id'],r['submitted_at'].replace('T',' '),index[r['household_node']]['parent'],r['symptom'],r['description'],'NEW',None,json.dumps(r)))
c.execute("INSERT INTO meta VALUES('scenario_now','2026-11-06 20:00:00')");c.commit();c.close();print('Imported starter: 33 nodes, 672 readings, 14 complaints.')
