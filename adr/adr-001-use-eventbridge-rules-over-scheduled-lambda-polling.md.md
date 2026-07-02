# ADR-001: Use EventBridge Rules Over Scheduled Lambda Polling for Event Ingestion

## Status
Accepted

## Date
18-05-2026

## Context
The threat detection pipeline requires near-real-time ingestion of security findings from GuardDuty and Security Hub. Two approaches were considered: scheduled Lambda functions polling the AWS APIs on a fixed interval, or EventBridge rules that react to findings as they are emitted.

## Alternatives Considered


## Decision
EventBridge rules are used to trigger the threat evaluation Lambda in response to GuardDuty and Security Hub events as they occur.

## Reasoning
Scheduled polling introduces latency proportional to the polling interval and generates unnecessary API calls during quiet periods. EventBridge delivers events within seconds of emission, aligns with AWS-native event schemas for GuardDuty and Security Hub, and decouples the detection pipeline from a fixed execution schedule. This is consistent with how production SIEM ingestion pipelines handle event-driven telemetry.
## Consequences
Detection latency is minimised. The architecture scales naturally with finding volume without code changes. EventBridge rule costs are negligible at the expected finding rate.
- **Positive:** 

- **Accepted trade-off:** 
The trade-off is that the pipeline is reactive rather than proactive — it will not surface findings that were never emitted by the source services.

---
