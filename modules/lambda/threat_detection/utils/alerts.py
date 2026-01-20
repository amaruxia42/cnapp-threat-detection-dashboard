import boto3
import json
import os
import logging
from typing import Any

logger = logging.getLogger()
logger.setLevel(logging.INFO)

sns = boto3.client("sns")
TOPIC_ARN = os.environ.get("ALERTS_TOPIC_ARN")

def send_alert(alert: dict[str, Any]) -> None:
    """
    Dispatches security findings to a centralised alerting notification system.

    This function acts as the integration point between the rules engine and 
    external response teams, publishing structured JSON alerts to an AWS SNS 
    topic for downstream consumption by email.

    Args:
        alert (dict[str, Any]): The structured alert object containing 
            findings, metadata, and the event source.

    Raises:
        botocore.exceptions.ClientError: If the SNS publish operation fails 
            due to permissions or network issues.
        """
    if not TOPIC_ARN:
        logger.warning("Alert suppressed: ALERTS_TOPIC_ARN environment variable not set")
        return
    
    message = {
        "summary": f"CNAPP Alert from {alert['source']}",
        "findings": alert["findings"]
    }
    sns.publish(
        TopicArn=TOPIC_ARN,
        Subject="CNAPP Threat Alert",
        Message=json.dumps(message, indent=2)
    )
