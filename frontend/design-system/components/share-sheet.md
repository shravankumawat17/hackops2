# Share Sheet (`ShareSheet`)

An iOS/macOS inspired native-feeling share sheet modal with direct links to WhatsApp, Telegram, X, Email, SMS, instant in-client QR code generation (with SVG download), and link copying.

- **Source Code**: [`share-sheet.tsx`](./share-sheet.tsx)
- **Registry / Install Command**:
  ```bash
  npx shadcn@latest add https://raw.githubusercontent.com/Ashutoshx7/VengeanceUI/main/public/r/share-sheet.json
  ```
- **Dependencies**: `framer-motion`, `qrcode-generator`

---

## Features
- **Local QR Code Generator**: Generates crisp, downloadable SVG QR codes entirely in-client without calling third-party APIs.
- **Multiple Channels**: WhatsApp, Telegram, X, Instagram, Email, Messages (SMS), and standard clipboard copy.
- **3 Variants**:
  - `'default'`: Classic grid of share targets with submenus.
  - `'message'`: Includes an optional user message input with a 206-character limit counter.
  - `'compact'`: Minimal pill bar for quick actions.
- **Accessible & Robust**: Body scroll locking, keyboard navigation (focus trap & `Esc` to dismiss), and dark/light mode auto-detection.

---

## Props Specification

| Prop | Type | Default | Description |
| :--- | :--- | :--- | :--- |
| `url` | `string` | `"https://example.com/story"` | The web URL to share or generate a QR code for. |
| `title` | `string` | `"Share this page"` | Modal title / subject line for email & messaging. |
| `variant` | `'default' \| 'message' \| 'compact'` | `'default'` | Display presentation variant. |
| `theme` | `'auto' \| 'dark' \| 'light'` | `'auto'` | Theme mode (auto reacts to system/root dark mode classes). |
| `initialOpen` | `boolean` | `false` | Whether the sheet starts open. |
| `onShare` | `(e: { channel: string; url: string; message: string }) => void` | — | Callback when a share action or channel is chosen. |

---

## Example Usage

```tsx
import { ShareSheet } from "@/components/ui/share-sheet";

export function ShareProjectBar() {
  return (
    <div className="flex items-center gap-4">
      {/* Default share modal with QR code */}
      <ShareSheet
        url="https://hackops.dev/project/demo"
        title="Check out our HackOps Submission!"
        onShare={({ channel }) => console.log(`Shared via ${channel}`)}
      />

      {/* Message variant */}
      <ShareSheet
        variant="message"
        url="https://hackops.dev/invite"
        title="Invite Teammates"
      />
    </div>
  );
}
```

