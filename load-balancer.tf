resource "google_compute_health_check" "hc" {
  name = "lab-health-check"

# TODO: uncomment the followinnng code

  #check_interval_sec  = 5
  #timeout_sec         = 5
  #healthy_threshold   = 2
  #unhealthy_threshold = 2


  http_health_check {
    port = 80  # this port is wrong to fix this, replace it with 8080
    # uncommet the following linne of code
    #request_path = "/"

  }
}

resource "google_compute_backend_service" "backend" {
  name          = "lab-backend"
  protocol      = "HTTP"
  port_name     = "http"
  health_checks = [google_compute_health_check.hc.id]

  backend {
    group = google_compute_region_instance_group_manager.mig.instance_group
    balancing_mode  = "UTILIZATION"
    capacity_scaler = 1.0

  }
}

resource "google_compute_url_map" "url_map" {
  name            = "lab-url-map"
  default_service = google_compute_backend_service.backend.id
}

resource "google_compute_target_http_proxy" "proxy" {
  name    = "lab-proxy"
  url_map = google_compute_url_map.url_map.id
}

resource "google_compute_global_forwarding_rule" "forwarding_rule" {
  name       = "lab-forwarding-rule"
  target     = google_compute_target_http_proxy.proxy.id
  port_range = "80"
ip_address = google_compute_global_address.lb_ip.address
}
