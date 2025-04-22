terraform {
  required_version = "~> 1.6"
  required_providers {
    random = {
      source  = "hashicorp/random"
      version = "~> 3.6"
    }
  }
}

module "regions" {
  source           = "ciscoxiaobing/utl-cnregions/azurerm"
  version = "0.1.0"
  use_cached_data  = true
  enable_telemetry = var.enable_telemetry
}

resource "random_integer" "region_index" {
  max = length(module.regions.regions) - 1
  min = 0
}

output "random_region" {
  value = module.regions.regions[random_integer.region_index.result]
}
