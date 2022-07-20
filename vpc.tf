# VPC
resource "google_compute_network" "default" {
  name                    = var.vpc_network
  provider                = google-beta
  auto_create_subnetworks = false
}

# subnet
resource "google_compute_subnetwork" "default" {
  name          = var.vpc_subnet
  provider      = google-beta
  ip_cidr_range = "10.0.1.0/24"
  region        = var.region
  network       = google_compute_network.default.id
}

#load balancer Ip
resource "google_compute_global_address" "default" {
  provider = google-beta
  name = var.lb_ip_address
}

#firewall rule allow health checks
resource "google_compute_firewall" "default" {
  name          = var.firewall_rule
  provider      = google-beta
  direction     = "INGRESS"
  network       = google_compute_network.default.id
  source_ranges = ["130.211.0.0/22", "35.191.0.0/16"]
  allow {
    protocol = "tcp"
    ports    = ["80"]
  }
  target_tags = ["allow-health-check"]
}
