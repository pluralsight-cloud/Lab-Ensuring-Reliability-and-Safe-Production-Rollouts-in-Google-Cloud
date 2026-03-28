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
  #TODO: uncomment the following code
  #target_tags   = ["http-server"] 
}

# Healthchecks #
# TODO uncomment the following block of code

#resource "google_compute_firewall" "allow_health_checks" {
  #name    = "allow-health-checks"
  #network = google_compute_network.vpc.name

  #allow {
    #protocol = "tcp"
    #ports    = ["8080"]
  #}

  #source_ranges = [
    #"130.211.0.0/22",
    #"35.191.0.0/16"
  #]

  #target_tags = ["http-server"]  
#}


