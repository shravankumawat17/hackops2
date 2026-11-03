"""python import_data.py ./data ; DATABASE_URL must be set. Seed-only upserts."""
import csv
import json
import os
import sys
from datetime import datetime
from pathlib import Path
from zoneinfo import ZoneInfo

IST = ZoneInfo('Asia/Kolkata')
TYPES = ['source', 'plant', 'reservoir', 'zone', 'street_segment', 'building_tank', 'household']
STAGES = {'plant/source': 'plant_source', 'distribution pipeline': 'distribution_pipeline', 'household plumbing': 'household'}
ROUTES = {'plant operators': 'plant_operators', 'BMC': 'bmc', 'citizen + nearby plumbers': 'citizen'}


def timestamp(value):
    value = datetime.fromisoformat(value)
    return value.replace(tzinfo=IST) if value.tzinfo is None else value


def validate_graph(nodes):
    by_id = {n['id']: n for n in nodes}
    if len(by_id) != len(nodes):
        raise ValueError('Duplicate node IDs')
    for n in nodes:
        rank = TYPES.index(n['type'])
        parent = n['parent']
        if rank == 0:
            if parent is not None:
                raise ValueError('Source cannot have a parent')
        elif parent not in by_id or by_id[parent]['type'] != TYPES[rank - 1]:
            raise ValueError(f"Invalid parent for {n['id']}")
    return by_id


def load(folder):
    folder = Path(folder)
    def read(name):
        return json.loads((folder / name).read_text())
    nodes = read('graph.json')['nodes']
    by_id = validate_graph(nodes)
    scenarios = read('scenarios.json')
    complaints = read('complaints.json')
    with (folder / 'readings.csv').open(newline='') as f:
        readings = list(csv.DictReader(f))
    for r in readings:
        if not by_id[r['node_id']]['has_sensor']:
            raise ValueError('Reading at a node without a sensor')
    for c in complaints:
        if by_id[c['household_node']]['type'] != 'household':
            raise ValueError('Complaint must reference a household')
        if timestamp(c['since']) > timestamp(c['submitted_at']):
            raise ValueError('Complaint onset after submission')
    return nodes, readings, complaints, read('plumbers.json'), scenarios


def seed(conn, folder):
    nodes, readings, complaints, plumbers, scenarios = load(folder)
    # One transaction: broken FK or input validation cannot leave a partial seed.
    with conn.transaction(), conn.cursor() as cur:
        for n in nodes:
            cur.execute('''INSERT INTO aquatrace.nodes
                (id,type,name,parent_id,lat,lon,has_sensor) VALUES (%s,%s,%s,%s,%s,%s,%s)
                ON CONFLICT(id) DO UPDATE SET type=EXCLUDED.type,name=EXCLUDED.name,
                parent_id=EXCLUDED.parent_id,lat=EXCLUDED.lat,lon=EXCLUDED.lon,has_sensor=EXCLUDED.has_sensor''',
                (n['id'], n['type'], n['name'], n['parent'], n['lat'], n['lon'], n['has_sensor']))
        # Background is not a selectable scenario, but is a valid complaint scope.
        cur.execute('''INSERT INTO aquatrace.scenarios VALUES ('background',%s,'undetermined','manual_review','Older background reports')
                       ON CONFLICT(id) DO NOTHING''', (timestamp('2026-11-01T00:00:00'),))
        for s in scenarios:
            cur.execute('''INSERT INTO aquatrace.scenarios VALUES (%s,%s,%s,%s,%s)
                ON CONFLICT(id) DO UPDATE SET as_of=EXCLUDED.as_of,expected_stage=EXCLUDED.expected_stage,
                expected_route=EXCLUDED.expected_route,why=EXCLUDED.why''',
                (s['id'], timestamp(s['now']), STAGES[s['expected_stage']], ROUTES[s['expected_route']], s['why']))
        cur.executemany('''INSERT INTO aquatrace.readings
            (observed_at,node_id,turbidity_ntu,residual_chlorine,ph,tds_mgl)
            VALUES (%s,%s,%s,%s,%s,%s) ON CONFLICT(node_id,observed_at) DO UPDATE SET
            turbidity_ntu=EXCLUDED.turbidity_ntu,residual_chlorine=EXCLUDED.residual_chlorine,
            ph=EXCLUDED.ph,tds_mgl=EXCLUDED.tds_mgl''',
            [(timestamp(r['timestamp']),r['node_id'],*[float(r[p]) for p in
              ['turbidity_ntu','residual_chlorine','ph','tds_mgl']]) for r in readings])
        for c in complaints:
            cur.execute('''INSERT INTO aquatrace.complaints
                (complaint_id,household_node,symptom,description,taps_affected,since,submitted_at,
                 neighbors_affected,illness_reported,scenario_id,is_seed)
                VALUES (%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,true)
                ON CONFLICT(complaint_id) DO UPDATE SET symptom=EXCLUDED.symptom,
                description=EXCLUDED.description,taps_affected=EXCLUDED.taps_affected,
                since=EXCLUDED.since,submitted_at=EXCLUDED.submitted_at,
                neighbors_affected=EXCLUDED.neighbors_affected,illness_reported=EXCLUDED.illness_reported,
                scenario_id=EXCLUDED.scenario_id WHERE aquatrace.complaints.is_seed''',
                (c['complaint_id'],c['household_node'],c['symptom'],c['description'],c['taps_affected'],
                 timestamp(c['since']),timestamp(c['submitted_at']),c['neighbors_affected'],
                 c['illness_reported'],c.get('scenario') or 'background'))
        for p in plumbers:
            cur.execute('''INSERT INTO aquatrace.plumbers(id,name,phone,lat,lon,specialty)
                VALUES (%s,%s,%s,%s,%s,%s) ON CONFLICT(id) DO UPDATE SET name=EXCLUDED.name,
                phone=EXCLUDED.phone,lat=EXCLUDED.lat,lon=EXCLUDED.lon,specialty=EXCLUDED.specialty''',
                (p['id'],p['name'],p['phone'],p['lat'],p['lon'],p['specialty']))
    print(f'Imported {len(nodes)} nodes, {len(readings)} readings, {len(complaints)} seed complaints, {len(plumbers)} plumbers.')


if __name__ == '__main__':
    import psycopg
    with psycopg.connect(os.environ['DATABASE_URL'], prepare_threshold=None) as connection:
        seed(connection, sys.argv[1] if len(sys.argv) > 1 else 'data')
