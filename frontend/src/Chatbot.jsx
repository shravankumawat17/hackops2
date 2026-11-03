import React, { useState, useRef, useEffect } from 'react';
import { X, Send, Droplets, Globe, Sparkles } from 'lucide-react';

const GROQ_URL = 'https://api.groq.com/openai/v1/chat/completions';
const GROQ_KEY = import.meta.env.VITE_GROQ_API_KEY || '';
const MODEL = 'openai/gpt-oss-120b';

async function fetchWebContext(query) {
  try {
    const clean = query.replace(/[^\w\s]/gi, ' ').trim();
    if (!clean || clean.length < 3) return '';
    const url = `https://en.wikipedia.org/w/api.php?action=query&list=search&srsearch=${encodeURIComponent(clean)}&utf8=&format=json&origin=*`;
    const res = await fetch(url);
    if (!res.ok) return '';
    const data = await res.json();
    const hits = data.query?.search?.slice(0, 3) || [];
    if (!hits.length) return '';
    return hits.map(h => `• ${h.title}: ${h.snippet.replace(/<[^>]+>/g, '')}`).join('\n');
  } catch (err) {
    return '';
  }
}

function buildSystemPrompt(cases, stations, webContext = '') {
  const casesSummary = cases.map(c => {
    const evidenceList = c.diagnosis?.evidence ? (Array.isArray(c.diagnosis.evidence) ? c.diagnosis.evidence.join('; ') : c.diagnosis.evidence) : 'None';
    const historyList = (c.history || []).map(h => `[${h.actor || 'Note'}]: ${h.text}`).join(' | ');
    return `• Case ID: ${c.id}
  - Symptom: ${c.symptom}
  - Location/Address: ${c.address || c.location || 'Unknown'} (Flat ${c.flat || 'N/A'})
  - Status: ${c.status}
  - Stage: ${c.diagnosis?.stage || 'Unknown'}
  - Responsible Owner: ${c.diagnosis?.owner || 'Unknown'}
  - Recommended Action: ${c.diagnosis?.action || 'Inspection'}
  - Evidence: ${evidenceList}
  - History/Updates: ${historyList || 'Submitted'}
  - Resident Notes: ${c.notes || 'None'}`;
  }).join('\n\n');

  const stationsSummary = stations.map(s =>
    `• Station: ${s.name} (${s.area || s.type})
  - pH: ${s.ph} (Permissible: 6.5–8.5)
  - Turbidity: ${s.turbidity} NTU (Acceptable: ≤1 NTU, Permissible: ≤5 NTU)
  - TDS: ${s.tds} mg/L (Acceptable: ≤500 mg/L)
  - Residual Chlorine: ${s.chlorine} mg/L (Recommended: 0.2–1.0 mg/L)
  - Status: ${s.turbidity > 5 ? 'Threshold breach (Attention needed)' : 'Within normal limits'}`
  ).join('\n\n');

  return `You are AquaTrace AI Assistant, a comprehensive water quality, health, and civic support assistant.
You are equipped with BOTH:
1. The citizen's live database (water complaint reports, station telemetry, and IS 10500 standards).
2. Live Web Search capabilities to answer general, scientific, plumbing, and health questions about water.

CAPABILITIES:
- If asked about the citizen's reports, cases, or local monitoring stations: Use the Citizen Database below.
- If asked broader questions about water quality (e.g. water purification methods, RO/UV filters, TDS levels, boiling water, chlorine taste, pipe corrosion, health risks, WHO benchmarks, municipal plumbing): Synthesize the Live Web Search results and your comprehensive scientific knowledge to provide direct, accurate, and actionable answers.
- Format responses cleanly with brief bullet points or paragraphs. Keep answers concise, clear, and helpful.

=== CITIZEN DATABASE: CASES & REPORTS ===
${casesSummary || 'No complaints or cases on file for this user.'}

=== CITIZEN DATABASE: MONITORING STATIONS ===
${stationsSummary || 'No station telemetry currently recorded.'}

=== WATER QUALITY BENCHMARKS (IS 10500:2012) ===
• pH: Acceptable 6.5–8.5 (no relaxation)
• Turbidity: Acceptable ≤ 1 NTU, Permissible ≤ 5 NTU
• Total Dissolved Solids (TDS): Acceptable ≤ 500 mg/L, Permissible ≤ 2,000 mg/L
• Free Residual Chlorine: Minimum 0.2 mg/L at consumer tap to prevent microbial regrowth

=== LIVE WEB SEARCH CONTEXT ===
${webContext || 'No external search snippets required.'}`;
}

