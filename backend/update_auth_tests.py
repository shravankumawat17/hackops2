from pathlib import Path
for name in ['test_connectivity.py','test_geography.py','test_priority_queue.py','test_routing.py','test_integration.py']:
 p=Path('backend')/name;s=p.read_text().replace('from fastapi.testclient import TestClient','from test_support import RoleTestClient as TestClient');p.write_text(s)
