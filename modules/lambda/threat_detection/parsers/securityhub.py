from typing import Any

def is_securityhub_event(event: dict[str, Any]) -> bool:
    """
    Identifies if the event contains consolidated findings from AWS Security Hub.

    Args:
        event: The raw EventBridge payload.

    Returns:
        True if the source is 'aws.securityhub'.
    """
    return event.get("source") == "aws.securityhub"


def parse_securityhub(event: dict[str, Any]) -> list[dict[str, Any]]:
    """
    Parses and flattens AWS Security Finding Format (ASFF) objects.

    Security Hub events are unique because they can contain multiple findings
    per event. This parser iterates through the findings array to extract
    compliance posture and resource metadata, ensuring that each finding is
    treated as an individual actionable item for the CNAPP dashboard.

    Args:
        event: The raw Security Hub event containing one or more findings.

    Returns:
        A list of normalised finding dictionaries ready for the evaluation engine.
    """
    detail = event.get("detail", {})
    findings = detail.get("findings", [])
    parsed_findings = []

    for finding in findings:
        # ----- Ignore suppressed or archived findings to keep dashboard clean -----
        if finding.get("Workflow", {}).get("Status") == "SUPPRESSED":
            continue

        parsed_findings.append({
            "source": "securityhub",
            "event_time": finding.get("FirstObservedAt"),
            "title": finding.get("Title"),
            "severity": finding.get("Severity", {}).get("Label"),
            "compliance": finding.get("Compliance", {}).get("Status"),
            "resource": finding.get("Resources", [{}])[0].get("Id"),
            "description": finding.get("Description"),
            "raw": finding
        })

    return parsed_findings
