"""Pipe-graph reasoning: upstream chains, lowest common ancestor, trace paths."""

from .db import all_rows


def load_parents(conn):
    return {r["id"]: r["parent_id"] for r in conn.execute("SELECT id, parent_id FROM nodes")}


def load_nodes(conn):
    return {r["id"]: r for r in all_rows(conn, "SELECT * FROM nodes")}


def chain(parents, node_id):
    """Walk from a node back to its root. Returns [node, parent, grandparent, ...]."""
    out, seen = [], set()
    while node_id and node_id not in seen:
        out.append(node_id)
        seen.add(node_id)
        node_id = parents.get(node_id)
    return out


def depth(parents, node_id):
    return len(chain(parents, node_id)) - 1


def lca(parents, node_ids):
    """Lowest common ancestor of two or more nodes; deepest shared node."""
    if not node_ids:
        return None
    chains = [chain(parents, n) for n in node_ids]
    shared = set(chains[0])
    for c in chains[1:]:
        shared.intersection_update(c)
    if not shared:
        return None
    # chains are ordered node -> root, so the first shared entry is the deepest
    for node in chains[0]:
        if node in shared:
            return node
    return None


def pipe_between(conn, a, b):
    row = conn.execute(
        "SELECT * FROM pipes WHERE (from_node=? AND to_node=?) OR (from_node=? AND to_node=?)",
        (a, b, b, a),
    ).fetchone()
    return dict(row) if row else None


def trace(conn, node_id, include_sources=True):
    """Return the upstream path from node_id to the plant (and optionally source)."""
    parents = load_parents(conn)
    nodes = load_nodes(conn)
    up = chain(parents, node_id)

    path_nodes = [nodes[n] for n in up if n in nodes]
    path_pipes = []
    for i in range(len(up) - 1):
        p = pipe_between(conn, up[i], up[i + 1])
        if p:
            path_pipes.append(p)

    # Sources are parallel branches feeding the plant, NOT a chain. Keep them
    # separate so the UI never renders src_river <- src_lake <- src_bore1.
    sources = []
    if include_sources:
        plant = up[-1] if up else None
        if plant:
            for p in all_rows(conn, "SELECT * FROM pipes WHERE to_node=?", (plant,)):
                src = nodes.get(p["from_node"])
                if src and src["type"] == "source":
                    path_pipes.append(p)
                    sources.append(src["id"])

    return {
        "node_id": node_id,
        "path": [n["id"] for n in path_nodes],
        "nodes": path_nodes,
        "pipes": path_pipes,
        "sources": sources,
    }


def affected_chains(conn, building_ids):
    parents = load_parents(conn)
    return {b: chain(parents, b) for b in building_ids}
