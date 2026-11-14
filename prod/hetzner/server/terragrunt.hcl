include "root" {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "git::https://www.github.com/gmmcal/gmmcal-iac-modules.git//modules/server?ref=v0.1.0"
}

inputs = {
  plan = "cx23",
  firewall_ports = [
    {
      port        = "443"
      description = "HTTPS Traffic"
    },
    {
      port        = "22"
      description = "SSH Access"
    },
    # {
    #   port        = "5432"
    #   description = "Postgres Access"
    # },
  ],
  labels = {
    "application" : "gustavocunha.dev",
    "environment" : "production",
    "services" : "web.postgres",
    "deployed-with" : "kamal",
    "managed-by" : "terraform",
  }
}
