
def is_cloudtrail(event):
    return event.get("detail-type") == "AWS API Call via Cloudtrail"

def parse(event):
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