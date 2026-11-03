-- Run once in a new PostgreSQL database / Supabase SQL Editor.
-- The app schema is deliberately NOT a Supabase Data API schema.
BEGIN;
CREATE SCHEMA aquatrace;
REVOKE ALL ON SCHEMA aquatrace FROM PUBLIC;

CREATE TABLE aquatrace.nodes (
  id text PRIMARY KEY,
  type text NOT NULL CHECK (type IN ('source','plant','reservoir','zone','street_segment','building_tank','household')),
  name text NOT NULL,
  parent_id text REFERENCES aquatrace.nodes(id) DEFERRABLE INITIALLY DEFERRED,
  lat double precision CHECK (lat BETWEEN -90 AND 90),
  lon double precision CHECK (lon BETWEEN -180 AND 180),
  has_sensor boolean NOT NULL DEFAULT false,
  is_simulated boolean NOT NULL DEFAULT true,
  CHECK (parent_id IS NULL OR parent_id <> id),
  CHECK ((type = 'source') = (parent_id IS NULL))
);
CREATE INDEX nodes_parent_idx ON aquatrace.nodes(parent_id);

CREATE TABLE aquatrace.scenarios (
  id text PRIMARY KEY,
  as_of timestamptz NOT NULL,
  expected_stage text NOT NULL,
  expected_route text NOT NULL,
  why text NOT NULL
);

CREATE TABLE aquatrace.demo_sessions (
  id uuid PRIMARY KEY,
  scenario_id text NOT NULL REFERENCES aquatrace.scenarios(id),
  created_at timestamptz NOT NULL DEFAULT now()
);

-- One row per sensor timestamp, matching readings.csv. NULL = not measured.
CREATE TABLE aquatrace.readings (
  node_id text NOT NULL REFERENCES aquatrace.nodes(id),
  observed_at timestamptz NOT NULL,
  turbidity_ntu double precision CHECK (turbidity_ntu >= 0 AND turbidity_ntu < 'Infinity'::float8),
  residual_chlorine double precision CHECK (residual_chlorine >= 0 AND residual_chlorine < 'Infinity'::float8),
  ph double precision CHECK (ph BETWEEN 0 AND 14),
  tds_mgl double precision CHECK (tds_mgl >= 0 AND tds_mgl < 'Infinity'::float8),
  is_simulated boolean NOT NULL DEFAULT true,
  PRIMARY KEY (node_id, observed_at)
);

CREATE TABLE aquatrace.complaints (
  complaint_id text PRIMARY KEY,
  request_id uuid UNIQUE,
  demo_session_id uuid REFERENCES aquatrace.demo_sessions(id),
  scenario_id text REFERENCES aquatrace.scenarios(id),
  is_seed boolean NOT NULL DEFAULT false,
  household_node text NOT NULL REFERENCES aquatrace.nodes(id),
  symptom text NOT NULL CHECK (symptom IN ('brown_discolored','cloudy','bad_smell','bad_taste','particles')),
  description text NOT NULL DEFAULT '',
  taps_affected text NOT NULL CHECK (taps_affected IN ('all','hot_only','single_tap')),
  since timestamptz NOT NULL,
  submitted_at timestamptz NOT NULL,
  neighbors_affected boolean,
  illness_reported boolean NOT NULL DEFAULT false,
  meter_reading numeric CHECK (meter_reading >= 0),
  CHECK (since <= submitted_at),
  CHECK (is_seed OR (request_id IS NOT NULL AND demo_session_id IS NOT NULL))
);
CREATE INDEX complaints_evidence_idx ON aquatrace.complaints(household_node, submitted_at DESC);
CREATE INDEX complaints_scope_idx ON aquatrace.complaints(scenario_id, demo_session_id, submitted_at);

CREATE TABLE aquatrace.cases (
  id bigint GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  case_id text GENERATED ALWAYS AS ('WQ-' || lpad(id::text, greatest(3, length(id::text)), '0')) STORED UNIQUE,
  complaint_id text NOT NULL UNIQUE REFERENCES aquatrace.complaints(complaint_id),
  status text NOT NULL DEFAULT 'reported' CHECK (status IN ('reported','located','assigned','in_progress','resolved')),
  version integer NOT NULL DEFAULT 1 CHECK (version > 0),
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  located_at timestamptz,
  resolved_at timestamptz,
  CHECK ((status = 'resolved') = (resolved_at IS NOT NULL))
);
CREATE INDEX cases_queue_idx ON aquatrace.cases(status, created_at DESC);

