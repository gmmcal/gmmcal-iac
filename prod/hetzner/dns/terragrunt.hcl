include "root" {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "../../../modules/cloudflare/dns"
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
