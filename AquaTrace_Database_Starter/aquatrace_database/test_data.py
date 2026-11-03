"""Run after python generate_data.py: python -m unittest -v test_data.py"""
import unittest
from collections import Counter
from datetime import timedelta
from pathlib import Path
from import_data import load, timestamp, validate_graph
ROOT = Path(__file__).parent
class DatasetChecks(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.nodes,cls.readings,cls.complaints,cls.plumbers,cls.scenarios = load(ROOT/'data')
        cls.by_id = {n['id']:n for n in cls.nodes}
    def test_counts(self):
        self.assertEqual([len(x) for x in [self.nodes,self.readings,self.complaints,self.plumbers]], [33,672,14,12])
    def test_timezone(self):
        t = timestamp('2026-11-06T20:00:00')
        self.assertEqual(t.utcoffset(),timedelta(hours=5,minutes=30))
        self.assertEqual(timestamp('2026-11-06T14:30:00+00:00'),t)
    def test_reading_keys_unique(self):
        self.assertEqual(len({(r['node_id'],r['timestamp']) for r in self.readings}),len(self.readings))
        self.assertEqual(set(Counter(r['node_id'] for r in self.readings).values()),{168})
    def test_pipeline_distinct_buildings(self):
        now=timestamp(next(s['now'] for s in self.scenarios if s['id']=='S2_pipeline_fault'))
        reports=[c for c in self.complaints if c['scenario']=='S2_pipeline_fault' and now-timedelta(hours=2)<timestamp(c['submitted_at'])<=now]
        buildings={self.by_id[c['household_node']]['parent'] for c in reports}
        self.assertEqual(len(reports),4)
        self.assertEqual(len(buildings),2)
        self.assertEqual({self.by_id[b]['parent'] for b in buildings},{'seg_02'})
    def test_home_fallback(self):
        c=next(c for c in self.complaints if c['scenario']=='S3_home_fault')
        self.assertEqual(c['household_node'],'hh_09')
        self.assertFalse(c['neighbors_affected'])
        self.assertEqual(self.by_id[self.by_id[c['household_node']]['parent']]['parent'],'seg_03')
    def test_graph_rejects_cycle(self):
        nodes=[dict(n) for n in self.nodes]
        nodes[0]['parent']='hh_01'
        with self.assertRaises(ValueError): validate_graph(nodes)
    def test_asof_latest_excludes_future(self):
        for s in self.scenarios:
            now=timestamp(s['now'])
            candidates=[r for r in self.readings if r['node_id']=='plant_01' and timestamp(r['timestamp'])<=now]
            self.assertEqual(max(timestamp(r['timestamp']) for r in candidates),now)
if __name__=='__main__': unittest.main()
