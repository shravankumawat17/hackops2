# Card Split Accordion (`AccordionApp` / `card-split-accordian`)

A dynamic splitting card accordion from **Watermelon UI** where opening any item physically breaks it out of the card stack, dynamically animating borders, margins, and corner radii with spring physics.

- **Source Code**: [`card-split-accordian.tsx`](./card-split-accordian.tsx)
- **Registry / Install Command**:
  ```bash
  npx shadcn@latest add https://registry.watermelon.sh/r/card-split-accordian.json
  ```
- **Dependencies**: `motion` (or `framer-motion`), `lucide-react`, `react-icons`, `react-use-measure`

---

## Features
- **Dynamic Card Splitting**: When an item opens, it pulls away from the unified stack (`margin-block: 10px`) and dynamically rounds its 4 corners.
- **Smart Border Radius Morphing**: Adjacent cards above and below recalculate their opposing corner radii (`borderBottomLeftRadius`, `borderTopLeftRadius`, etc.) in real time.
- **Zero Layout Glitch / Measured Auto Height**: Content height is calculated accurately using `react-use-measure` bounds.
- **Snappy Spring Easing**: Tuned with high stiffness (`600`) and low damping (`50`) for a tactile physical feel.

---

## Props Specification

| Prop | Type | Default | Description |
| :--- | :--- | :--- | :--- |
| `items` | `AccordionItemData[]` | Default FAQ list | Array of accordion items with `id`, `title`, `icon`, and `content`. |

### `AccordionItemData` Interface
```ts
export interface AccordionItemData {
  id: number;
  title: string;
  icon: React.ReactNode;
  content: string;
}
```

---

## Example Usage

```tsx
import { AccordionApp, AccordionItemData } from "@/components/ui/card-split-accordian";
import { ShieldCheck, Cpu, Zap } from "lucide-react";

const hackathonFaq: AccordionItemData[] = [
  {
    id: 1,
    title: "How does the autonomous agent self-heal?",
    icon: <Zap className="size-5 text-amber-500" />,
    content: "When health checks fail, the agent analyzes runtime logs, isolates the failing container, and redeploys with corrected environment flags automatically.",
  },
  {
    id: 2,
    title: "What AI models are supported?",
    icon: <Cpu className="size-5 text-indigo-500" />,
    content: "Supports Gemini 1.5/2.0, Claude 3.5, and local Ollama endpoints with unified streaming protocols.",
  },
  {
    id: 3,
    title: "Is audit logging included?",
    icon: <ShieldCheck className="size-5 text-emerald-500" />,
    content: "All tool invocations and state changes are hashed and stored in append-only logs for verification.",
  },
];

export function FaqSection() {
  return (
    <section className="py-16">
      <h2 className="text-center text-3xl font-bold mb-8">Frequently Asked Questions</h2>
      <AccordionApp items={hackathonFaq} />
    </section>
  );
}
```

