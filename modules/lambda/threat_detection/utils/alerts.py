import boto3
import json
import os

sns = boto3.client("sns")
TOPIC_ARN = os.environ.get("ALERTS_TOPIC_ARN")

def send_alert(alert):
    message = {
        "summary": f"CNAPP Alert from {alert['source']}",
        "findings": alert["findings"]
    }
    sns.publish(
        TopicArn=TOPIC_ARN,
        Subject="CNAPP Threat Alert",
        Message=json.dumps(message, indent=2)
    )