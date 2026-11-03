// Credentials and session tokens are held in memory only; opening/reloading starts at sign-in.
let accessToken='';
export function setAccessToken(token){accessToken=token||''}
export function sessionHeaders(){return accessToken?{Authorization:'Bearer '+accessToken}:{}}
async function authRequest(path,body){const response=await fetch('/api/auth/'+path,{method:'POST',headers:{'Content-Type':'application/json',...sessionHeaders()},body:JSON.stringify(body||{})});const data=await response.json();if(!response.ok)throw Error(typeof data.detail==='string'?data.detail:'Sign-in failed. Check your details.');if(data.token)setAccessToken(data.token);return data}
export const signIn=body=>authRequest('login',body);
export const registerCitizen=body=>authRequest('register',body);
export async function signOut(){try{await authRequest('logout')}finally{setAccessToken('')}}
