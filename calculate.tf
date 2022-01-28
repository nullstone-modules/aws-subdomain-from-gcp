locals {
  // If a user specifies '.' for dns-name,
  //   we are going to use ${env}.${domain} as the fqdn instead of ${dns-name}.${env}.${domain}
  dns_name_chunk = data.ns_subdomain.this.dns_name == "." ? "" : "${data.ns_subdomain.this.dns_name}."

  // If user specifies var.create_vanity,
  //   we are going to drop ${env} from the fqdn
  env_chunk = var.create_vanity ? "" : "${data.ns_workspace.this.env_name}."

  subdomain_chunk = "${local.dns_name_chunk}${local.env_chunk}"
  subdomain       = trimsuffix(local.subdomain_chunk, ".")
  fqdn            = "${local.subdomain_chunk}${local.domain_name}"

  // output locals
  name        = aws_route53_zone.this.name
  zone_id     = aws_route53_zone.this.zone_id
  nameservers = aws_route53_zone.this.name_servers
}
