resource "google_compute_region_instance_group_manager" "mig" {
  name   = "lab-mig"
  region = var.region

  base_instance_name = "lab-instance"
  target_size        = 2

  version {
    instance_template = google_compute_instance_template.template.id
  }

  # VALID but bad design
  # TODO: update the max_surge_fixed and max_unavailable_fixed values.

  update_policy {
    type                  = "PROACTIVE"
    minimal_action        = "REPLACE"
    max_surge_fixed       = 0     # remove 0 and update the value with 3.
    max_unavailable_fixed = 3     # remove 3 and update the value with 0.
  }

  named_port {
    name = "http"
    port = 8080
  }


# Autohealig
# TODO: ucomment the followig code to implement the autohealing.

#auto_healing_policies {
    #health_check      = google_compute_health_check.hc.id
    #initial_delay_sec = 60
  #}

}
