# Data Table 3 (`DataTable3`)

A feature-rich, accessible interactive Data Table from **Watermelon UI** with real-time search filtering, row selection checkboxes, column visibility toggles, bulk actions, and status badge formatting.

- **Source Code**: [`data-table-3.tsx`](./data-table-3.tsx)
- **Install Command**:
  ```bash
  npx shadcn@latest add https://registry.watermelon.sh/r/data-table-3.json
  ```
- **Dependencies**: `lucide-react`, Table, Checkbox, DropdownMenu, Input primitives

---

## Features
- **Real-time Search Filter**: Live search matching across names, emails, and IDs.
- **Column Visibility Selector**: Dropdown menu allowing users to show/hide specific columns dynamically.
- **Row Multi-Selection**: Select all or individual rows with master checkbox synchronization.
- **Formatted Status Badges**: Pre-styled visual indicators for `paid`, `processing`, `review`, and `failed`.
- **Bulk Action Bar**: Floating or toolbar actions for batch operations on selected rows.

---

## Example Usage

```tsx
import DataTable3 from "@/components/ui/data-table-3";

export function InvoicesPage() {
  return (
    <div className="p-8 max-w-6xl mx-auto space-y-6">
      <div>
        <h2 className="text-2xl font-bold tracking-tight">Agent Invoices & Usage</h2>
        <p className="text-muted-foreground text-sm">Monitor billing, compute hours, and payment status.</p>
      </div>
      <DataTable3 />
    </div>
  );
}
```

