// React + Vite. Next.js: use process.env.NEXT_PUBLIC_API_BASE_URL instead.
const BASE = import.meta.env.VITE_API_BASE_URL ?? '/api';

export interface NetworkNode {
  id: string; type: string; name: string; parent: string | null;
  lat: number | null; lon: number | null; has_sensor: boolean;
}
export type CaseStatus = 'reported' | 'located' | 'assigned' | 'in_progress' | 'resolved';
export interface ComplaintInput {
  request_id: string;
  household_node: string;
  symptom: 'brown_discolored' | 'cloudy' | 'bad_smell' | 'bad_taste' | 'particles';
  description?: string;
  taps_affected: 'all' | 'hot_only' | 'single_tap';
  since: string; // ISO 8601 WITH timezone; demo input uses +05:30.
  neighbors_affected: boolean | null;
  illness_reported: boolean;
  meter_reading?: number | null;
}
export interface Citation { doc: string; edition: string; clause: string; text: string; source_url?: string }
export interface ThresholdCheck {
  parameter: string; value: number | null; unit: string; limit: number | null;
  minimum?: number | null; maximum?: number | null;
  verdict: 'within_limit' | 'breach' | 'not_evaluated';
  measured_at?: string; node_id?: string; suggested_next_step: string;
}
export interface CaseRecord extends ComplaintInput {
  case_id: string; status: CaseStatus; version: number;
  submitted_at: string; created_at: string; updated_at: string;
  located_node: string | null;
  fault_stage: 'plant_source' | 'distribution_pipeline' | 'building' | 'household' | 'undetermined';
  confidence: 'low' | 'medium' | 'high';
  routed_to: 'plant_operators' | 'bmc' | 'housing_society' | 'citizen' | 'manual_review';
  evidence: string[]; standard_cited: Citation | null;
  threshold_check: ThresholdCheck | null;
  timeline: { id: number; ts: string; event: string; by: string }[];
  actions: { id: number; ts: string; event: string; by: string }[];
}

export function demoSession(): string {
  let id = sessionStorage.getItem('aquatrace_session');
  if (!id) { id = crypto.randomUUID(); sessionStorage.setItem('aquatrace_session', id); }
  return id;
}

async function request<T>(path: string, init: RequestInit = {}): Promise<T> {
  const headers = new Headers(init.headers);
  headers.set('X-Demo-Session', demoSession());
  if (init.body) headers.set('Content-Type', 'application/json');
  const response = await fetch(`${BASE}${path}`, { ...init, headers });
  if (!response.ok) {
    const error = await response.json().catch(() => null);
    throw new Error(error?.error?.message ?? `Request failed (${response.status})`);
  }
  return response.json();
}
export const api = {
  network: () => request<{nodes: NetworkNode[]}>('/network'),
  scenarios: () => request<{id: string; now: string}[]>('/scenarios'),
  selectScenario: (scenario_id: string) => request<{scenario_id: string; now: string}>(
    '/demo/scenario', { method: 'POST', body: JSON.stringify({scenario_id}) }),
  cases: () => request<CaseRecord[]>('/cases'),
  case: (id: string) => request<CaseRecord>(`/cases/${encodeURIComponent(id)}`),
  submit: (data: ComplaintInput) => request<CaseRecord>('/complaints', {
    method: 'POST', body: JSON.stringify(data),
  }),
  status: (record: CaseRecord, status: CaseStatus) => request<CaseRecord>(
    `/cases/${encodeURIComponent(record.case_id)}/status`, {
      method: 'PATCH', body: JSON.stringify({status, expected_version: record.version}),
    }),
};
// A reset starts a fresh session rather than deleting shared seed data.
// Also clear React query/cache + selected case, then select a scenario again.
export function resetDemo() { sessionStorage.removeItem('aquatrace_session'); }
