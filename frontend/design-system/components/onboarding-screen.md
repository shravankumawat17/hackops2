# Onboarding Screen (`OnboardingScreen`)

A modern 2-column interactive onboarding modal from **Watermelon UI** featuring a step-by-step wizard with animated progress bars, live-updating profile preview card, and dark/light mode support.

- **Source Code**: [`onboarding-screen.tsx`](./onboarding-screen.tsx)
- **Registry / Install Command**:
  ```bash
  npx shadcn@latest add https://registry.watermelon.sh/r/onboarding-screen.json
  ```
- **Dependencies**: `motion` (or `framer-motion`), `lucide-react`, `react-icons`

---

## Features
- **Split-Screen Design**: Left side contains step inputs and navigation buttons; right side shows real-time brand card updates.
- **Animated Step Progress Bars**: Smooth spring-animated progress indicators across steps 1, 2, and 3.
- **Live Reactive Card**: Displays user avatar placeholder, real-time updated business/brand name, and verified badge.
- **Complete Callback**: `onComplete` passes collected form state when finished.

---

## Props Specification

| Prop | Type | Default | Description |
| :--- | :--- | :--- | :--- |
| `title` | `string` | `"Business Details"` | Main onboarding step title. |
| `subtitle` | `string` | `"Tell us about your brand..."` | Step subtitle. |
| `businessNameLabel` | `string` | `"Business name"` | First input label. |
| `businessNamePlaceholder` | `string` | `"Enter your name"` | First input placeholder. |
| `legalNameLabel` | `string` | `"Business Legal name"` | Second input label. |
| `legalNamePlaceholder` | `string` | `"Enter your business legal name"` | Second input placeholder. |
| `nextButtonText` | `string` | `"Create business account"` | Next step button label. |
| `finishButtonText` | `string` | `"Finish Setup"` | Final step button label. |
| `onComplete` | `(data: any) => void` | — | Callback fired upon completing all steps. |

---

## Example Usage

```tsx
import { OnboardingScreen } from "@/components/ui/onboarding-screen";

export function OnboardingFlow() {
  const handleSetupComplete = (data: { businessName: string; legalName: string }) => {
    console.log("Account configured:", data);
    // Redirect to dashboard or initialize project workspace
  };

  return (
    <div className="min-h-screen flex items-center justify-center p-4 bg-neutral-950">
      <OnboardingScreen
        title="Project Workspace"
        subtitle="Initialize your agent environment and set permissions."
        businessNameLabel="Workspace Name"
        businessNamePlaceholder="e.g. HackOps Production"
        legalNameLabel="Team Lead Email"
        legalNamePlaceholder="lead@hackops.dev"
        nextButtonText="Continue Setup"
        finishButtonText="Launch Workspace"
        onComplete={handleSetupComplete}
      />
    </div>
  );
}
```

