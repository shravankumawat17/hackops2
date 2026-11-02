# Frontend Design System & Component Guidelines

> 🚨 **NOTICE TO AI CODING HARNESSES / AGENTS:**  
> **DO NOT** attempt to mount or dump every component into the project!  
> Follow the mandatory step-by-step decision rules in:  
> 👉 [**`AGENT_FRONTEND_PROTOCOL.md`**](../AGENT_FRONTEND_PROTOCOL.md)
> 
> **Purpose**: This repository is the single source of truth for all frontend themes, design tokens, styling rules, and reusable components. Any coding harness, agent, or developer working on the frontend must strictly follow the conventions defined here.

---

## 1. Quick Navigation
- [Design Tokens & Themes](./themes.json)
- [Component Specifications & Code Catalog](./components/README.md)
  - [Buttons & Controls](./components/README.md#-buttons--controls)
  - [Typography & Text Animations](./components/README.md#-typography--text-animations)
  - [Bento Grids, Cards & Accordions](./components/README.md#-bento-grids-cards--accordions)
  - [Inputs, Forms, Search & Modals](./components/README.md#-inputs-forms-search--modals)
  - [Onboarding, Layouts & Navigation](./components/README.md#-onboarding-layouts--navigation)

---

## 2. Core Philosophy & Rules
1. **Clean & Minimal**: Write clean, modern, and readable code. Do not add unwanted libraries or heavy runtime dependencies.
2. **Consistency First**: Always pull colors, font sizes, border radii, and spacing from the designated tokens.
3. **Responsive & Accessible**: Ensure proper semantic markup, contrast ratios, and mobile/desktop responsiveness.
4. **Modularity**: Components should be decoupled, composable, and self-contained.

---

## 3. Theme Specifications
*(Theme tokens, color palettes, dark/light mode configurations will be recorded here and in `themes.json`)*

### Color Palette
- **Primary / Brand**: TBD
- **Secondary / Accent**: TBD
- **Backgrounds**: TBD
- **Surface / Cards**: TBD
- **Text (Primary / Muted)**: TBD
- **Borders & Dividers**: TBD
- **Feedback (Success, Warning, Danger, Info)**: TBD

---

## 4. Components Catalog

### 🔘 Buttons & Controls
- [**AnimatedButton**](./components/animated-button.md) ([Source](./components/animated-button.tsx)) — Theme-aware shine and spring button with `framer-motion`.
- [**GenerateButton**](./components/generate-button.md) ([Source](./components/generate-button.tsx)) — Futuristic glowing AI generator button with animated wave text.
- [**Button9**](./components/button-9.md) ([Source](./components/button-9.tsx)) — Loading button with 3-dot staggered wave bounce animation.
- [**ButtonGroup1**](./components/button-group-1.md) ([Source](./components/button-group-1.tsx)) — Split action button group pairing a main action with a count badge.
- [**ButtonGroup12**](./components/button-group-12.md) ([Source](./components/button-group-12.tsx)) — Connected segmented toolbar button group for views and toolbars.
- [**AdaptiveSlider**](./components/adaptive-slider.md) ([Source](./components/adaptive-slider.tsx)) — Haptic-inspired interactive slider with animated numerical bubbles.
- [**SwitchMode**](./components/switch-mode.md) ([Source](./components/switch-mode.tsx)) — Light/Dark/System triple mode toggle with sliding indicator pill.

### 🔤 Typography & Text Animations
- [**FlipText**](./components/flip-text.md) ([Source](./components/flip-text.tsx)) — 3D character wave flip animation for hero titles and emphasis text.
- [**FlipFadeText**](./components/flip-fade-text.md) ([Source](./components/flip-fade-text.tsx)) — Cycling 3D word rotator with blur transitions and staggered letter timing.
- [**StaggerText**](./components/stagger-text.md) ([Source](./components/stagger-text.tsx)) — Viewport-triggered masked slide-up text reveal by word or letter.

### 📦 Bento Grids, Cards & Accordions
- [**Bento02**](./components/bento-02.md) ([Source](./components/bento-02/index.tsx)) — Interactive bento grid with dynamic map card, analytics preview, and motion transitions.
- [**AgentBentoGrid**](./components/agent-bento-grid.md) ([Source](./components/agent-bento-grid.tsx)) — Comprehensive 5-card AI agent workspace bento grid.
- [**ResearchBentoGrid**](./components/research-bento-grid.md) ([Source](./components/research-bento-grid.tsx)) — Tech-stack showcase with brand logo rotators, live pricing slider card, and pause/resume sprint toggle.
- [**StaggeredGrid**](./components/staggered-grid.md) ([Source](./components/staggered-grid.tsx)) — GSAP ScrollTrigger editorial masonry that morphs into an interactive bento grid.
- [**ExpandableBentoGrid**](./components/expandable-bento-grid.md) ([Source](./components/expandable-bento-grid.tsx)) — Click-to-expand bento cards for feature deep-dives and "Why Us" showcases.
- [**DataTable3**](./components/data-table-3.md) ([Source](./components/data-table-3.tsx)) — Feature-packed data table with search, row selection, and column visibility toggles.
- [**FileUpload1**](./components/file-upload-1.md) ([Source](./components/file-upload-1.tsx)) — Drag-and-drop file uploader card with multi-file queue and live progress bars.
- [**Contact2**](./components/contact-2.md) ([Source](./components/contact-2.tsx)) — Full contact section with channel pills, inputs, and message textarea.
- [**CardSplitAccordion**](./components/card-split-accordian.md) ([Source](./components/card-split-accordian.tsx)) — Dynamic card-splitting accordion with corner-radius morphing.
- [**Accordion3**](./components/accordion-3.md) ([Source](./components/accordion-3.tsx)) — Clean collapsible FAQ accordion with custom icon markers.

### 🔍 Inputs, Forms, Search & Modals
- [**Form10**](./components/form-10.md) ([Source](./components/form-10.tsx)) — Validated project setup form card with Zod, React Hook Form, inputs, select, radio, and Sonner toast.
- [**Form9**](./components/form-9.md) ([Source](./components/form-9.tsx)) — Newsletter or quick sign-up form with Zod email validation, inset bevel styling, and toast alerts.
- [**Notification2**](./components/notification-2.md) ([Source](./components/notification-2.tsx)) — Team notification center with tabs (All, Unread, Mentions), priority tags, and scroll area.
- [**GooeySearch**](./components/gooey-search.md) ([Source](./components/gooey-search.tsx)) — Liquid metaball morphing search bar with organic SVG droplet result pills.
- [**SearchModal / Command Palette**](./components/search-modal.md) ([Source](./components/search-modal.tsx)) — Minimalist `⌘K` command-palette modal with live filtering, tag filters, quick actions, and file attachments.
- [**Combobox10**](./components/combobox-10.md) ([Source](./components/combobox-10.tsx)) — Multi-select tag/badge combobox with removable chips and popover search.
- [**Combobox5**](./components/combobox-5.md) ([Source](./components/combobox-5.tsx)) — Single-select searchable dropdown combobox with checkmark indicator.
- [**Checkbox9**](./components/checkbox-9.md) ([Source](./components/checkbox-9.tsx)) — Card-style multi-select checkboxes with category icons.
- [**ShareSheet**](./components/share-sheet.md) ([Source](./components/share-sheet.tsx)) — Native-style share sheet with social channels, link copying, and in-client QR code generation.
- [**EditProfile**](./components/edit-profile.md) ([Source](./components/edit-profile.tsx)) — Slide-over profile editor drawer with avatar upload and form fields.
- [**Alert10**](./components/alert-10.md) ([Source](./components/alert-10.tsx)) — Dismissible banner/toast alert with leading status icons.

### 🚀 Onboarding, Layouts & Navigation
- [**Navigation5**](./components/navigation-5.md) ([Source](./components/navigation-5.tsx)) — Modern responsive navbar with dropdown menus, mobile sheet drawer, and CTA buttons.
- [**OnboardingScreen**](./components/onboarding-screen.md) ([Source](./components/onboarding-screen.tsx)) — 2-column split modal with animated progress bars and live reactive brand preview card.
- [**OnboardingSetup**](./components/onboarding-setup.md) ([Source](./components/onboarding-setup.tsx)) — Multi-screen setup wizard with card selection grids and back/forward navigation.
- [**OnboardingChecklist**](./components/onboarding-checklist.md) ([Source](./components/onboarding-checklist.tsx)) — Collapsible task checklist card with progress bar and completed checkmarks.
- [**TreeMenu**](./components/tree-menu.md) ([Source](./components/tree-menu.tsx)) — Hierarchical tree navigation menu with nesting, chevrons, and active item indicators.
- [**Collapsible2**](./components/collapsible-2.md) ([Source](./components/collapsible-2.tsx)) — Minimalist file and directory tree with folder open/close state icons.
- [**Pagination8**](./components/pagination-8.md) ([Source](./components/pagination-8.tsx)) — Tooltip-enhanced pagination bar with page numbers and ellipsis.
- [**Avatar15**](./components/avatar-15.md) ([Source](./components/avatar-15.tsx)) — Overlapping avatar stack with team member avatars.
- [**ScheduleDate**](./components/schedule-date.md) ([Source](./components/schedule-date.tsx)) — Interactive calendar date and time slot scheduling booking interface.
- [**ViewOnMap**](./components/view-on-map.md) ([Source](./components/view-on-map.tsx)) — Morphing location card with interactive map viewer and pin pulse animation.
- [**InteractiveBook**](./components/interactive-book.md) ([Source](./components/interactive-book.tsx)) — 3D realistic flipping book with physics, keyboard navigation, and custom page layouts.
- [**MinimalCarousel**](./components/minimal-carousel.md) ([Source](./components/minimal-carousel.tsx)) — Swipeable horizontal card carousel with previous/next arrow controls and dot pagination.
