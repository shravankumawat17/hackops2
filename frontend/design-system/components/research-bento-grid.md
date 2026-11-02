# Research Bento Grid (`ResearchBentoGrid`)

A product & tech-stack bento grid showcase featuring dynamic interactive brand rotators (Docker, Supabase, Cloudflare, Vercel, GitHub), interactive pricing tiles, and a live pause/resume sprint card.

- **Source Code**: [`research-bento-grid.tsx`](./research-bento-grid.tsx)
- **Registry / Install Command**:
  ```bash
  npx shadcn@latest add https://raw.githubusercontent.com/Ashutoshx7/VengeanceUI/main/public/r/research-bento-grid.json
  ```
- **Dependencies**: `framer-motion`, `react-icons`

---

## Features
- **Interactive Stack Showcase**: Rotating brand grid with animated cursor hover effects.
- **Dynamic Pricing / Metric Bento**: Real-time slider and monthly cost calculator tile.
- **Active / Paused Sprint Card**: Interactive toggle showing responsive state change with custom copy.
- **High Visual Fidelity**: Subtle ambient light patterns, invoice bars, and refined typography.

---

## Props Specification

| Prop | Type | Default | Description |
| :--- | :--- | :--- | :--- |
| `monthlyPrice` | `number` | `4800` | Monthly price displayed in pricing card. |
| `currency` | `string` | `"$"` | Currency symbol. |
| `paused` | `boolean` | `false` | Controlled state for sprint pause card. |
| `onPausedChange` | `(paused: boolean) => void` | — | Callback on pause state toggle. |
| `brands` | `ResearchBentoBrand[]` | Default stack | Array of custom tech stack logos and names. |
| `copy` | `Partial<ResearchBentoGridCopy>` | — | Customizable titles, descriptions, and labels. |
| `className` | `string` | `""` | Outer wrapper class. |

---

## Example Usage

```tsx
import { ResearchBentoGrid } from "@/components/ui/research-bento-grid";

export function TechStackBento() {
  return (
    <div className="py-16 max-w-6xl mx-auto">
      <ResearchBentoGrid
        monthlyPrice={299}
        copy={{
          showcaseTitle: "Built on Modern Cloud Primitives",
          showcaseDescription: "Seamlessly deployable across edge runtimes and vector stores.",
        }}
      />
    </div>
  );
}
```

