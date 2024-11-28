include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "${path_relative_from_include("root")}//modules/server"
}

inputs = {
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
