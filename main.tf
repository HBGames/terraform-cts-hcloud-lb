terraform {
  required_providers {
    # Provider source is used for Terraform discovery and installation of
    # providers. Declare source for all providers required by the module.
    hcloud = {
      source  = "hetznercloud/hcloud"
      version = "1.36.0"
    }
  }
}

resource "hcloud_load_balancer" "load_balancer" {
  name               = "traefik-load-balancer"
  load_balancer_type = "lb11"
  network_zone       = local.consul_services[0].node_meta["hcloud.network_zone"]
}

locals {
  # Group service instances by service name
  # consul_services = {
  #   "app" = [
  #     {
  #       "id" = "app-id-01"
  #       "name" = "app"
  #       "node_address" = "192.168.10.10"
  #     }
  #   ]
  # }
  consul_services = {
    for id, s in var.services : s.name => s...
  }
}
