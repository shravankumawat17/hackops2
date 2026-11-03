from pathlib import Path
p=Path('backend/integration.py');s=p.read_text().replace("# The uploaded / route", "from facility import router as facility_router\napp.include_router(facility_router)\n\n# The uploaded / route");p.write_text(s)
p=Path('frontend/src/api.js');s=p.read_text();s+='''
export const loadMaintenance=()=>request('/facility/maintenance');
export const createMaintenance=data=>request('/facility/maintenance','POST',data);
export const updateMaintenance=(job,status,notes)=>request('/facility/maintenance/'+job.id,'PATCH',{status,notes,version:job.version});
''';p.write_text(s)
