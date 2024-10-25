include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "${path_relative_from_include("root")}//modules/cloudflare/dns"
}

dependency "server" {
  config_path = "../server"
}


inputs = {
  items = [
    {
      type     = "A"
      name     = "@"
      content  = dependency.server.outputs.ip_address
      proxied  = false
      priority = 1
    },
    {
      type     = "A"
      name     = "www"
      content  = dependency.server.outputs.ip_address
      proxied  = false
      priority = 1
    },
    {
      type     = "A"
      name     = "db"
      content  = dependency.server.outputs.ip_address
      proxied  = false
      priority = 1
    },
    {
      type     = "A"
      name     = "cache"
      content  = dependency.server.outputs.ip_address
      proxied  = false
      priority = 1
    },
  ]
}
