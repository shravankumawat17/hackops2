# Interactive Book (`InteractiveBook`)

A 3D realistic flipping book component with realistic page physics, page turning animations, keyboard controls, and customizable page content. Great for interactive portfolios, project showcases, guides, documentation, or hackathon storyboards.

- **Source Code**: [`interactive-book.tsx`](./interactive-book.tsx)
- **Registry / Install Command**:
  ```bash
  npx shadcn@latest add https://raw.githubusercontent.com/Ashutoshx7/VengeanceUI/main/public/r/interactive-book.json
  ```
- **Dependencies**: `framer-motion`, `lucide-react`, `clsx`, `tailwind-merge` (`cn` utility)

---

## Features
- **3D Page Flipping Physics**: Smooth 3D transformations (`perspective-[2000px]`, `preserve-3d`, rotation on the Y-axis).
- **Keyboard Navigation**: Use `Left Arrow` / `Right Arrow` to flip pages and `Escape` to close the book.
- **Rich Page Content**: Accepts any React nodes for both front and back pages (`content` and `backContent`).
- **Interactive Controls**: Built-in next/previous buttons, reset, close button, and slider track scrubber.

---

## Props Specification

### `InteractiveBookProps`
| Prop | Type | Default | Description |
| :--- | :--- | :--- | :--- |
| `coverImage` | `string` | *(required)* | URL or path to the book's front cover artwork. |
| `pages` | `BookPage[]` | *(required)* | Array of book page definitions (see below). |
| `bookTitle` | `string` | `"Book Title"` | Title displayed on the book and headers. |
| `bookAuthor` | `string` | `"Author Name"` | Author name displayed on cover overlay. |
| `width` | `number \| string` | `350` | Width of a single page in pixels. |
| `height` | `number \| string` | `500` | Height of the book in pixels. |
| `className` | `string` | `""` | Additional Tailwind CSS classes. |

### `BookPage` Interface
```ts
export interface BookPage {
  pageNumber: number;
  title?: string;
  content: React.ReactNode;
  backContent?: React.ReactNode;
}
```

---

## Example Usage

```tsx
import InteractiveBook from "@/components/ui/interactive-book";

const demoPages = [
  {
    pageNumber: 1,
    title: "Project Overview",
    content: (
      <div className="p-6">
        <h3 className="text-xl font-bold">HackOps Architecture</h3>
        <p className="mt-2 text-sm text-muted-foreground">
          Autonomous devops and monitoring agent powered by modern AI primitives.
        </p>
      </div>
    ),
  },
  {
    pageNumber: 2,
    title: "Core Features",
    content: (
      <div className="p-6">
        <ul className="list-disc pl-4 space-y-2 text-sm">
          <li>Automated Log Analysis</li>
          <li>Self-Healing Microservices</li>
          <li>Zero-Config Deployments</li>
        </ul>
      </div>
    ),
  },
];

export function Showcase() {
  return (
    <div className="flex justify-center items-center min-h-screen py-10 bg-neutral-900">
      <InteractiveBook
        bookTitle="HackOps Blueprint"
        bookAuthor="Team HackOps"
        coverImage="https://images.unsplash.com/photo-1618005182384-a83a8bd57fbe?q=80&w=600&auto=format&fit=crop"
        pages={demoPages}
        width={360}
        height={520}
      />
    </div>
  );
}
```

