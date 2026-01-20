from typing import Any


def evaluate_event(event: dict[str, Any]) -> dict[str, Any]:
    """
    Performs heuristic analysis on cloud events to identify security risks.

    This function acts as the core transformation layer for the CNAPP dashboard,
    ingesting raw telemetry (e.g., CloudTrail, GuardDuty) and surfacing
    high-priority security findings based on defined compliance and threat rules.

    Args:
        event (dict[str, Any]): The raw event payload from the cloud provider.

    Returns:
        dict[str, Any] | None: A structured finding object containing a list
            of alerts and source metadata, or None if no risks are identified.
    """
    findings: list[str] = []

    # Rule: Detect root account usage CloudTrail uses event_source for action name
    if event.get("event_source") == "ConsoleLogin" and event.get("user", "").endswith(":root"):
        findings.append("Critical: Root account used for console login.")

    # Rule: GuardDuty high-severity and SecurityHub (Labels)
    severity = event.get("severity")
    # Check if severity is numeric GuardDuty 
    if isinstance(severity, (int, float)) and severity >= 7:
        findings.append(f"High severity threat detected: {event.get('title', 'Unknown')}")
    
    # Check if severity is label SecurityHub 
    elif severity == "HIGH" or severity == "CRITICAL":
        findings.append(f"High severity compliance finding: {event.get('title', 'Unknown')}")

    # Rule: Compliance Failures (SecurityHub specific)
    if event.get("compliance") == "FAILED":
        findings.append(f"Compliance violation: {event.get('title')}")

    if not findings:
        return None

    return {
        "findings": findings,
        "source": event.get("source"),
        "event_time": event.get("event_time"),
        "raw": event.get("raw") 
    }
