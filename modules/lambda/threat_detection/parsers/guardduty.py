from typing import Any


def is_guardduty_event(event: dict[str, Any]) -> bool:
    """
    Validates if the EventBridge payload originates from AWS GuardDuty.

    Args:
        event: The raw event dictionary from the event bus.

    Returns:
        True if the event source is 'aws.guardduty', otherwise False.
    """
    return event.get("source") == "aws.guardduty"


def parse_guardduty(event: dict[str, Any]) -> dict[str, Any]:
    """
    Normalises a GuardDuty finding into a standardised internal schema.

    This parser prioritises threat-specific metadata, such as finding type
    and severity, while preserving the resource context necessary for
    automated incident response and risk prioritisation on the CNAPP dashboard.

    Args:
        event: The raw GuardDuty finding payload.

    Returns:
        A dictionary containing critical security identifiers, including
        threat description, resource impact, and regional metadata.
    """
    detail = event.get("detail", {})

    return {
        "source": "guardduty",
        "event_time": event.get("time"),
        "finding_type": detail.get("type"),
        "severity": detail.get("severity"),
        "resource": detail.get("resource", {}),
        "region": event.get("region"),
        "title": detail.get("title"),
        "description": detail.get("description"),
        "raw": detail
    }
