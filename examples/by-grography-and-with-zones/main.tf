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
  source           = "../../"
  enable_telemetry = var.enable_telemetry
}

# This local variable is used to filter out regions in the United States that do not have zones.
locals {
  us_regions_with_zones = [
    for v in module.regions.regions_by_geography["United States"] : v if v.zones != null
  ]
}

resource "random_shuffle" "two_us_region_names_with_zones" {
  input        = [for v in local.us_regions_with_zones : v.name]
  result_count = 2
}

output "two_us_regions_with_zones" {
  value       = [for v in module.regions.regions : v if contains(random_shuffle.two_us_region_names_with_zones.result, v.name)]
  description = "Outputs two random US regions with zones."
}
