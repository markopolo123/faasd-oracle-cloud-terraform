# Add a record to the domain
resource "cloudflare_record" "faasd_record" {
  zone_id = var.cloudflare_zone_id
  name    = var.faasd_domain
  value   = oci_core_instance.faasd_instance.public_ip
  type    = "A"
  ttl     = 3600
}