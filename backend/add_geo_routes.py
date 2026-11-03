from pathlib import Path
p=Path('backend/integration.py');s=p.read_text();needle='# The uploaded / route';s=s.replace(needle,'from geography import router as geo_router\napp.include_router(geo_router)\n'+needle);p.write_text(s)
