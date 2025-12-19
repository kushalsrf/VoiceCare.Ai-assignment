Backend API Service

This service exposes the core user-facing APIs for the Voicecare platform.

Local Development
Prerequisite: Docker

To run locally:
Build the image
docker build -t voicecare-backend .

Run the container
docker run -p 8080:8080 -e DATABASE_URL=postgres://user:pass@localhost/db -e JWT_SECRET=local-secret -e ENV=local voicecare-backend

The service will be available at [http://localhost:8080](http://localhost:8080)

Environment Variables
DATABASE_URL: PostgreSQL connection string
JWT_SECRET: JWT signing secret
ENV: Runtime environment (local or prod)

In cloud deployments, secrets are injected using Secret Manager and accessed via IAM roles assigned to the service account.

Cloud Deployment
The backend is deployed as a Google Cloud Run service.
Public ingress is disabled and the service is exposed only through an API Gateway.
A dedicated service account is used with access limited to databases and secrets.

Deployment Summary
The service is stateless and built using FastAPI.
Minimum scale is set to 1 to avoid cold starts.
Maximum scale is set to 100 based on load testing results.
Target p95 latency is below 300 milliseconds.
Deployments are zero-downtime using Cloud Run revisions.


