from pathlib import Path
p=Path('frontend/src/main.jsx');s=p.read_text();s=s.replace("import AuthorityDashboard from './AuthorityDashboard';", "import AuthorityDashboard from './AuthorityDashboard';\nimport AuthLogin from './AuthLogin';\nimport CaseProgress from './CaseProgress';\nimport {signOut} from './session';")
s=s.replace("[user,setUser]=useState(()=>readStore('aq-session',null))","[user,setUser]=useState(null)")
s=s.replace("useEffect(()=>{let active=true;const load=()=>loadReportPoints", "useEffect(()=>{if(!user)return;let active=true;const load=()=>loadReportPoints").replace('[reportWindow,cases.length]);','[reportWindow,cases.length,user?.id]);')
s=s.replace('useEffect(()=>{let active=true;initialize()', 'useEffect(()=>{if(!user)return;let active=true;initialize()').replace('return()=>{active=false}},[]);','return()=>{active=false}},[user?.id]);')
s=s.replace("function login(u){try{saveStore('aq-session',u);setUser(u);navigate('dashboard')}catch{setToast('Enable browser storage to continue.')}}", "function login(u){setCases([]);setUser(u);navigate('dashboard')}")
s=s.replace('<Login onLogin={login}/>', '<AuthLogin onLogin={login}/>')
s=s.replace("localStorage.removeItem('aq-session');setUser(null)","signOut().finally(()=>{setUser(null);setCases([]);setSamples([])})")
s=s.replace("visible=cases.filter(c=>canAccess(role,user.email,c))", "visible=cases")
a=s.index('function Login({onLogin})');b=s.index('function Measurements',a);s=s[:a]+s[b:]
a=s.index('<section className="panel"><h2>Case timeline</h2>');b=s.index('<section className="panel"><h2>{role===',a);s=s[:a]+'<CaseProgress status={c.status} history={c.history}/>'+s[b:]
s=s.replace('Backend authentication pending','Authenticated local account')
s=s.replace('<label>Email address<input value={user.email} disabled/></label>', '<label>Account ID<input value={user.identifier} disabled/></label>')
s=s.replace("Role and email changes require verified backend authorization. Local access does not provide a security boundary.","Account IDs and roles are issued by the backend. Contact your administrator for credential recovery.")
p.write_text(s)
