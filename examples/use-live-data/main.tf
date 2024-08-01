terraform {
  required_version = "~> 1.6"
  required_providers {}
}

module "regions" {
  source           = "../../"
  use_cached_data  = false
  enable_telemetry = var.enable_telemetry
}

output "regions" {
  value = module.regions.regions
}
