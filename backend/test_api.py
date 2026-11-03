import sys
import os
sys.path.append(os.path.dirname(__file__))

from main import get_graph, list_cases, list_complaints, submit_complaint, ComplaintCreate, generate_public_advisory

print("Testing direct backend functions...")

# 1. Test get_graph
graph = get_graph()
print(f"[OK] Graph loaded: {len(graph['nodes'])} nodes, {len(graph['edges'])} edges")
assert len(graph['nodes']) > 0

# 2. Test list_cases
cases = list_cases()
print(f"[OK] Cases loaded: {cases['total']} cases")
for c in cases['cases']:
    print(f"   - {c['case_id']}: Stage {c['fault_stage']} | Routed to: {c['routed_to']}")

# 3. Test generate_public_advisory
if cases['cases']:
    first_case_id = cases['cases'][0]['case_id']
    advisory = generate_public_advisory(first_case_id)
    print(f"[OK] Generated Advisory for {first_case_id}:")
    print(advisory['headline'])

# 4. Test submit_complaint (Scenario 3: isolated household complaint)
complaint_payload = ComplaintCreate(
    household_node_id="hh_shreeji_301",
    symptom="brown_discolored",
    taps_affected="single_tap",
    since="this morning",
    neighbors_affected=0,
    illness_reported=0,
    text="Brown water only in flat 301 master bathroom"
)
result = submit_complaint(complaint_payload)
print(f"[OK] Complaint submission successful:")
print(f"   Complaint ID: {result['complaint_id']}")
print(f"   Fault Stage: {result['diagnosis']['fault_stage']}")
print(f"   Routed To: {result['diagnosis']['routed_to']}")
print(f"   Plumbers provided: {len(result['diagnosis'].get('nearby_plumbers', []))}")

print("\nALL BACKEND API TESTS PASSED!")
