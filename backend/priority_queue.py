"""Shared persisted queue for citizen, municipal and operator views."""
from collections import Counter

def queue(c):
 from integration import all_rows,packet,one
 from geography import table,distance
 table(c)
 cases=all_rows(c,'SELECT id,created_at,status,rowid AS sequence FROM cases ORDER BY rowid DESC')
 geo={r['case_id']:r for r in all_rows(c,'SELECT * FROM geo_reports')}
 # Each persisted complaint contributes exactly once, even when a case groups complaints.
 complaints=all_rows(c,'''SELECT p.id,n.lat,n.lon,n.zone_id,g.area,g.locality FROM complaints p JOIN nodes n ON n.id=p.building_node_id LEFT JOIN geo_reports g ON g.id=p.id''')
 def area_key(r):return (r.get('area') or r.get('zone_id') or 'Unmapped network').strip().casefold()
 counts=Counter(area_key(r) for r in complaints)
 result=[]
 for case in cases:
  item=packet(c,case['id']);g=geo.get(case['id']);node=item.get('node') or {}
  if g:area=g['area'];locality=g['locality'];lat,lon=g['lat'],g['lon'];key=area.strip().casefold();item['address']=g['address']
  else:
   source=(item.get('complaints') or [{}])[0];building=one(c,'SELECT * FROM nodes WHERE id=?',(source.get('building_node_id',node.get('id')),)) or node
   key=(building.get('zone_id') or 'Unmapped network').casefold();zone=one(c,'SELECT name FROM nodes WHERE id=?',(building.get('zone_id'),))
   area=zone['name'] if zone else 'Unmapped network';locality=building.get('name','');lat,lon=building.get('lat'),building.get('lon')
  nearby=sum(1 for r in complaints if lat is not None and lon is not None and r['lat'] is not None and r['lon'] is not None and distance(lat,lon,r['lat'],r['lon'])<=500)
  item['priority']={'area':area,'locality':locality,'area_reports':counts[key],'nearby_reports':nearby,'radius_m':500,'window':'all persisted reports','sequence':case['sequence']}
  result.append(item)
 # Active work first; busiest area first; density, recency and insertion order break ties.
 result.sort(key=lambda p:(p['case']['status']=='Resolved',-p['priority']['area_reports'],-p['priority']['nearby_reports'],-p['priority']['sequence']))
 for rank,item in enumerate(result,1):item['priority']['rank']=rank
 return result
