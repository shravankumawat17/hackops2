# AquaTrace frontend

Run `npm install` and `npm run dev` from this directory. Build with `npm run build`. Run domain checks with `npm test`.

The active application is `index.html` + `src/`, built with React, JavaScript, Tailwind CSS, Vite, Lucide and locally bundled Manrope. The earlier `app/` prototype is superseded.

Three local development workspaces: Citizen, Authority, Industry. Use the prefilled `@aquatrace.local` account; no password is required or transmitted. This is not production authentication. Role-scoped views are UX behavior, not security enforcement. The backend must verify identity, role, ownership, and facility scope on every request.

Citizen: dashboard, three-step complaint intake, personal cases, updates, supply network and guidance. Authority: operational dashboard, all cases, status and action updates. Industry: plant cases, facility readings and sample history. All roles have notifications, exports, profile settings and evidence views.

Cases persist under `aq-product-cases`; samples under `aq-samples`; profile under `aq-session`. Storage events sync other tabs. Seeded readings and cases are synthetic. No reports are sent to real authorities.

## Component provenance

`src/components.jsx` adapts four uploaded catalog components:
- `data-table-3.tsx`: visibility state, row selection, column controls; adapted to case records with search, status filters and export.
- `notification-2.tsx`: activity rows, All/Unread tabs, counts; mark-all-read and case navigation implemented.
- `button-group-1.tsx`: grouped action with adjacent count, wired to JSON export.
- `alert-10.tsx`: dismissible alert, with Lucide icons and semantic styling.

Original catalog files remain intact. Domain rules are isolated in `src/domain.js`; the current local persistence adapter is intentionally explicit. Backend authentication, onboarding, role provisioning, live telemetry, server-side notifications and industrial discharge standards remain integration work.
