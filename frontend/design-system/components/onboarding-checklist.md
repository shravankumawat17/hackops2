# Onboarding Checklist (`OnboardingChecklist`)

Interactive task checklist card showing completion progress, expandable task steps, and action triggers.

- **Source Code**: [`onboarding-checklist.tsx`](./onboarding-checklist.tsx)
- **Install Command**:
  ```bash
  npx shadcn@latest add https://registry.watermelon.sh/r/onboarding-checklist.json
  ```
- **Dependencies**: `motion, lucide-react`

---

## Features
- Overall setup completion percentage bar
- Collapsible step items with completed checkmarks
- Primary CTA button for current active step
- Dismissible or skippable guide drawer

---

## Source & Import

```tsx
import OnboardingChecklist from "@/components/ui/onboarding-checklist";
```
