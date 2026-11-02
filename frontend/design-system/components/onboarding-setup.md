# Onboarding Setup Wizard (`OnboardingSetup`)

Multi-screen setup wizard guiding users through workspace configuration, team invites, and integrations.

- **Source Code**: [`onboarding-setup.tsx`](./onboarding-setup.tsx)
- **Install Command**:
  ```bash
  npx shadcn@latest add https://registry.watermelon.sh/r/onboarding-setup.json
  ```
- **Dependencies**: `motion, lucide-react`

---

## Features
- Step-by-step wizard navigation with back/forward controls
- Card selection grids for use-cases or role selection
- Fluid page transitions with motion/react
- Final completion state

---

## Source & Import

```tsx
import OnboardingSetup from "@/components/ui/onboarding-setup";
```
