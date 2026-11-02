# Animated Button (`AnimatedButton`)

Shine-bordered, spring-animated button from **VengeanceUI**.

- **Source Code**: [`animated-button.tsx`](./animated-button.tsx)
- **Registry / Install Command**:
  ```bash
  npx shadcn@latest add https://raw.githubusercontent.com/Ashutoshx7/VengeanceUI/main/public/r/animated-button.json
  ```
- **Dependencies**: `framer-motion`, `clsx`, `tailwind-merge` (standard `cn` helper)

---

## Features
- **Theme-aware**: Uses Tailwind CSS variables (`--shine`) adapting automatically between light and dark modes.
- **Micro-interactions**: Spring animations on hover (`scale: 1.01`) and tap (`scale: 0.97`).
- **Looping shine mask**: Linear gradient shine sweep over text and outer border.
- **Polymorphic**: Can render as `button`, `a`, or any custom motion element via the `as` prop.

---

## Props Specification

| Prop | Type | Default | Description |
| :--- | :--- | :--- | :--- |
| `children` | `React.ReactNode` | `"Browse Components"` | Button inner label or JSX elements. |
| `className` | `string` | `""` | Extra Tailwind CSS classes. |
| `as` | `any` | `"button"` | Underlying element type (e.g., `"a"`). |
| `...rest` | `ButtonHTMLAttributes & MotionProps` | — | All native HTML button and Framer Motion props. |

---

## Example Usage

```tsx
import AnimatedButton from "@/components/ui/animated-button";

export function HeroCta() {
  return (
    <div className="flex gap-4">
      <AnimatedButton onClick={() => console.log("Clicked")}>
        Get Started
      </AnimatedButton>

      <AnimatedButton className="bg-primary text-primary-foreground">
        Explore Features
      </AnimatedButton>
    </div>
  );
}
```

