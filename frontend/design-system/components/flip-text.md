# Flip Text (`FlipText`)

3D character flip animation component for headlines, hero titles, and eye-catching text.

- **Source Code**: [`flip-text.tsx`](./flip-text.tsx)
- **Registry / Install Command**:
  ```bash
  npx shadcn@latest add https://raw.githubusercontent.com/Ashutoshx7/VengeanceUI/main/public/r/flip-text.json
  ```
- **Dependencies**: None (pure CSS 3D transforms & keyframes, 0 extra packages)

---

## Features
- **3D Cube Flip Effect**: Each letter rotates along the 3D X-axis with perspective depth.
- **Natural Stagger**: Sine-wave calculated staggered delays across characters for a fluid wave effect.
- **Zero Libraries**: Doesn't require Framer Motion or GSAP—all CSS keyframes are self-contained.
- **Configurable**: Control loop, duration, custom separators, and simultaneous flip mode.

---

## Props Specification

| Prop | Type | Default | Description |
| :--- | :--- | :--- | :--- |
| `children` | `string` | *(required)* | Text content to animate. |
| `duration` | `number` | `2.2` | Duration in seconds of the flip cycle. |
| `delay` | `number` | `0` | Delay before animation starts (seconds). |
| `loop` | `boolean` | `true` | Loops infinitely if true, or plays once if false. |
| `separator` | `string` | `" "` | Separator used to split words. |
| `together` | `boolean` | `false` | When true, animates all characters at the exact same time without stagger. |
| `className` | `string` | `""` | Extra Tailwind CSS classes (font size, weight, text color). |

---

## Example Usage

```tsx
import { FlipText } from "@/components/ui/flip-text";

export function HeroHeading() {
  return (
    <h1 className="text-5xl font-extrabold tracking-tight">
      <span>Build with </span>
      <FlipText className="text-primary" duration={2.5}>
        HackOps Intelligence
      </FlipText>
    </h1>
  );
}
```

