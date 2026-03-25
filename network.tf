resource "google_compute_network" "vpc" {
  name                    = "lab-vpc"
  auto_create_subnetworks = true
}

resource "google_compute_firewall" "allow_app" {
  name    = "allow-app-traffic"
  network = google_compute_network.vpc.name

  allow {
    protocol = "tcp"
    ports    = ["8080"]
  }

  source_ranges = ["0.0.0.0/0"]
}