resource "google_compute_managed_ssl_certificate" "default" {
  name = var.ssl_cert

  managed {
    domains = [var.domain_name]
  }
}
