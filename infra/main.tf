terraform {
  required_version = ">= 1.5.0"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"
    }
  }
}


provider "google" {
  project = var.project_id
  region  = var.region
}


resource "google_service_account" "backend_sa" {
  account_id   = "backend-sa"
  display_name = "Backend Cloud Run Service Account"
}

resource "google_service_account" "worker_sa" {
  account_id   = "worker-sa"
  display_name = "AI Worker Cloud Run Service Account"
}


resource "google_cloud_run_service" "backend" {
  name     = "backend-api"
  location = var.region

  template {
    spec {
      service_account_name = google_service_account.backend_sa.email

      containers {
        image = var.backend_image

        ports {
          container_port = 8080
        }

        env {
          name = "MONGO_URI"
          value_from {
            secret_key_ref {
              name = google_secret_manager_secret.mongo_uri.secret_id
              key  = "latest"
            }
          }
        }
      }

      vpc_access {
        connector = google_vpc_access_connector.cloudrun_connector.id
        egress    = "ALL_TRAFFIC"
      }
    }
  }

  traffic {
  percent         = 90
  latest_revision = false
  revision_name   = "backend-api-00001"
}

traffic {
  percent         = 10
  latest_revision = true
}

}


resource "google_cloud_run_service" "frontend" {
  name     = "frontend"
  location = var.region

  template {
    spec {
      containers {
        image = var.frontend_image
      }
    }
  }

  traffic {
    percent         = 100
    latest_revision = true
  }
}


resource "google_cloud_run_service" "worker" {
  name     = "ai-worker"
  location = var.region

  template {
    spec {
      service_account_name = google_service_account.worker_sa.email

      containers {
        image = var.worker_image
      }

      vpc_access {
        connector = google_vpc_access_connector.cloudrun_connector.id
        egress    = "ALL_TRAFFIC"
      }
    }
  }

  traffic {
    percent         = 100
    latest_revision = true
  }
}
