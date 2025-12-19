# Voicecare AI – DevOps Assignment

## Overview
This repository demonstrates a production-grade DevOps setup for a healthcare AI application composed of multiple microservices.

## Services
- Frontend: Static UI served via Nginx
- Backend: FastAPI-based API service
- AI Worker: Async worker for AI/voice processing

## Infrastructure
- Cloud Provider: GCP
- Compute: Cloud Run
- Networking: Custom VPC + Serverless VPC Connector
- Secrets: GCP Secret Manager
- IAM: One service account per service

## CI/CD
- GitHub Actions
- Docker build & push
- Automated Cloud Run deployments
- Canary-ready via traffic splitting

## Security
- No public databases
- IAM-based service access
- Secrets injected at runtime

## Scaling
- Fully serverless autoscaling
- Async workloads isolated from API path
- Load tested using k6

## Why Cloud Run and not GKE?
Cloud Run reduces operational overhead, attack surface, and cost while meeting all requirements.
GKE would be introduced only for GPU-heavy or stateful workloads.
