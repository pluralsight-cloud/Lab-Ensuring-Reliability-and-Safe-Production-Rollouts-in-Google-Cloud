output "load_balancer_ip" {
  value = google_compute_global_forwarding_rule.forwarding_rule.ip_address
}

output "load_balancer_url" {
  value = "http://${google_compute_global_forwarding_rule.forwarding_rule.ip_address}"
}
