terraform {
  required_providers {
    ns = {
      source = "nullstone-io/ns"
    }
  }
}

data "ns_workspace" "this" {}

data "ns_connection" "domain" {
  name = "domain"
  type = "domain/gcp"
}

data "ns_subdomain" "this" {
  stack_id = data.ns_workspace.this.stack_id
  block_id = data.ns_workspace.this.block_id
}

provider "google" {
  alias       = "domain"
  credentials = local.delegator_key_file
  project     = local.delegator_project_id
}

locals {
  domain_name        = data.ns_connection.domain.outputs.name
  domain_zone_id     = data.ns_connection.domain.outputs.zone_id
  domain_nameservers = data.ns_connection.domain.outputs.nameservers
  delegator_key_file = base64decode(data.ns_connection.domain.outputs.delegator["key_file"])
  delegator_project_id = lookup(jsondecode(local.delegator_key_file), "project_id")
}
