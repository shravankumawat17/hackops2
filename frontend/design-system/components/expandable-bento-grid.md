# Expandable Bento Grid (`ExpandableBentoGrid`)

Interactive bento grid where cards expand dynamically into detailed views when clicked, complete with smooth layout transitions and Lucide icons.

- **Source Code**: [`expandable-bento-grid.tsx`](./expandable-bento-grid.tsx)
- **Registry / Install Command**:
  ```bash
  npx shadcn@latest add https://raw.githubusercontent.com/Ashutoshx7/VengeanceUI/main/public/r/expandable-bento-grid.json
  ```
- **Dependencies**: `framer-motion`, `lucide-react`

---

## Features
- **Expandable Cards**: Click any bento card to expand into an immersive modal or detailed expanded card with `layoutId` physics.
- **Why Us / Feature Showcase**: Ideal for "Why Choose Us" sections, feature deep-dives, and capability metrics.
- **Responsive**: Auto-adapts from single column mobile to 3-column desktop bento.

---

## Props & Structure

Each item defines:
- `id`: unique key
- `title`: primary heading
- `description`: concise summary
- `content`: full expanded content
- `icon`: Lucide icon component
- `colSpan` / `rowSpan`: layout grid constraints

