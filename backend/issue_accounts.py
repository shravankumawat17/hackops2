"""Administrative account issuance. Stores first-run codes only in an ignored local file."""
import sys,secrets
from pathlib import Path
sys.path.insert(0,str(Path(__file__).parent))
from integration import connect,one
from authentication import tables,create_account
credentials=[]
with connect() as c:
 tables(c)
 for role,login,name in [('authority','BMC-KE-001','Municipal Officer'),('industry','PLANT-001','Plant Operator')]:
  if not one(c,'SELECT id FROM auth_accounts WHERE role=? AND login=?',(role,login)):
   code=secrets.token_urlsafe(18);create_account(c,role,login,name,code);credentials.append(f'{role}: ID {login}\nIssued code: {code}\n')
if credentials:
 p=Path(__file__).with_name('issued_credentials.txt');p.write_text('\n'.join(credentials),encoding='utf-8');print('Issued accounts. Read backend/issued_credentials.txt locally; keep it private.')
else:print('Accounts already exist; codes were not reset.')
