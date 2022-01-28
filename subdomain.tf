resource "aws_route53_zone" "this" {
  name = local.fqdn
  tags = local.tags
}

locals {
  // GCP requires nameservers to be FQDNs (i.e. has a trailing '.'), but AWS doesn't expose them with trailing '.'
  fq_name_servers = [for ns in aws_route53_zone.this.name_servers : "${trimsuffix(ns, ".")}."]
}

resource "google_dns_record_set" "this-delegation" {
  provider = google.domain

  project      = local.delegator_project_id
  managed_zone = local.domain_zone_id
  name         = "${local.fqdn}."
  rrdatas      = local.fq_name_servers
  type         = "NS"
  ttl          = 300
}
