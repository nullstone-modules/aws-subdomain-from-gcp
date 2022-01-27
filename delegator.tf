module "delegator" {
  source = "nullstone-modules/dns-delegator/aws"

  zone_id = aws_route53_zone.this.zone_id
  name    = "dns-delegator-${local.resource_name}"
  tags    = local.tags
}
