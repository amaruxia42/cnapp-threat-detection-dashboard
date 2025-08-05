def evaluate_event(event):
    findings = []

    # Example: Detect root account usage
    if event.get("eventName") == "ConsoleLogin" and event.get("userIdentity", {}).get("userName") == "root":
        findings.append("Root account used for login.")

    # Example: GuardDuty high-severity
    if event.get("detail", {}).get("severity", 0) >= 7:
        findings.append(f"High severity finding: {event['detail']['title']}")

    return {
        "findings": findings,
        "source": event.get("source"),
        "raw": event
    } if findings else None