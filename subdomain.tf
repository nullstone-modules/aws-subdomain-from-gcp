resource "aws_route53_zone" "this" {
  name = local.fqdn
  tags = local.tags
}

resource "google_dns_record_set" "this-delegation" {
  provider = google.domain

  managed_zone = local.domain_zone_id
  name         = "${local.fqdn}."
  rrdatas      = aws_route53_zone.this.name_servers
  type         = "NS"
  ttl          = 300
}
