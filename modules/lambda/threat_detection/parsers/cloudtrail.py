from typing import Any 


def is_cloudtrail(event: dict[str, Any]) -> bool:
    """
    Identifies if the incoming EventBridge payload is an AWS CloudTrail log.

    Args:
        event: The raw event dictionary from Amazon EventBridge.

    Returns:
        True if the event detail-type matches the CloudTrail API call schema.
    """
    return event.get("detail-type") == "AWS API Call via CloudTrail"


def parse_cloudtrail(event: dict[str, Any]) -> dict[str, Any]:
    """
    Normalises a CloudTrail event into a standardised internal schema.

    Extracts core security telemetry—such as identity, source IP, and
    affected resources—to ensure consistent processing by downstream
    evaluation engines and the CNAPP dashboard.

    Args:
        event: The raw CloudTrail event dictionary.

    Returns:
        A flattened dictionary containing essential security metadata.
        """
    detail = event.get("detail", {})
    return {
        "source": "cloudtrail",
        "event_time": event.get("time"),
        "event_source": detail.get("eventName"),
        "user": detail.get("userIdentity", {}).get("arn"),
        "ip_address": detail.get("sourceIPAddress"),
        "resource": detail.get("requestParameters"),
        "raw": detail
    }
