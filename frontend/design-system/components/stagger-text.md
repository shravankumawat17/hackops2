# Stagger Text (`TextAnimation` / `stagger-text`)

Clean, scroll-triggered text reveal animation that slides text up from an overflow mask either word-by-word or letter-by-letter.

- **Source Code**: [`stagger-text.tsx`](./stagger-text.tsx)
- **Registry / Install Command**:
  ```bash
  npx shadcn@latest add https://raw.githubusercontent.com/Ashutoshx7/VengeanceUI/main/public/r/stagger-text.json
  ```
- **Dependencies**: `framer-motion`

---

## Features
- **Scroll-triggered (`whileInView`)**: Animates smoothly once scrolled into the viewport with `viewport={{ once: true }}`.
- **Masked Slide-up**: Each segment slides up from `y: 110%` to `y: 0%` inside an `overflow-hidden` container.
- **Flexible Splitting**: Toggle between `"word"` (smoother for long copy) or `"letter"` (punchier for titles).
- **Custom Easing**: Uses an authentic cubic bezier curve `[0.22, 1, 0.36, 1]` for crisp physics.

---

## Props Specification

| Prop | Type | Default | Description |
| :--- | :--- | :--- | :--- |
| `children` | `React.ReactNode` (string) | *(required)* | Text content to reveal. |
| `delay` | `number` | `0` | Delay before the staggered animation begins (seconds). |
| `divideBy` | `"word"` \| `"letter"` | `"word"` | Split strategy: word-by-word (stagger 0.05s) or letter-by-letter (stagger 0.02s). |

---

## Example Usage

```tsx
import TextAnimation from "@/components/ui/stagger-text";

export function HeroSection() {
  return (
    <div className="max-w-3xl mx-auto text-center space-y-4">
      {/* Title with letter-by-letter animation */}
      <h1 className="text-6xl font-bold tracking-tight">
        <TextAnimation divideBy="letter" delay={0.2}>
          Empower Your Hackathon
        </TextAnimation>
      </h1>

      {/* Description with word-by-word animation */}
      <p className="text-xl text-muted-foreground">
        <TextAnimation divideBy="word" delay={0.5}>
          Build, ship, and scale intelligent workflows in record time.
        </TextAnimation>
      </p>
    </div>
  );
}
```

