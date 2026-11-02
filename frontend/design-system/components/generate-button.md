# Generate Button (`GenerateButton`)

A futuristic, glowing AI/generation button with animated sparkling icon, staggered wave text effects, and customizable hue glow.

- **Source Code**: [`generate-button.tsx`](./generate-button.tsx)
- **Registry / Install Command**:
  ```bash
  npx shadcn@latest add https://raw.githubusercontent.com/Ashutoshx7/VengeanceUI/main/public/r/generate-button.json
  ```
- **Dependencies**: None (pure CSS animations embedded in component + standard `cn` helper)

---

## Features
- **Zero External Animation Dependencies**: Self-contained keyframe styles for smooth glow, border bevel, spark flicker, and letter waves.
- **Dynamic Hue Glow**: Supports any custom hue degree (`hue={0-360}`) for theme matching (default is `210` blue).
- **Two States (Generate / Generating)**: Transitions between "Generate" and "Generating" states with staggered character animations.
- **Customizable Control**: Can be controlled via `isGenerating` or allowed to automatically transition on focus/click.

---

## Props Specification

| Prop | Type | Default | Description |
| :--- | :--- | :--- | :--- |
| `hue` | `number` | `210` | Hue angle (0-360) for highlight color (e.g. 210 = blue, 270 = purple, 150 = green, 0 = red). |
| `isGenerating` | `boolean` | `undefined` | Optional controlled generating state. When undefined, triggers on focus/click. |
| `className` | `string` | `""` | Extra Tailwind CSS classes applied to button. |
| `...props` | `ButtonHTMLAttributes` | — | All native HTML button props (`onClick`, `disabled`, `type`, etc.). |

---

## Example Usage

```tsx
import { useState } from "react";
import GenerateButton from "@/components/ui/generate-button";

export function AiPromptBar() {
  const [loading, setLoading] = useState(false);

  const handleGenerate = async () => {
    setLoading(true);
    // Perform AI action
    setTimeout(() => setLoading(false), 3000);
  };

  return (
    <div className="flex items-center gap-4">
      {/* Default Blue Glow */}
      <GenerateButton isGenerating={loading} onClick={handleGenerate} />

      {/* Custom Purple Glow (hue 280) */}
      <GenerateButton hue={280} onClick={() => console.log("Generating with purple glow...")} />
    </div>
  );
}
```