export default function Chatbot({ cases = [], stations = [] }) {
  const [open, setOpen] = useState(false);
  const [messages, setMessages] = useState([
    {
      role: 'assistant',
      content: 'Hi! I\'m your AquaTrace AI Assistant with live web search. Ask me about your water reports, telemetry readings, or any water safety, purification, and plumbing questions!'
    }
  ]);
  const [input, setInput] = useState('');
  const [loading, setLoading] = useState(false);
  const [statusText, setStatusText] = useState('');
  const bottomRef = useRef(null);
  const inputRef = useRef(null);

  useEffect(() => {
    bottomRef.current?.scrollIntoView({ behavior: 'smooth' });
  }, [messages, open, loading]);

  useEffect(() => {
    if (open) inputRef.current?.focus();
  }, [open]);

  async function handleSend(e) {
    e.preventDefault();
    const text = input.trim();
    if (!text || loading) return;

    const userMsg = { role: 'user', content: text };
    const next = [...messages, userMsg];
    setMessages(next);
    setInput('');
    setLoading(true);
    setStatusText('Searching web & database…');

    try {
      const webContext = await fetchWebContext(text);
      setStatusText('Formulating response…');

      const apiMessages = [
        { role: 'system', content: buildSystemPrompt(cases, stations, webContext) },
        ...next.map(m => ({ role: m.role, content: m.content }))
      ];

      const res = await fetch(GROQ_URL, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': `Bearer ${GROQ_KEY}`
        },
        body: JSON.stringify({
          model: MODEL,
          messages: apiMessages,
          max_tokens: 380,
          temperature: 0.6
        })
      });

      if (!res.ok) {
        const err = await res.text();
        throw new Error(`API error ${res.status}: ${err}`);
      }

      const data = await res.json();
      const reply = data.choices?.[0]?.message?.content || 'Sorry, I could not generate a response.';
      setMessages(prev => [...prev, { role: 'assistant', content: reply }]);
    } catch (err) {
      setMessages(prev => [
        ...prev,
        {
          role: 'assistant',
          content: 'I had trouble reaching the AI service. If you are asking about your reports, your active cases are listed in your dashboard.'
        }
      ]);
    } finally {
      setLoading(false);
      setStatusText('');
    }
  }

  return (
    <>
      {/* Floating Orb */}
      <button
        className="chatbot-orb"
        onClick={() => setOpen(!open)}
        aria-label={open ? 'Close assistant' : 'Open assistant'}
      >
        {open ? <X size={22} /> : <Droplets size={22} />}
        {!open && <span className="chatbot-orb-ring" />}
      </button>

      {/* Chat Panel */}
      {open && (
        <div className="chatbot-panel">
          <header className="chatbot-header">
            <Droplets size={18} />
            <div className="chatbot-title-box">
              <span>AquaTrace Assistant</span>
              <small><Globe size={11} /> Web search enabled</small>
            </div>
            <button className="chatbot-close" onClick={() => setOpen(false)} aria-label="Close">
              <X size={16} />
            </button>
          </header>

          <div className="chatbot-messages">
            {messages.map((m, i) => (
              <div key={i} className={`chatbot-msg ${m.role}`}>
                {m.role === 'assistant' && (
                  <span className="chatbot-avatar"><Sparkles size={14} /></span>
                )}
                <div className="chatbot-bubble">{m.content}</div>
              </div>
            ))}
            {loading && (
              <div className="chatbot-msg assistant">
                <span className="chatbot-avatar"><Sparkles size={14} /></span>
                <div className="chatbot-bubble chatbot-typing">
                  <span /><span /><span />
                  {statusText && <small className="chatbot-status-text">{statusText}</small>}
                </div>
              </div>
            )}
            <div ref={bottomRef} />
          </div>

          <form className="chatbot-input" onSubmit={handleSend}>
            <input
              ref={inputRef}
              type="text"
              value={input}
              onChange={e => setInput(e.target.value)}
              placeholder="Ask about your reports or search water topics…"
              maxLength={500}
              disabled={loading}
            />
            <button type="submit" disabled={!input.trim() || loading} aria-label="Send">
              <Send size={16} />
            </button>
          </form>
        </div>
      )}
    </>
  );
}
