Frontend Service

This service serves the static frontend assets using Nginx.

Local Development
Prerequisite: Docker

To run locally:
Build the image
docker build -t voicecare-frontend .

Run the container
docker run -p 8080:80 voicecare-frontend

The frontend will be accessible at [http://localhost:8080](http://localhost:8080)

Environment Variables
No environment variables are required.
This service is purely static and does not use secrets.

Cloud Deployment
The frontend is deployed on Google Cloud Run.
It is publicly accessible over HTTPS and routed through the HTTPS Load Balancer.
No backend credentials or secrets are configured.

Deployment Summary
The service runs as a static Nginx container.
Minimum scale is set to 0, allowing the service to scale to zero.
Maximum scale is set to 50.
Cold starts are acceptable due to static content and minimal latency impact.



