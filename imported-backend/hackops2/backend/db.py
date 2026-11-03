"""Shared SQLite helpers."""

import json
import sqlite3
from datetime import datetime, timedelta
from pathlib import Path

BASE = Path(__file__).resolve().parent.parent
DB_PATH = BASE / "hackops.db"


def connect():
    conn = sqlite3.connect(DB_PATH, check_same_thread=False)
    conn.row_factory = sqlite3.Row
    return conn


def one(conn, sql, args=()):
    row = conn.execute(sql, args).fetchone()
    return dict(row) if row else None


def all_rows(conn, sql, args=()):
    return [dict(r) for r in conn.execute(sql, args).fetchall()]


def demo_now(conn):
    """The demo clock: latest sensor timestamp. Keeps seeded scenarios stable."""
    fixed = conn.execute("SELECT value FROM meta WHERE key='scenario_now'").fetchone()
    if fixed:
        return datetime.fromisoformat(fixed["value"])
    row = conn.execute("SELECT MAX(timestamp) AS ts FROM readings").fetchone()
    if row and row["ts"]:
        return datetime.fromisoformat(row["ts"])
    return datetime.now()


def iso(dt):
    return dt.isoformat(sep=" ")


def load_config(name):
    with open(BASE / "config" / name, "r", encoding="utf-8") as f:
        return json.load(f)


def latest_reading(conn, node_id):
    return one(
        conn,
        """
        SELECT r.* FROM readings r
        JOIN sensors s ON s.id = r.sensor_id
        WHERE s.node_id = ? AND r.timestamp <= ?
        ORDER BY r.timestamp DESC LIMIT 1
        """,
        (node_id, iso(demo_now(conn))),
    )


def latest_lab(conn, node_id):
    row = conn.execute(
        "SELECT * FROM lab_tests WHERE node_id = ? ORDER BY date DESC, id DESC LIMIT 1",
        (node_id,),
    ).fetchone()
    return dict(row) if row else None
