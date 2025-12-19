resource "google_service_account" "backend" { account_id="backend-sa" }resource "google_service_account" "backend_sa" {
  account_id   = "backend-sa"
  display_name = "Backend Service Account"
}

resource "google_service_account" "worker_sa" {
  account_id   = "worker-sa"
  display_name = "AI Worker Service Account"
}

resource "google_project_iam_member" "backend_secret_access" {
  role   = "roles/secretmanager.secretAccessor"
  member = "serviceAccount:${google_service_account.backend_sa.email}"
}

resource "google_project_iam_member" "worker_secret_access" {
  role   = "roles/secretmanager.secretAccessor"
  member = "serviceAccount:${google_service_account.worker_sa.email}"
}
