# Gooey Search (`GooeySearch`)

An organic metaball search input that morphs into a search field when clicked, with results dropping out like liquid droplets using SVG gooey filters (`feGaussianBlur` + `feColorMatrix`).

- **Source Code**: [`gooey-search.tsx`](./gooey-search.tsx)
- **Registry / Install Command**:
  ```bash
  npx shadcn@latest add https://raw.githubusercontent.com/Ashutoshx7/VengeanceUI/main/public/r/gooey-search.json
  ```
- **Dependencies**: `framer-motion`

---

## Features
- **Metaball / Liquid Droplet Physics**: Search result pills detach organically from the search bar using an embedded SVG filter.
- **Morphing Search Pill**: Starts as an eye-catching button and smoothly expands into an active input field.
- **Built-in Debounce & Loading Spinner**: Debounced query handling with loading spinner and graceful Safari/mobile fallback.
- **Async or Static**: Pass a static `items` array or an `onSearch` async promise callback.

---

## Props Specification

| Prop | Type | Default | Description |
| :--- | :--- | :--- | :--- |
| `items` | `string[]` | `[]` | Static list of string items to search locally. |
| `onSearch` | `(query: string) => Promise<string[]>` | — | Async callback for fetching remote or database search results. |
| `placeholder` | `string` | `"Type to search..."` | Input placeholder text. |
| `buttonLabel` | `string` | `"Search"` | Initial button label before opening. |
| `onSelect` | `(item: string) => void` | — | Callback fired when the user clicks a result droplet. |
| `debounceMs` | `number` | `500` | Input debounce delay in milliseconds. |
| `maxResults` | `number` | `5` | Maximum number of result droplets to render simultaneously. |
| `className` | `string` | `""` | Container class. |

---

## Example Usage

```tsx
import { GooeySearch } from "@/components/ui/gooey-search";

const commandPalette = [
  "Deploy Cluster",
  "Scale Pods",
  "Tail Logs",
  "Restart Service",
  "Inspect Memory",
  "Analyze Trace",
];

export function TopNav() {
  return (
    <div className="flex items-center justify-between p-6">
      <h1 className="font-bold text-xl">HackOps Dashboard</h1>
      <GooeySearch
        items={commandPalette}
        placeholder="Search command or service..."
        onSelect={(selected) => console.log(`Selected action: ${selected}`)}
      />
    </div>
  );
}
```

