# Search Modal & Command Palette (`SearchModal`)

A modern minimalist command-palette (Cmd+K / Ctrl+K) modal featuring filter tags, live filtered results with inline action buttons, keyboard shortcut quick actions, and downloadable file rows.

- **Source Code**: [`search-modal.tsx`](./search-modal.tsx)
- **Registry / Install Command**:
  ```bash
  npx shadcn@latest add https://raw.githubusercontent.com/Ashutoshx7/VengeanceUI/main/public/r/search-modal.json
  ```
- **Dependencies**: `@phosphor-icons/react`

---

## Features
- **Built-in `⌘K` / `Ctrl+K` Hotkey**: Automatic global keyboard listener and `Esc` to close.
- **Dual Display Modes**:
  - `modal={true}` (default): Fullscreen backdrop overlay with centered popup.
  - `modal={false}`: Embeddable inline command palette panel.
- **Categorized Sections**:
  - Removable filter chips/tags (`tags`)
  - Filtered search results with per-row quick actions (`results`)
  - Command palette actions with keyboard shortcuts (`quickActions`)
  - File attachments with verification badges (`files`)
- **Theme-Adaptive**: Native support for dark and light modes.

---

## Props Specification

| Prop | Type | Default | Description |
| :--- | :--- | :--- | :--- |
| `modal` | `boolean` | `true` | When true, renders as fixed backdrop overlay. When false, renders inline. |
| `open` | `boolean` | — | Controlled open/close state. |
| `hotkey` | `string \| null` | `"k"` | Shortcut key paired with ⌘/Ctrl to toggle the modal (`null` disables). |
| `placeholder` | `string` | `"Search or type a command…"` | Input placeholder. |
| `tags` | `SearchTag[]` | Default tags | Removable search chips/tags. |
| `results` | `SearchResult[]` | Default results | People, resources, or records with avatar and action buttons. |
| `quickActions` | `QuickAction[]` | Default actions | Quick actions with keyboard shortcut badges. |
| `files` | `SearchFile[]` | Default files | File attachments with extension indicators and share callbacks. |
| `onSelectResult`| `(item, index) => void` | — | Fired when a search result item is clicked. |

---

## Example Usage

```tsx
import { useState } from "react";
import { SearchModal } from "@/components/ui/search-modal";

export function GlobalSearch() {
  const [open, setOpen] = useState(false);

  return (
    <div>
      <button
        onClick={() => setOpen(true)}
        className="px-3 py-1.5 text-xs text-muted-foreground border rounded-md"
      >
        Press <kbd className="font-mono bg-muted px-1 rounded">⌘K</kbd> to search
      </button>

      <SearchModal
        modal={true}
        open={open}
        onOpenChange={setOpen}
        placeholder="Search services, clusters, logs…"
        quickActions={[
          { label: "Create New Deployment", shortcut: "N", onClick: () => console.log("New") },
          { label: "Restart Failed Pods", shortcut: "R", onClick: () => console.log("Restart") },
        ]}
      />
    </div>
  );
}
```

