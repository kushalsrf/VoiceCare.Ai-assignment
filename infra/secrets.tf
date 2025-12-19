resource "google_secret_manager_secret" "mongo_uri" {
  secret_id = "mongo-uri"

  replication {
    automatic = true
  }
}

resource "google_secret_manager_secret_version" "mongo_uri_version" {
  secret      = google_secret_manager_secret.mongo_uri.id
  secret_data = "mongodb+srv://user:password@cluster"
}
resource "google_secret_manager_secret" "postgres_uri" {
  secret_id = "postgres-uri"

  replication {
    automatic = true
  }
}

resource "google_secret_manager_secret_version" "postgres_uri_version" {
  secret      = google_secret_manager_secret.postgres_uri.id
  secret_data = "postgresql://user:password@db"
}
