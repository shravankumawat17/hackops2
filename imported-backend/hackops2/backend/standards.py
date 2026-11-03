"""Bundled IS 10500 reference rows.

We do NOT ship the whole standard. We ship the limit rows needed to explain a
verdict, with an honest locator, so the demo works offline and never invents a
table number. Always show the 'verify against the official BIS document' caveat.
"""

STANDARDS = [
    {
        "key": "ph",
        "parameter": "pH",
        "acceptable": "6.5 - 8.5",
        "permissible": "No relaxation",
        "unit": "",
        "locator": "IS 10500:2012 - physical and chemical parameters",
    },
    {
        "key": "turbidity_ntu",
        "parameter": "Turbidity",
        "acceptable": "1 NTU",
        "permissible": "5 NTU",
        "unit": "NTU",
        "locator": "IS 10500:2012 - physical parameters",
    },
    {
        "key": "tds_mgl",
        "parameter": "Total dissolved solids",
        "acceptable": "500 mg/L",
        "permissible": "2000 mg/L",
        "unit": "mg/L",
        "locator": "IS 10500:2012 - physical and chemical parameters",
    },
    {
        "key": "residual_chlorine_mgl",
        "parameter": "Free residual chlorine",
        "acceptable": "0.2 mg/L minimum",
        "permissible": "Process control, not a health limit",
        "unit": "mg/L",
        "locator": "IS 10500:2012 - disinfection / process control",
    },
    {
        "key": "total_coliform",
        "parameter": "Total coliform / E. coli",
        "acceptable": "Absent in 100 mL",
        "permissible": "Absent in 100 mL",
        "unit": "per 100 mL",
        "locator": "IS 10500:2012 - bacteriological requirements",
    },
]

CAVEAT = "Verify against the official BIS IS 10500:2012 document before presenting."


def applicable(keys):
    return [s for s in STANDARDS if s["key"] in set(keys)]


def answer(wqi_result):
    """Explain a rule-based verdict using the bundled rows. No LLM, no verdict."""
    if not wqi_result:
        return {
            "available": False,
            "reason": "No sensor reading for this node.",
            "rows": [],
            "caveat": CAVEAT,
        }
    keys = [b["key"] for b in wqi_result.get("breaches", [])]
    rows = applicable(keys)
    if not rows:
        rows = [s for s in STANDARDS if s["key"] in
                ("ph", "turbidity_ntu", "tds_mgl", "residual_chlorine_mgl")]
    return {
        "available": True,
        "offline": True,
        "note": "Retrieved from the bundled IS 10500 limit table. The numeric verdict is rule-based; "
                "this panel only explains it.",
        "rows": rows,
        "breaches": wqi_result.get("breaches", []),
        "override": wqi_result.get("override"),
        "caveat": CAVEAT,
    }
