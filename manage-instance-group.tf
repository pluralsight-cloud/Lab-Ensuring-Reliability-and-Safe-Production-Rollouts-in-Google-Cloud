resource "google_compute_region_instance_group_manager" "mig" {
  name   = "lab-mig"
  region = var.region

  base_instance_name = "lab-instance"
  target_size        = 2

  version {
    instance_template = google_compute_instance_template.template.id
  }

  update_policy {
    type                  = "PROACTIVE"
    minimal_action        = "REPLACE"
    max_surge_fixed       = 0
    max_unavailable_fixed = 2  # ❌ downtime risk
  }

  named_port {
    name = "http"
    port = 8080
  }
}