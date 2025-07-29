# threat_detection/parsers/guardduty.py
def is_guardduty_event(event):
    return event.get("source") == "aws.guardduty"

def parse(event):
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