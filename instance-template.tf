resource "google_compute_instance_template" "template" {
  name_prefix  = "lab-template-"
  machine_type = "e2-micro"

  disk {
    boot         = true
    auto_delete  = true
    source_image = "debian-cloud/debian-11"
  }

  network_interface {
    network = google_compute_network.vpc.id
    access_config {}
  }

  metadata_startup_script = <<-EOT
    #!/bin/bash
    apt-get update
    apt-get install -y python3
    echo "Hello from MIG" > index.html
    python3 -m http.server 8080 &
  EOT
}