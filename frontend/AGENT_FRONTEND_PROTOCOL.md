# 🤖 Frontend Execution Protocol for Coding Agents & Harnesses

> **CRITICAL DIRECTIVE FOR AI AGENTS / CODING HARNESSES:**  
> DO NOT jump into implementing or stuffing all cataloged components into the project at once.  
> The catalog in `design-system/components/` is a **curated parts warehouse**, NOT a checklist to dump onto a page.  
> Over-stuffing components or using mismatched hardcoded colors is a strict failure. Follow the 4-step execution sequence below before writing ANY frontend code.

---

## 🎯 Step 1: Align on Problem Statement & Core Architecture
Before touching any UI component:
1. **Understand the Product Scope**:
   - What is the hackathon problem statement?
   - What are the **1 to 3 primary screens** needed for the MVP demo? (e.g., Landing Hero $\to$ Interactive Dashboard $\to$ Action Modal).
2. **Select Only High-Impact Components**:
   - Use the **Decision Matrix** in Section 4 below.
   - Choose strictly **3 to 6 components** for the entire project. The remaining components in the warehouse must remain unused.
3. **Never Mix Conflicting Primitives**:
   - ❌ **DO NOT** render multiple search bars on the same view (choose *either* `SearchModal` [Cmd+K] *or* `GooeySearch`, never both).
   - ❌ **DO NOT** stack multiple bento grids on top of each other (choose *one* primary bento: `AgentBentoGrid` for AI agents, `Bento02` for location/metrics, or `ResearchBentoGrid` for tech stacks).
   - ❌ **DO NOT** use `InteractiveBook` unless the product specifically features a narrative guide, portfolio showcase, or storyboard.

---

## 🎨 Step 2: Theme & Color Tokenization (No Hardcoded Watermelon Colors!)

> ⚠️ **IMPORTANT WARNING ON COMPONENT COLORS:**  
> Many Watermelon UI components contain hardcoded hex colors (e.g., `#272729`, `#545359`, `#FAFAFA`, `#131313`, orange/yellow badges).  
> **YOU MUST RE-SKIN AND THEME-NORMALIZE THEM** before rendering.

### The Rule of Semantic Tailwind Tokens
Every component imported must be converted to use standard Tailwind/CSS variable tokens:
| Replace Hardcoded Hex | With Semantic Tailwind Class |
| :--- | :--- |
| `bg-[#FAFAFA]`, `bg-white`, `bg-[#131313]`, `bg-[#0A0A0A]` | `bg-card` / `bg-background` / `bg-muted/50` |
| `text-[#1A1A1A]`, `text-[#272729]`, `dark:text-white` | `text-foreground` / `text-card-foreground` |
| `text-[#808080]`, `text-[#545359]`, `text-[#6C6C6C]` | `text-muted-foreground` |
| `border-black/10`, `border-[#1D1D1D]`, `border-[#E5E5E5]` | `border-border` |
| `bg-[#1A1A1A]`, `bg-black`, hardcoded dark buttons | `bg-primary text-primary-foreground hover:bg-primary/90` |
| Accent yellow/orange/green badges | `bg-primary/10 text-primary border-primary/20` |

### Prompting the User for Theme
If the user has not specified a color palette, ask once or pick from the curated presets in [`design-system/themes.json`](./design-system/themes.json):
1. **Neo-Agentic Slate & Indigo** (Best for AI Agents, Dev Tools, HackOps)
2. **Cyber Emerald & Obsidian** (Best for Security, Infra, High-Performance)
3. **Monochrome Noir & Pearl** (Best for Ultra-clean Minimalist B2B SaaS)
4. **Vibrant Electric Violet & Midnight** (Best for Consumer, Creative, Web3)

---

## 🧭 Step 3: Decision Matrix — Which Component for Which Use Case?

Use this table to choose the appropriate components based on the hackathon project type:

| Product Archetype | Recommended Components | Anti-patterns (Avoid) |
| :--- | :--- | :--- |
| **AI Agent / Autopilot SaaS** (e.g., HackOps) | • `AgentBentoGrid` (Core features)<br>• `GenerateButton` (AI triggers)<br>• `SearchModal` (⌘K command bar)<br>• `Notification2` (Agent live feed)<br>• `AnimatedButton` (Primary CTA) | Avoid `InteractiveBook`, `Contact2`, `AdaptiveSlider` |
| **DevOps / Cloud / Infra Monitoring** | • `DataTable3` (Service/pod list)<br>• `Notification2` (Incident/deploy alerts)<br>• `Collapsible2` or `TreeMenu` (Cluster tree)<br>• `SearchModal` (Command palette)<br>• `Button9` (Async actions) | Avoid `InteractiveBook`, `MinimalCarousel`, `GooeySearch` |
| **B2B SaaS / Product Platform** | • `Navigation5` (Header & mobile sheet)<br>• `ExpandableBentoGrid` or `Bento02` (Features)<br>• `Form10` or `OnboardingScreen` (Setup flow)<br>• `CardSplitAccordion` (FAQ / Details)<br>• `ShareSheet` (Referrals & invites) | Avoid using both `OnboardingScreen` AND `OnboardingSetup` together |
| **Analytics / Data Product** | • `DataTable3` (Data tables)<br>• `Combobox10` (Tag filters)<br>• `AdaptiveSlider` (Range/threshold controls)<br>• `Pagination8` (Table pagination)<br>• `FileUpload1` (Dataset ingestion) | Avoid decorative text flippers on dense analytical dashboards |
| **Interactive Showcase / Demo** | • `FlipFadeText` or `StaggerText` (Hero reveal)<br>• `InteractiveBook` (3D Storyboard/doc demo)<br>• `MinimalCarousel` (Feature carousel)<br>• `ViewOnMap` (Spatial/map demo) | Avoid heavy forms or complex multi-level tree menus |

---

## 🏗️ Step 4: Component Architecture & Code Cleanliness Standards

Strict rules to follow when coding:

1. **Dependency Hygiene**:
   - Check `package.json` before importing.
   - Standardize animation libraries: if the project uses `framer-motion`, replace `import { motion } from 'motion/react'` with `import { motion } from 'framer-motion'`.
   - Use Lucide icons (`lucide-react`) as the primary icon set. If a component imports `react-icons` or `@phosphor-icons`, map them to equivalent Lucide icons to avoid bloat whenever possible.
2. **Single Source of Truth**:
   - Always reuse `@/lib/utils` (`cn`) for class merging.
   - Do not duplicate CSS keyframes. If a component uses an inline `<style>` tag, verify it doesn't conflict with global styles.
3. **Progressive Assembly**:
   - **Step A**: Layout shell (`Navigation5` + main container + footer).
   - **Step B**: Hero section (`StaggerText` or `FlipText` + `AnimatedButton`).
   - **Step C**: Single Core Experience (1 Bento Grid OR 1 Data Table OR 1 Interactive Flow).
   - **Step D**: Polish with modals (`SearchModal` on ⌘K, `ShareSheet`, or `Notification2`).

---

## 📋 Harness Checklist Before Declaring "Frontend Done"

- [ ] Does the page have a clear visual hierarchy with one dominant focal point?
- [ ] Are all hardcoded `#hex` colors replaced with semantic Tailwind tokens?
- [ ] Is dark mode and light mode contrast verified (no dark text on dark backgrounds)?
- [ ] Are animations subtle and not causing layout shifting (CLS)?
- [ ] Is the total component count balanced (no gratuitous feature dumping)?
- [ ] Does mobile screen width (<640px) wrap and respond gracefully?

