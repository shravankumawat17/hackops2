-- Backend placeholders use psycopg named parameters. Never interpolate user SQL.

-- Path to root for a selected household. Validated seed graph is an acyclic tree.
WITH RECURSIVE path AS (
 SELECT *,0 AS depth FROM aquatrace.nodes WHERE id=%(household_node)s
 UNION ALL
 SELECT n.*,p.depth+1 FROM aquatrace.nodes n JOIN path p ON p.parent_id=n.id
) SELECT * FROM path ORDER BY depth;

-- Latest sensor record BEFORE the demo clock. Never use an unbounded latest row.
SELECT * FROM aquatrace.readings
WHERE node_id=%(node_id)s AND observed_at <= %(as_of)s
ORDER BY observed_at DESC LIMIT 1;

-- Neighbor evidence: count DISTINCT buildings (not reports or taps).
-- A building contributes only if a complaint is within the preceding two hours.
-- Include same-scenario seeds/background and the current session's live reports.
-- Exclude the current request on retries; analyze the new report separately.
WITH RECURSIVE descendants AS (
 SELECT id,parent_id,type FROM aquatrace.nodes WHERE id=%(segment_id)s
 UNION ALL
 SELECT n.id,n.parent_id,n.type FROM aquatrace.nodes n JOIN descendants d ON n.parent_id=d.id
)
SELECT count(DISTINCT hh.parent_id) AS affected_buildings,
       count(DISTINCT p.household_node) AS affected_households
FROM aquatrace.complaints p
JOIN descendants hh ON hh.id=p.household_node AND hh.type='household'
WHERE p.submitted_at > %(as_of)s - interval '2 hours'
  AND p.submitted_at <= %(as_of)s
  AND (p.request_id IS NULL OR p.request_id <> %(request_id)s::uuid)
  AND ((p.is_seed AND p.scenario_id IN (%(scenario_id)s,'background'))
       OR (NOT p.is_seed AND p.demo_session_id=%(session_id)s::uuid AND p.scenario_id=%(scenario_id)s));

-- Parameter whitelist must be applied in backend; do not inject column names.
-- Fetch all four fixed columns for a small 24h chart.
SELECT observed_at AS timestamp,turbidity_ntu,residual_chlorine,ph,tds_mgl
FROM aquatrace.readings
WHERE node_id=%(node_id)s AND observed_at BETWEEN %(from_time)s AND %(as_of)s
ORDER BY observed_at;

-- Local water conditions: nearest ZONE ancestor, not an invented household sensor.
-- API should expose node_id + observed_at + age + stale state with the values.
