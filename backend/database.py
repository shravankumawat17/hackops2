"""
AquaTrace Database Schema & Connection Management
Updated per Plan (2).md with parent hierarchy, plumbers registry, and standards clauses.
"""

import sqlite3
import os
from pathlib import Path

DB_PATH = Path(__file__).resolve().parent / "aquatrace.db"

def get_connection():
    conn = sqlite3.connect(str(DB_PATH))
    conn.row_factory = sqlite3.Row
    return conn

def init_db():
    conn = get_connection()
    cursor = conn.cursor()

    # 1. Dependency Graph Nodes (Tree hierarchy with parent pointer)
    # Source -> Treatment Plant -> Reservoir -> Zone -> Street Segment -> Building Tank -> Household
    cursor.execute("""
    CREATE TABLE IF NOT EXISTS nodes (
        id TEXT PRIMARY KEY,
        type TEXT NOT NULL CHECK(type IN ('source', 'plant', 'reservoir', 'pump', 'zone', 'street_segment', 'building_tank', 'household')),
        name TEXT NOT NULL,
        location TEXT,
        lat REAL,
        lon REAL,
        parent TEXT,
        status TEXT DEFAULT 'NORMAL',
        FOREIGN KEY (parent) REFERENCES nodes(id)
    );
    """)

    # 2. Distribution Pipes
    cursor.execute("""
    CREATE TABLE IF NOT EXISTS pipes (
        id TEXT PRIMARY KEY,
        from_node TEXT NOT NULL,
        to_node TEXT NOT NULL,
        length_m REAL NOT NULL,
        diameter_mm INTEGER NOT NULL,
        material TEXT NOT NULL,
        install_year INTEGER NOT NULL,
        FOREIGN KEY (from_node) REFERENCES nodes(id),
        FOREIGN KEY (to_node) REFERENCES nodes(id)
    );
    """)

    # 3. Water Quality Sensors
    cursor.execute("""
    CREATE TABLE IF NOT EXISTS sensors (
        id TEXT PRIMARY KEY,
        node_id TEXT NOT NULL,
        type TEXT NOT NULL,
        FOREIGN KEY (node_id) REFERENCES nodes(id)
    );
    """)

    # 4. Hourly Sensor Readings
    cursor.execute("""
    CREATE TABLE IF NOT EXISTS readings (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        sensor_id TEXT NOT NULL,
        timestamp TEXT NOT NULL,
        pH REAL NOT NULL,
        turbidity_NTU REAL NOT NULL,
        TDS_mgL REAL NOT NULL,
        residual_chlorine_mgL REAL NOT NULL,
        FOREIGN KEY (sensor_id) REFERENCES sensors(id)
    );
    """)
    cursor.execute("CREATE INDEX IF NOT EXISTS idx_readings_sensor_time ON readings(sensor_id, timestamp);")

    # 5. Microbiological Lab Tests
    cursor.execute("""
    CREATE TABLE IF NOT EXISTS lab_tests (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        node_id TEXT NOT NULL,
        date TEXT NOT NULL,
        total_coliform INTEGER NOT NULL DEFAULT 0,
        e_coli INTEGER NOT NULL DEFAULT 0,
        FOREIGN KEY (node_id) REFERENCES nodes(id)
    );
    """)

    # 6. Citizen Complaints
    cursor.execute("""
    CREATE TABLE IF NOT EXISTS complaints (
        id TEXT PRIMARY KEY,
        timestamp TEXT NOT NULL,
        household_node_id TEXT NOT NULL,
        symptom TEXT NOT NULL,
        taps_affected TEXT NOT NULL DEFAULT 'all',
        since TEXT NOT NULL,
        neighbors_affected INTEGER NOT NULL DEFAULT 0,
        illness_reported INTEGER NOT NULL DEFAULT 0,
        text TEXT,
        status TEXT NOT NULL DEFAULT 'reported',
        FOREIGN KEY (household_node_id) REFERENCES nodes(id)
    );
    """)

    # 7. Cases (Matches Frozen Schema in Section 2)
    cursor.execute("""
    CREATE TABLE IF NOT EXISTS cases (
        case_id TEXT PRIMARY KEY,
        household_node TEXT NOT NULL,
        symptom TEXT NOT NULL,
        taps_affected TEXT NOT NULL DEFAULT 'all',
        since TEXT NOT NULL,
        neighbors_affected INTEGER NOT NULL DEFAULT 0,
        illness_reported INTEGER NOT NULL DEFAULT 0,
        located_node TEXT NOT NULL,
        fault_stage TEXT NOT NULL CHECK(fault_stage IN ('plant/source', 'distribution_pipeline', 'building_tank / internal mains', 'household_plumbing')),
        confidence TEXT NOT NULL CHECK(confidence IN ('high', 'medium', 'low')),
        evidence TEXT NOT NULL,          -- JSON array of strings
        standard_cited TEXT NOT NULL,    -- JSON object {doc, clause, text}
        threshold_check TEXT NOT NULL,   -- JSON object {parameter, value, limit, verdict}
        routed_to TEXT NOT NULL,         -- 'Plant Operators', 'BMC', 'Housing Society', 'Citizen'
        status TEXT NOT NULL CHECK(status IN ('reported', 'located', 'assigned', 'in progress', 'resolved')),
        actions TEXT NOT NULL DEFAULT '[]',   -- JSON array
        timeline TEXT NOT NULL DEFAULT '[]',  -- JSON array of [{ts, event, by}]
        created_at TEXT NOT NULL,
        updated_at TEXT NOT NULL,
        FOREIGN KEY (household_node) REFERENCES nodes(id),
        FOREIGN KEY (located_node) REFERENCES nodes(id)
    );
    """)

    # 8. Certified Nearby Plumbers Directory (Synthetic, for Household Plumbing Faults)
    cursor.execute("""
    CREATE TABLE IF NOT EXISTS plumbers (
        id TEXT PRIMARY KEY,
        name TEXT NOT NULL,
        phone TEXT NOT NULL,
        rating REAL NOT NULL,
        distance_km REAL NOT NULL,
        specialization TEXT NOT NULL,
        address TEXT NOT NULL
    );
    """)

    # 9. Standards & Regulatory Guidelines Knowledge Base (IS 10500:2012 & WHO)
    cursor.execute("""
    CREATE TABLE IF NOT EXISTS standards_clauses (
        id TEXT PRIMARY KEY,
        standard TEXT NOT NULL,
        clause TEXT NOT NULL,
        parameter TEXT NOT NULL,
        acceptable_limit REAL,
        permissible_limit REAL,
        unit TEXT,
        text TEXT NOT NULL,
        action_guidance TEXT NOT NULL
    );
    """)

    # 10. Maintenance Log
    cursor.execute("""
    CREATE TABLE IF NOT EXISTS maintenance_checks (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        node_id TEXT NOT NULL,
        date TEXT NOT NULL,
        check_type TEXT NOT NULL,
        result TEXT NOT NULL,
        FOREIGN KEY (node_id) REFERENCES nodes(id)
    );
    """)

    conn.commit()
    conn.close()

if __name__ == "__main__":
    init_db()
    print("AquaTrace database schema updated successfully.")
