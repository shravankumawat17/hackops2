# Staggered Grid (`StaggeredGrid`)

An editorial Codrops-style staggered image grid that transforms on scroll into an interactive Bento Grid with expandable dialog views.

- **Source Code**: [`staggered-grid.tsx`](./staggered-grid.tsx)
- **Registry / Install Command**:
  ```bash
  npx shadcn@latest add https://raw.githubusercontent.com/Ashutoshx7/VengeanceUI/main/public/r/staggered-grid.json
  ```
- **Dependencies**: `gsap`, `imagesloaded`, `react-icons`

---

## Features
- **GSAP ScrollTrigger**: Smooth scrubbing animations where columns move in opposite directions as user scrolls.
- **Center Reveal Headline**: Staggered character reveal driven by scroll position.
- **Transition to Bento**: Seamlessly morphs from editorial masonry into an interactive multi-column Bento layout.

---

## Props Specification

| Prop | Type | Default | Description |
| :--- | :--- | :--- | :--- |
| `images` | `string[]` | *(required)* | Array of image URLs for the staggered masonry. |
| `bentoItems` | `BentoItem[]` | *(required)* | Array of bento cards (`title`, `subtitle`, `description`, `icon`, `image`, `content`). |
| `centerText` | `string` | `"Halcyon"` | Center hero headline revealed on scroll. |
| `className` | `string` | `""` | Extra CSS container classes. |
| `showFooter` | `boolean` | `true` | Toggles credit footer. |

---

## Example Usage

```tsx
import { StaggeredGrid } from "@/components/ui/staggered-grid";
import { FaBolt, FaShieldAlt, FaRocket } from "react-icons/fa";

const sampleImages = [
  "https://images.unsplash.com/photo-1618005182384-a83a8bd57fbe?w=800",
  "https://images.unsplash.com/photo-1550745165-9bc0b252726f?w=800",
  "https://images.unsplash.com/photo-1579783900882-c0d3dad7b119?w=800",
];

const sampleBento = [
  {
    id: 1,
    title: "Instant Scaling",
    subtitle: "Zero to Million",
    description: "Autoscaling cloud agents ready on demand.",
    icon: <FaBolt />,
  },
  {
    id: 2,
    title: "Military-Grade Security",
    subtitle: "Encrypted at rest",
    description: "End-to-end confidential computing primitives.",
    icon: <FaShieldAlt />,
  },
];

export function HeroGrid() {
  return <StaggeredGrid images={sampleImages} bentoItems={sampleBento} centerText="HACKOPS" />;
}
```

