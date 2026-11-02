# Agent Bento Grid (`AgentBentoGrid`)

An AI Agent workspace feature grid layout specifically tailored for autonomous agents, model playgrounds, real-time activity feeds, knowledge bases, and tool inspectors.

- **Source Code**: [`agent-bento-grid.tsx`](./agent-bento-grid.tsx)
- **Registry / Install Command**:
  ```bash
  npx shadcn@latest add https://raw.githubusercontent.com/Ashutoshx7/VengeanceUI/main/public/r/agent-bento-grid.json
  ```
- **Dependencies**: `framer-motion`, `@phosphor-icons/react`

---

## Pre-built Bento Cards Included:
1. **Multi-Agent Orchestration**: Interactive mock agent chat terminal with agent status chips (Planner, Coder, Reviewer).
2. **Model Playground**: Token speed dials, latency meters, and temperature sliders.
3. **Activity Feed**: Live streaming log events with status indicators (success, in-progress, queued).
4. **Knowledge Base**: Interactive vector search preview with similarity scores and connected data sources.
5. **Tool Inspector**: Real-time tool telemetry cards (CLI, Shell, Database, API metrics).

---

## Props Specification

| Prop | Type | Default | Description |
| :--- | :--- | :--- | :--- |
| `className` | `string` | `""` | Container styling and responsive grid overrides. |

Also exports `FeatCard` for composing custom bento tiles:
```tsx
export function FeatCard({
  title,
  description,
  children,
  className
}: {
  title: string;
  description: string;
  children: React.ReactNode;
  className?: string;
})
```

---

## Example Usage

```tsx
import AgentBentoGrid from "@/components/ui/agent-bento-grid";

export function FeaturesSection() {
  return (
    <section className="py-20 px-4 bg-background">
      <div className="text-center max-w-2xl mx-auto mb-12">
        <h2 className="text-3xl font-bold tracking-tight">Autonomous Agent Primitives</h2>
        <p className="mt-3 text-muted-foreground">Everything your autonomous pipeline needs in a single workspace.</p>
      </div>
      <AgentBentoGrid />
    </section>
  );
}
```

