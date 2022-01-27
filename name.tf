resource "random_string" "resource_suffix" {
  length  = 5
  lower   = true
  upper   = false
  number  = false
  special = false
}

locals {
  tags          = data.ns_workspace.this.tags
  resource_name = "${data.ns_workspace.this.block_ref}-${random_string.resource_suffix.result}"
}
