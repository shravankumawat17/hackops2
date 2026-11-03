"""Chlorine decay forecast: first-order decay, projected with a linear trend."""

from datetime import datetime, timedelta

from .db import load_config, demo_now, iso

RULES = load_config("rules.json")
MIN_CHLORINE = RULES["forecast"]["chlorine_minimum_mgl"]
HORIZON = RULES["forecast"]["horizon_hours"]


def _sensor_for(conn, node_id):
    row = conn.execute("SELECT id FROM sensors WHERE node_id=?", (node_id,)).fetchone()
    return row["id"] if row else None


def series(conn, node_id, hours=72):
    sid = _sensor_for(conn, node_id)
    if not sid:
        return []
    rows = conn.execute(
        "SELECT timestamp, residual_chlorine_mgl FROM readings "
        "WHERE sensor_id=? AND timestamp<=? ORDER BY timestamp DESC LIMIT ?",
        (sid, iso(demo_now(conn)), hours),
    ).fetchall()
    return [dict(r) for r in reversed(rows)]


def forecast(conn, node_id):
    rows = series(conn, node_id, 48)
    if len(rows) < 4:
        return {"node_id": node_id, "available": False, "reason": "Not enough sensor history."}

    t0 = datetime.fromisoformat(rows[0]["timestamp"])
    xs, ys = [], []
    for r in rows:
        ts = datetime.fromisoformat(r["timestamp"])
        xs.append((ts - t0).total_seconds() / 3600.0)
        ys.append(r["residual_chlorine_mgl"])

    n = len(xs)
    mean_x = sum(xs) / n
    mean_y = sum(ys) / n
    denom = sum((x - mean_x) ** 2 for x in xs) or 1e-9
    slope = sum((x - mean_x) * (y - mean_y) for x, y in zip(xs, ys)) / denom
    intercept = mean_y - slope * mean_x

    current = ys[-1]
    breached_now = current < MIN_CHLORINE
    now_x = xs[-1]
    projected = []
    crossing = 0 if breached_now else None
    for h in range(1, HORIZON + 1):
        value = max(0.0, intercept + slope * (now_x + h))
        projected.append({
            "hour": h,
            "timestamp": (datetime.fromisoformat(rows[-1]["timestamp"]) + timedelta(hours=h)).isoformat(sep=" "),
            "chlorine": round(value, 3),
        })
        # Only report a *future* crossing when the node is still compliant now.
        if crossing is None and value < MIN_CHLORINE:
            crossing = h

    return {
        "node_id": node_id,
        "available": True,
        "method": RULES["forecast"]["method"],
        "minimum": MIN_CHLORINE,
        "current": round(current, 3),
        "slope_per_hour": round(slope, 5),
        "projected": projected,
        "crossing_hours": crossing,
        "breached_now": breached_now,
        "history": rows,
    }


def anomaly(conn, node_id):
    """Z-score against the same hour on previous days (time-of-day baseline)."""
    rows = series(conn, node_id, 24 * 14)
    if len(rows) < 48:
        return {"node_id": node_id, "available": False, "flags": []}

    buckets = {}
    for r in rows:
        ts = datetime.fromisoformat(r["timestamp"])
        buckets.setdefault(ts.hour, []).append(r["residual_chlorine_mgl"])

    flags = []
    for r in rows[-24:]:
        ts = datetime.fromisoformat(r["timestamp"])
        history = buckets.get(ts.hour, [])
        if len(history) < 3:
            continue
        mean = sum(history) / len(history)
        var = sum((v - mean) ** 2 for v in history) / len(history)
        std = var ** 0.5
        if std < 1e-6:
            continue
        z = (r["residual_chlorine_mgl"] - mean) / std
        if abs(z) >= RULES["anomaly"]["z_threshold"]:
            flags.append({
                "timestamp": r["timestamp"],
                "value": r["residual_chlorine_mgl"],
                "baseline": round(mean, 3),
                "z": round(z, 2),
                "direction": "low" if z < 0 else "high",
            })
    return {
        "node_id": node_id,
        "available": True,
        "method": RULES["anomaly"]["method"],
        "flags": flags,
    }
