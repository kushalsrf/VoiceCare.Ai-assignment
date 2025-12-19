resource "google_compute_network" "main_vpc" {
  name                    = "voicecare-vpc"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "private_subnet" {
  name          = "private-subnet"
  region        = var.region
  network       = google_compute_network.main_vpc.id
  ip_cidr_range = "10.0.1.0/24"

  private_ip_google_access = true
}
resource "google_vpc_access_connector" "serverless_connector" {
  name          = "cloudrun-connector"
  region        = var.region
  network       = google_compute_network.main_vpc.name
  ip_cidr_range = "10.8.0.0/28"
}
