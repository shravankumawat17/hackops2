# Project Setup Form (`Form10`)

A production-ready card form from **Watermelon UI** with type-safe schema validation (`zod` + `react-hook-form`), animated inputs with tactile inset bevels, select dropdowns, radio groups, and success toast alerts via `sonner`.

- **Source Code**: [`form-10.tsx`](./form-10.tsx)
- **Install Command**:
  ```bash
  npx shadcn@latest add https://registry.watermelon.sh/r/form-10.json
  ```
- **Dependencies**: `@hookform/resolvers`, `react-hook-form`, `zod`, `sonner`, `react-icons`

---

## Features
- **Type-safe Validation**: Complete Zod schema with instant validation for emails, select options, radio choices, and min-length descriptions.
- **Micro-interactions**: Inputs feature subtle 3D inner shadows and spring scale (`focus:scale-[1.01]`).
- **Integrated Form Components**:
  - `Input` with custom placeholder
  - `Select` / `SelectContent` dropdown
  - `RadioGroup` for goal selection
  - `Textarea` for project briefs
  - `FieldError` badges with error messages
- **Sonner Toast**: Triggers rich success banner toast with `FaCheckDouble` upon submission.

---

## Example Usage

```tsx
import Form10 from "@/components/ui/form-10";

export function CreateProjectPage() {
  return (
    <div className="flex justify-center items-center py-16 px-4">
      <Form10 />
    </div>
  );
}
```

