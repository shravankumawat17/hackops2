"""Water Quality Index with an explicit worst-parameter override.

Risk direction: 0 = perfect, 100 = worst. This is stated in the UI on purpose.
"""

from .db import latest_lab, latest_reading, load_config

LIMITS = load_config("limits.json")
PARAMS = LIMITS["parameters"]

PARAM_TO_COLUMN = {
    "ph": "ph",
    "turbidity_ntu": "turbidity_ntu",
    "tds_mgl": "tds_mgl",
    "residual_chlorine_mgl": "residual_chlorine_mgl",
}

READING_LABELS = {
    "ph": "pH",
    "turbidity_ntu": "Turbidity",
    "tds_mgl": "TDS",
    "residual_chlorine_mgl": "Residual chlorine",
}


def clamp(x):
    return max(0.0, min(100.0, x))


def sub_index(key, value, spec):
    direction = spec["direction"]
    if direction == "range":
        ideal = spec["ideal"]
        if value < ideal:
            limit = spec["permissible_min"]
            return clamp(100.0 * (ideal - value) / max(ideal - limit, 1e-9))
        limit = spec["permissible_max"]
        return clamp(100.0 * (value - ideal) / max(limit - ideal, 1e-9))
    if direction == "max":
        return clamp(100.0 * value / max(spec["permissible_max"], 1e-9))
    if direction == "min":
        minimum = spec["minimum"]
        if value >= minimum:
            return 0.0
        return clamp(100.0 * (minimum - value) / max(minimum, 1e-9))
    return 0.0


def band_for(score):
    for i, b in enumerate(LIMITS["wqi"]["bands"]):
        if score <= b["max"]:
            return i, b
    return len(LIMITS["wqi"]["bands"]) - 1, LIMITS["wqi"]["bands"][-1]


def evaluate(conn, node_id):
    reading = latest_reading(conn, node_id)
    if not reading:
        return None
    lab = latest_lab(conn, node_id)

    parts = []
    breach = []
    weighted = 0.0
    weight_sum = 0.0

    for key, spec in PARAMS.items():
        if key == "total_coliform":
            continue
        value = reading[PARAM_TO_COLUMN[key]]
        q = sub_index(key, value, spec)
        w = spec["wqi_weight"]
        weighted += q * w
        weight_sum += w
        parts.append({
            "key": key,
            "label": READING_LABELS[key],
            "value": value,
            "unit": spec["unit"],
            "sub_index": round(q, 1),
            "weight": w,
            "contribution": round(q * w, 2),
        })

        if spec["direction"] == "max":
            if value > spec["permissible_max"]:
                breach.append(_breach(key, value, spec["permissible_max"], "permissible"))
            elif value > spec["acceptable_max"]:
                breach.append(_breach(key, value, spec["acceptable_max"], "acceptable"))
        elif spec["direction"] == "range":
            if value < spec["permissible_min"] or value > spec["permissible_max"]:
                breach.append(_breach(key, value, spec["permissible_max"], "permissible"))
        elif spec["direction"] == "min":
            if value < spec["minimum"]:
                breach.append(_breach(key, value, spec["minimum"], "process",
                                      note="Below disinfection minimum; process control, not a health standard."))

    coliform = None
    if lab:
        coliform = lab.get("total_coliform")
        if coliform == "present" or lab.get("e_coli") == "present":
            q = 100.0
            spec = PARAMS["total_coliform"]
            w = spec["wqi_weight"]
            weighted += q * w
            weight_sum += w
            parts.append({
                "key": "total_coliform",
                "label": "Total coliform",
                "value": coliform,
                "unit": "per 100 mL",
                "sub_index": q,
                "weight": w,
                "contribution": round(q * w, 2),
            })
            breach.append({
                "key": "total_coliform",
                "label": "Total coliform",
                "value": coliform,
                "limit": "absent",
                "severity": "micro",
                "note": "Presence in 100 mL is an automatic worst-parameter override.",
            })

    score = weighted / weight_sum if weight_sum else 0.0
    band_index, band = band_for(score)

    override = None
    severe = [b for b in breach if b["severity"] in ("permissible", "micro")]
    if severe:
        # Any permissible-limit breach or coliform presence cannot be averaged away.
        if band_index < 3:
            override = (
                f"{severe[0]['label']} breached its permissible limit "
                f"({severe[0]['value']} vs {severe[0]['limit']}); "
                "rating raised to Unsafe regardless of the weighted average."
            )
            band_index = 3
            band = LIMITS["wqi"]["bands"][3]
    elif breach and band_index < 2:
        override = f"{breach[0]['label']} exceeded its acceptable limit; rating capped at Poor."
        band_index = 2
        band = LIMITS["wqi"]["bands"][2]

    # Keep the displayed number inside the band the override forced it into,
    # so the UI never says "score 68.9 / Unsafe" and invites a contradiction.
    floors = [0.0, 25.1, 50.1, 75.1]
    if score < floors[band_index]:
        score = floors[band_index]

    driving = max(parts, key=lambda p: p["contribution"]) if parts else None

    return {
        "node_id": node_id,
        "score": round(score, 1),
        "band": band["label"],
        "band_index": band_index,
        "colour": band["colour"],
        "parts": parts,
        "breaches": breach,
        "override": override,
        "driving_parameter": driving,
        "coliform": coliform,
        "caveat": LIMITS["wqi"]["caveat"],
        "reading_timestamp": reading["timestamp"],
        "lab": lab,
    }


def _breach(key, value, limit, severity, note=None):
    spec = PARAMS[key]
    return {
        "key": key,
        "label": READING_LABELS[key],
        "value": value,
        "limit": limit,
        "unit": spec["unit"],
        "severity": severity,
        "note": note or ("Above the permissible limit." if severity == "permissible"
                         else "Above the acceptable limit."),
    }
