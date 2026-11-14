include "root" {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "git::https://www.github.com/gmmcal/gmmcal-iac-modules.git//modules/cloudflare/dns?ref=v0.1.0"
}

dependency "server" {
  config_path = "../server"
}


inputs = {
  items = [
    {
      type    = "A"
      name    = "@"
      content = dependency.server.outputs.ip_address
      proxied = false
      ttl     = 1
    },
    {
      type    = "A"
      name    = "www"
      content = dependency.server.outputs.ip_address
      proxied = false
      ttl     = 1
    },
    {
      type    = "A"
      name    = "db"
      content = dependency.server.outputs.ip_address
      proxied = false
      ttl     = 1
    },
    {
      type    = "A"
      name    = "*"
      content = dependency.server.outputs.ip_address
      proxied = false
      ttl     = 1
    },
  ]
}
