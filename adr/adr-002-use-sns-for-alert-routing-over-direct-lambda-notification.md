## ADR-002: Use SNS for Alert Routing Over Direct Lambda Notification

## Status
Accepted

## Context:
Once the threat evaluation Lambda processes a finding, an alert must be delivered to one or more destinations (email, SMS, future integrations). Two approaches were considered: Lambda invoking notification endpoints directly, or Lambda publishing to an SNS topic that routes to subscribers.

## Decision:
The Lambda evaluation engine publishes alerts to an SNS topic. Notification endpoints (email, SMS) are configured as SNS subscriptions.

## Reasoning:
Direct Lambda-to-endpoint notification creates tight coupling between the evaluation logic and the delivery mechanism. Adding a new alert destination would require code changes to the Lambda function. SNS provides a fan-out pattern where any number of subscribers can be added or removed independently of the evaluation engine. This also opens the pipeline to future integrations such as SQS queues for downstream processing, Lambda subscribers for automated remediation, or third-party webhook endpoints — without modifying the core detection logic.

## Consequences:
Alert destinations can be managed through SNS subscription configuration rather than code deployments. The evaluation Lambda has a single, stable output contract: publish to SNS. The trade-off is a minor increase in architectural components, though SNS operates at negligible cost at this scale.