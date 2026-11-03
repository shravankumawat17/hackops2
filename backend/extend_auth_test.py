from pathlib import Path
p=Path('backend/test_auth.py');s=p.read_text().replace('import sys,tempfile,shutil,secrets,time','import sys,tempfile,shutil,secrets,time,uuid')
needle="assert client.get('/api/integration/queue',headers=citizen_headers).json()==[]"
s=s.replace(needle,needle+'''
   report=client.post('/api/geo/reports',headers=citizen_headers,json={'request_id':str(uuid.uuid4()),'area':'Malad','locality':'Malad West','address':'Ownership test building','lat':19.187,'lon':72.848,'confirmed':True,'category':'Cloudy water','text':'Auth ownership test'})
   assert report.status_code==200,report.text
   own_id=report.json()['case']['id'];assert client.get('/api/integration/cases/'+own_id,headers=citizen_headers).status_code==200
   other=client.post('/api/auth/register',json={'mobile':'9876543297','name':'Other Citizen','pin':'837291'});assert other.status_code==201
   other_headers={'Authorization':'Bearer '+other.json()['token']}
   assert client.get('/api/integration/cases/'+own_id,headers=other_headers).status_code==403
   assert not client.get('/api/integration/queue',headers=other_headers).json()
''');p.write_text(s)