CREATE TABLE aquatrace.standard_passages (
  id bigint GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  document text NOT NULL,
  edition text NOT NULL,
  clause text NOT NULL,
  page integer CHECK (page > 0),
  source_url text,
  passage text NOT NULL,
  verified_at timestamptz,
  UNIQUE (document, edition, clause)
);

CREATE TABLE aquatrace.parameter_limits (
  id bigint GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  parameter text NOT NULL CHECK (parameter IN ('turbidity_ntu','residual_chlorine','ph','tds_mgl')),
  unit text NOT NULL,
  passage_id bigint NOT NULL REFERENCES aquatrace.standard_passages(id),
  limit_kind text NOT NULL CHECK (limit_kind IN ('acceptable','permissible','operational')),
  minimum numeric,
  maximum numeric,
  applicability text NOT NULL,
  verified_at timestamptz NOT NULL,
  CHECK (minimum IS NOT NULL OR maximum IS NOT NULL),
  CHECK (minimum IS NULL OR maximum IS NULL OR minimum <= maximum),
  UNIQUE (parameter, passage_id, limit_kind, applicability)
);

-- Immutable analysis snapshots: retain the original evidence if data/rules change.
CREATE TABLE aquatrace.case_analyses (
  id bigint GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  case_id bigint NOT NULL REFERENCES aquatrace.cases(id),
  revision integer NOT NULL CHECK (revision > 0),
  analyzed_as_of timestamptz NOT NULL,
  recorded_at timestamptz NOT NULL DEFAULT now(),
  rule_version text NOT NULL,
  located_node text REFERENCES aquatrace.nodes(id),
  fault_stage text CHECK (fault_stage IN ('plant_source','distribution_pipeline','building','household','undetermined')),
  confidence text NOT NULL CHECK (confidence IN ('low','medium','high')),
  routed_to text CHECK (routed_to IN ('plant_operators','bmc','housing_society','citizen','manual_review')),
  evidence jsonb NOT NULL DEFAULT '[]' CHECK (jsonb_typeof(evidence) = 'array'),
  threshold_checks jsonb NOT NULL DEFAULT '[]' CHECK (jsonb_typeof(threshold_checks) = 'array'),
  citations jsonb NOT NULL DEFAULT '[]' CHECK (jsonb_typeof(citations) = 'array'),
  anomaly_summary jsonb NOT NULL DEFAULT '{}' CHECK (jsonb_typeof(anomaly_summary) = 'object'),
  UNIQUE (case_id, revision)
);
CREATE INDEX analyses_node_idx ON aquatrace.case_analyses(located_node);

-- One append-only log produces BOTH actions[] and timeline[].
CREATE TABLE aquatrace.case_events (
  id bigint GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  case_id bigint NOT NULL REFERENCES aquatrace.cases(id),
  event_type text NOT NULL CHECK (event_type IN ('reported','located','status_changed','action','note','analysis_failed')),
  event_at timestamptz NOT NULL,
  recorded_at timestamptz NOT NULL DEFAULT now(),
  actor text NOT NULL,
  message text NOT NULL,
  from_status text,
  to_status text,
  payload jsonb NOT NULL DEFAULT '{}' CHECK (jsonb_typeof(payload) = 'object')
);
CREATE INDEX events_case_idx ON aquatrace.case_events(case_id, event_at DESC, id DESC);

CREATE TABLE aquatrace.plumbers (
  id text PRIMARY KEY,
  name text NOT NULL,
  phone text NOT NULL,
  lat double precision NOT NULL CHECK (lat BETWEEN -90 AND 90),
  lon double precision NOT NULL CHECK (lon BETWEEN -180 AND 180),
  specialty text NOT NULL,
  is_simulated boolean NOT NULL DEFAULT true
);

-- Private schema, no browser grants/policies. Trusted backend connects with a
-- database login. Never add aquatrace to Supabase exposed schemas for this design.
-- RLS is additionally enabled; no policies means deny for unprivileged roles.
DO $$
DECLARE t record;
BEGIN
  FOR t IN SELECT tablename FROM pg_tables WHERE schemaname = 'aquatrace' LOOP
    EXECUTE format('ALTER TABLE aquatrace.%I ENABLE ROW LEVEL SECURITY', t.tablename);
  END LOOP;
END $$;
COMMIT;
