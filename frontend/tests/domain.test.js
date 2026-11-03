import {test} from 'node:test';
import assert from 'node:assert/strict';
import {diagnose,canAccess,createCase,seedCases} from '../src/domain.js';
test('localizes all four supply stages',()=>{for(const stage of ['plant','pipeline','building','household'])assert.equal(diagnose(stage).stage,stage)});
test('rejects unknown locations',()=>assert.throws(()=>diagnose('invalid')));
test('citizen sees only owned cases',()=>{assert.equal(canAccess('citizen','other@example.com',seedCases[0]),false);assert.equal(canAccess('citizen',seedCases[0].email,seedCases[0]),true)});
test('industry scope is restricted to plant cases',()=>{assert.equal(canAccess('industry','industry@aquatrace.local',seedCases[0]),false);assert.equal(canAccess('industry','industry@aquatrace.local',seedCases[1]),true)});
test('authority sees operational cases',()=>assert.equal(canAccess('authority','authority@aquatrace.local',seedCases[0]),true));
test('submission creates evidence and timestamped history',()=>{const c=createCase({location:'pipeline',symptom:'Cloudy water',illness:true},{name:'Test',email:'test@aquatrace.local'});assert.equal(c.priority,'High');assert.equal(c.status,'Submitted');assert.equal(c.email,'test@aquatrace.local');assert.equal(c.diagnosis.stage,'pipeline');assert.ok(Date.parse(c.history[0].time));});
