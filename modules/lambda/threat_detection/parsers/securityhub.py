# threat_detection/parsers/securityhub.py
def is_securityhub_event(event):
    return event.get("source") == "aws.securityhub"

def parse(event):
    detail = event.get("detail", {})
    findings = detail.get("findings", [])
    parsed_findings = []

    for finding in findings:
        parsed_findings.append({
            "source": "securityhub",
            "event_time": finding.get("FirstObservedAt"),
            "title": finding.get("Title"),
            "severity": finding.get("Severity", {}).get("Label"),
            "resource": finding.get("Resources", [{}])[0].get("Id"),
            "description": finding.get("Description"),
            "raw": finding
        })

    return parsed_findings