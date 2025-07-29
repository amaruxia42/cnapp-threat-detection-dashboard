
from threat_detection.rules_engine import evaluate_event
from threat_detection.parsers import cloudtrail, guardduty, securityhub
from threat_detection.utils.alerts import send_alert

def lambda_handler(event, context):
    source = event.get("source", "")

    if source == "aws:cloudtrail":
        parsed = cloudtrail.parse(event)
    elif source == "aws:guardduty":
        parsed = guardduty.parse(event)
    elif source == "aws:securityhub":
        parsed = securityhub.parse(event)
    else:
        print("Unrecognized event source", source)
        return {"statusCode": 400, "body": "Unrecognized source"}

    alert = evaluate_event(parsed)

    if alert:
        send_alert(alert)

    return {"statusCode": 200, "body": "Processed"}