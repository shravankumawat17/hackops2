import sys,json,importlib.util
from pathlib import Path
from datetime import datetime,timezone,timedelta
root=Path(__file__).resolve().parents[1]/'AquaTrace_Database_Starter/aquatrace_database'
spec=importlib.util.spec_from_file_location('seed',root/'import_data.py');m=importlib.util.module_from_spec(spec);spec.loader.exec_module(m)
def literal(v):
 if v is None:return 'NULL'
 if isinstance(v,bool):return 'TRUE' if v else 'FALSE'
 if isinstance(v,(int,float)):return str(v)
 if isinstance(v,datetime):v=v.isoformat()
 return "'"+str(v).replace("'","''")+"'"
class Capture:
 def __enter__(self):return self
 def __exit__(self,*args):pass
 def transaction(self):return self
 def cursor(self):return self
 def execute(self,q,args):
  parts=q.split('%s');out=parts[0]
  for v,p in zip(args,parts[1:]):out+=literal(v)+p
  queries.append(out+';')
 def executemany(self,q,rows):
  for row in rows:self.execute(q,row)
queries=[];m.seed(Capture(),root/'data');Path(__file__).with_name('starter_seed.sql').write_text('BEGIN;\n'+'\n'.join(queries)+'\nCOMMIT;',encoding='utf-8')
