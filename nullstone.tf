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
  credentials = base64decode(data.ns_connection.domain.outputs.delegator["key_file"])
  alias       = "domain"
}

locals {
  domain_name        = data.ns_connection.domain.outputs.name
  domain_zone_id     = data.ns_connection.domain.outputs.zone_id
  domain_nameservers = data.ns_connection.domain.outputs.nameservers
}
