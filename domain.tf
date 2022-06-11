data "ns_connection" "domain" {
  name     = "domain"
  type     = "domain/gcp"
  contract = "domain/gcp/cloud-dns"
}

locals {
  domain_name        = data.ns_connection.domain.outputs.name
  domain_zone_id     = data.ns_connection.domain.outputs.zone_id
  domain_nameservers = data.ns_connection.domain.outputs.nameservers
  delegator          = data.ns_connection.domain.outputs.delegator
  delegator_key_file = base64decode(local.delegator["key_file"])
  delegator_project_id = lookup(jsondecode(local.delegator_key_file), "project_id")
}

provider "google" {
  alias       = "domain"
  credentials = local.delegator_key_file
}
