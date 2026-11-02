# Flip Fade Text (`FlipFadeText`)

A word-cycling text rotator with 3D flip, blur dissolve, and staggered letter transitions. Perfect for dynamic hero headers ("Building next-gen [AI / CLOUD / TOOLS]"), loaders, or status indicators.

- **Source Code**: [`flip-fade-text.tsx`](./flip-fade-text.tsx)
- **Registry / Install Command**:
  ```bash
  npx shadcn@latest add https://raw.githubusercontent.com/Ashutoshx7/VengeanceUI/main/public/r/flip-fade-text.json
  ```
- **Dependencies**: `framer-motion`, `clsx`, `tailwind-merge` (`cn` utility)

---

## Features
- **Word Cycler**: Smoothly transitions through an array of words at a configurable interval.
- **3D Flip & Blur Entrance/Exit**: Letters flip along the X-axis while fading in with blur easing (`filter: blur(8px) -> blur(0px)`).
- **Staggered Orchestration**: Letters animate individually with entrance (`staggerDelay`) and exit (`exitStaggerDelay`) pacing.
- **Theme-Aware**: Supports light and dark modes out of the box via Tailwind.

---

## Props Specification

| Prop | Type | Default | Description |
| :--- | :--- | :--- | :--- |
| `words` | `string[]` | `["LOADING", "COMPUTING", "SEARCHING", "RETRIEVING", "ASSEMBLING"]` | Array of words to rotate through. |
| `interval` | `number` | `2500` | Time in milliseconds between word transitions. |
| `letterDuration` | `number` | `0.6` | Duration of each individual letter's animation (seconds). |
| `staggerDelay` | `number` | `0.1` | Delay between consecutive letters on enter (seconds). |
| `exitStaggerDelay` | `number` | `0.05` | Delay between consecutive letters on exit (seconds). |
| `className` | `string` | `""` | Outer container styling. |
| `textClassName` | `string` | `""` | Typography & color classes applied to the animated word. |

---

## Example Usage

```tsx
import { FlipFadeText } from "@/components/ui/flip-fade-text";

export function HeroDynamicTagline() {
  return (
    <div className="py-12 text-center">
      <h2 className="text-xl text-muted-foreground uppercase tracking-widest mb-2">
        Platform Status
      </h2>
      <FlipFadeText
        words={["OPTIMIZING", "SCALING", "MONITORING", "PROTECTING"]}
        interval={2000}
        textClassName="text-5xl font-black text-indigo-500 tracking-wide"
      />
    </div>
  );
}
```

