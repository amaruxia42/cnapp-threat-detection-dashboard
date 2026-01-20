import json
import logging
from typing import Any
from threat_detection.rules_engine import evaluate_event
from threat_detection.parsers import cloudtrail, guardduty, securityhub
from threat_detection.utils.alerts import send_alert

logger = logging.getLogger()
logger.setLevel(logging.INFO)

PARSERS = {
    "aws:cloudtrail": cloudtrail,
    "aws:guardduty": guardduty,
    "aws:securityhub": securityhub
}


def lambda_handler(event: dict[str, Any], context) -> dict[str, Any]:
    """
        Orchestrates the ingestion, parsing, and evaluation of cloud security events.

        Acting as a centralised dispatcher, this function identifies the event source,
        delegates parsing to source-specific logic, and routes identified risks
        to the alerting pipeline.

        Args:
            event: The raw AWS Lambda event payload.
            context: The Lambda execution context object.

        Returns:
            A response dictionary containing the HTTP status code and execution summary.
        """
    source = event.get("source")

    parser = PARSERS.get(source)

    if not parser:
        logger.error(f"Unrecognized event source: {source}")
        return {
            "statusCode": 400,
            "body": json.dumps({"error": f"Unrecognized source: {source}"})
        }

    parsed_event = parser(event)

    if isinstance(parsed_event, dict):
        parsed_event = [parsed_event]

    for item in parsed_event:
        alert = evaluate_event(item)
        if alert:
            send_alert(alert)

    return {
        "statusCode": 200,
          "body": json.dumps({"message": "Event processed successfully"})
          }
