"""Repository helpers, not a complete HTTP server or localization engine.
Use with psycopg 3 connections whose row_factory is dict_row.
Call these from your backend handlers; never accept analysis from the browser.
"""
from datetime import datetime, timezone
from uuid import uuid4
from psycopg.types.json import Jsonb

NEXT = {'reported': 'located', 'located': 'assigned', 'assigned': 'in_progress', 'in_progress': 'resolved'}


def get_case(conn, case_id, session_id):
    row = conn.execute('''SELECT c.*,p.request_id,p.household_node,p.symptom,p.description,p.taps_affected,
        p.since,p.submitted_at,p.neighbors_affected,p.illness_reported,p.meter_reading
        FROM aquatrace.cases c JOIN aquatrace.complaints p USING(complaint_id)
        WHERE c.case_id=%s AND p.demo_session_id=%s''', (case_id, session_id)).fetchone()
    if row is None:
        raise LookupError('Case not found')
    a = conn.execute('''SELECT * FROM aquatrace.case_analyses WHERE case_id=%s
                        ORDER BY revision DESC LIMIT 1''', (row['id'],)).fetchone()
    events = conn.execute('''SELECT id,event_type,event_at AS ts,message AS event,actor AS by,
        payload,from_status,to_status FROM aquatrace.case_events
        WHERE case_id=%s ORDER BY event_at DESC,id DESC''', (row['id'],)).fetchall()
    result = {k: v for k,v in row.items() if k not in ('id','complaint_id')}
    result.update({
        'located_node': a['located_node'] if a else None,
        'fault_stage': a['fault_stage'] if a else 'undetermined',
        'confidence': a['confidence'] if a else 'low',
        'routed_to': a['routed_to'] if a else 'manual_review',
        'evidence': [e['text'] for e in a['evidence']] if a else [],
        'evidence_details': a['evidence'] if a else [],
        'threshold_check': a['threshold_checks'][0] if a and a['threshold_checks'] else None,
        'threshold_checks': a['threshold_checks'] if a else [],
        'standard_cited': a['citations'][0] if a and a['citations'] else None,
        'citations': a['citations'] if a else [],
        'analysis_as_of': a['analyzed_as_of'] if a else None,
        'rule_version': a['rule_version'] if a else None,
        'actions': [e for e in events if e['event_type'] in ('action','note','status_changed')],
        'timeline': events,
        'is_simulated': True,
    })
    return result


def persist_analyzed_case(conn, complaint, analysis, as_of, session_id, scenario_id):
    """Atomic write AFTER server-side validation and analysis.
    complaint contains trusted validated input; analysis is server-generated.
    Same request_id retries return the original case (not another complaint).
    Use get_case() to serialize the returned case_id after this commits.
    """
    cid = 'C-' + str(uuid4())
    with conn.transaction():
        # Serialize writes within the demo session, not across all users.
        conn.execute('SELECT pg_advisory_xact_lock(hashtextextended(%s,0))', (str(session_id),))
        existing = conn.execute('''SELECT c.case_id,p.demo_session_id FROM aquatrace.cases c
            JOIN aquatrace.complaints p USING(complaint_id) WHERE p.request_id=%s''',
            (complaint['request_id'],)).fetchone()
        if existing:
            if str(existing['demo_session_id']) != str(session_id):
                raise ValueError('Request ID already used')
            return existing['case_id']
        conn.execute('''INSERT INTO aquatrace.complaints
            (complaint_id,request_id,demo_session_id,scenario_id,household_node,symptom,description,
             taps_affected,since,submitted_at,neighbors_affected,illness_reported,meter_reading)
            VALUES (%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s)''',
            (cid,complaint['request_id'],session_id,scenario_id,complaint['household_node'],
             complaint['symptom'],complaint.get('description',''),complaint['taps_affected'],
             complaint['since'],as_of,complaint.get('neighbors_affected'),
             complaint.get('illness_reported',False),complaint.get('meter_reading')))
        c = conn.execute('''INSERT INTO aquatrace.cases(complaint_id,status,located_at)
            VALUES (%s,'located',now()) RETURNING id,case_id''', (cid,)).fetchone()
        conn.execute('''INSERT INTO aquatrace.case_analyses
            (case_id,revision,analyzed_as_of,rule_version,located_node,fault_stage,confidence,
             routed_to,evidence,threshold_checks,citations,anomaly_summary)
            VALUES (%s,1,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s)''',
            (c['id'],as_of,analysis['rule_version'],analysis['located_node'],analysis['fault_stage'],
             analysis['confidence'],analysis['routed_to'],Jsonb(analysis['evidence']),
             Jsonb(analysis['threshold_checks']),Jsonb(analysis['citations']),
             Jsonb(analysis.get('anomaly_summary',{}))))
        for kind, message in [('reported','Complaint received'),('located','Analysis completed; routing recommended')]:
            conn.execute('''INSERT INTO aquatrace.case_events(case_id,event_type,event_at,actor,message)
                            VALUES (%s,%s,%s,'system',%s)''', (c['id'],kind,as_of,message))
    return c['case_id']


def update_status(conn, case_id, session_id, new_status, expected_version, actor, event_at):
    """HTTP layer maps stale version -> 409, missing case -> 404, bad transition -> 422."""
    with conn.transaction():
        c = conn.execute('''SELECT c.* FROM aquatrace.cases c JOIN aquatrace.complaints p USING(complaint_id)
            WHERE c.case_id=%s AND p.demo_session_id=%s FOR UPDATE OF c''', (case_id,session_id)).fetchone()
        if c is None:
            raise LookupError('Case not found')
        if c['version'] != expected_version:
            raise RuntimeError('Version conflict; reload case')
        if NEXT.get(c['status']) != new_status:
            raise ValueError('Invalid status transition')
        real_now = datetime.now(timezone.utc)
        conn.execute('''UPDATE aquatrace.cases SET status=%s,version=version+1,updated_at=%s,
            resolved_at=%s WHERE id=%s''',
            (new_status,real_now,real_now if new_status=='resolved' else None,c['id']))
        conn.execute('''INSERT INTO aquatrace.case_events
            (case_id,event_type,event_at,actor,message,from_status,to_status)
            VALUES (%s,'status_changed',%s,%s,%s,%s,%s)''',
            (c['id'],event_at,actor,f"Status changed to {new_status}",c['status'],new_status))
    return get_case(conn,case_id,session_id)
