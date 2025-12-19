AI Worker Service

This service processes asynchronous AI and voice-related workloads.

Local Development
Prerequisite: Docker

To run locally:
Build the image
docker build -t voicecare-worker .

Run the container
docker run -e AI_API_KEY=dummy-key -e ENV=local voicecare-worker

Environment Variables
AI_API_KEY: API key for the external AI provider
ENV: Runtime environment (local or prod)

In cloud deployments, secrets are sourced from Secret Manager using IAM-based access.

Cloud Deployment
The AI worker is deployed on Google Cloud Run.
It has no public ingress and cannot be accessed directly from the internet.
It is triggered internally by the backend service or via internal events.
A dedicated service account is used with limited permissions to access AI APIs and secrets.

Deployment Summary
The worker handles long-running asynchronous tasks.
Minimum scale is set to 0, allowing scale-to-zero.
Maximum scale is set to 30 based on expected workload bursts.
Retry logic with exponential backoff is implemented.
Failures are isolated and do not affect user-facing APIs.


