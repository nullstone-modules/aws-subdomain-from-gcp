data "ns_subdomain" "this" {
  stack_id = data.ns_workspace.this.stack_id
  block_id = data.ns_workspace.this.block_id
}

locals {
  subdomain_dns_name = data.ns_subdomain.this.dns_name
}
