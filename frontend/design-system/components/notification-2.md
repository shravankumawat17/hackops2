# Team Notification Center (`Notification2`)

Interactive notification hub with tabs (All, Unread, Mentions), priority tags, event categories (deploys, alerts, PRs), and scroll area from Watermelon UI.

- **Source Code**: [`notification-2.tsx`](./notification-2.tsx)
- **Install Command**:
  ```bash
  npx shadcn@latest add https://registry.watermelon.sh/r/notification-2.json
  ```
- **Dependencies**: `lucide-react, react-icons, ScrollArea, Tabs, Avatar primitives`

---

## Features
- Filter tabs for All, Unread, and Mentions
- Event categorization for PRs, alerts, team updates, and deploys
- Priority flags (urgent, normal, low)
- Mark as read actions with smooth scroll area

---

## Source & Import

```tsx
import Notification2 from "@/components/ui/notification-2";
```
