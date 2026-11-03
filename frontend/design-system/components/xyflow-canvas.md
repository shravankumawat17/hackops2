# React Flow / XYFlow Agent Canvas Theme (`xyflow-theme.css`)

Custom stylesheet and node theming for **@xyflow/react** (React Flow), specifically configured for agent workflow node graphs, microservice topologies, pipeline canvases, and interactive diagrams in both dark and light modes.

- **Stylesheet Location**: [`frontend/design-system/xyflow-theme.css`](../xyflow-theme.css)
- **Primary Package**: `@xyflow/react` (or `reactflow`)

---

## 🎨 Theme Variables & Custom Controls

### Built-in XYFlow Tokens
| Variable | Light Default | Dark Default | Purpose |
| :--- | :--- | :--- | :--- |
| `--xy-background-color` | `#f7f9fb` | `#101012` | Canvas infinite canvas background |
| `--xy-node-background-color-default` | `#ffffff` | `#1a1b1e` | Default node card background |
| `--xy-node-border-default` | `1px solid #ededed` | `1px solid #303238` | Default node boundary border |
| `--xy-theme-selected` | `#f57dbd` | `#f57dbd` | Node highlight border when selected |
| `--xy-handle-background-color-default` | `#ffffff` | `#141519` | Node connection socket port handle |
| `--xy-handle-border-color-default` | `#aaaaaa` | `#5a5d66` | Node connection socket border |

### Custom Canvas Controls Classes
- `.xy-theme__button` & `.xy-theme__button-group`: Pill action buttons for canvas zoom, reset, lock, and layout.
- `.xy-theme__input`: Input fields inside custom node configurations.
- `.xy-theme__select`: Dropdown selectors for model/agent picker inside nodes.
- `.xy-theme__checkbox`: Toggle checkboxes for active node flags.

---

## Example Usage with React Flow

```tsx
import React, { useCallback } from 'react';
import {
  ReactFlow,
  MiniMap,
  Controls,
  Background,
  useNodesState,
  useEdgesState,
  addEdge,
  Connection,
} from '@xyflow/react';
import '@xyflow/react/dist/style.css';
import '@/design-system/xyflow-theme.css'; // Import the custom theme here!

const initialNodes = [
  { id: '1', position: { x: 100, y: 100 }, data: { label: '🤖 Planner Agent' } },
  { id: '2', position: { x: 350, y: 100 }, data: { label: '⚡ Tool Execution Engine' } },
  { id: '3', position: { x: 600, y: 100 }, data: { label: '📊 Telemetry Logger' } },
];

const initialEdges = [
  { id: 'e1-2', source: '1', target: '2', animated: true },
  { id: 'e2-3', source: '2', target: '3' },
];

export function AgentWorkflowCanvas() {
  const [nodes, , onNodesChange] = useNodesState(initialNodes);
  const [edges, setEdges, onEdgesChange] = useEdgesState(initialEdges);

  const onConnect = useCallback(
    (params: Connection) => setEdges((eds) => addEdge(params, eds)),
    [setEdges]
  );

  return (
    <div className="h-[600px] w-full border rounded-xl overflow-hidden shadow-sm">
      <ReactFlow
        nodes={nodes}
        edges={edges}
        onNodesChange={onNodesChange}
        onEdgesChange={onEdgesChange}
        onConnect={onConnect}
        fitView
      >
        <Controls />
        <MiniMap />
        <Background gap={12} size={1} />
      </ReactFlow>
    </div>
  );
}
```
