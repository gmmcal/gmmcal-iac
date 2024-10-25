include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "${path_relative_from_include("root")}//modules/cloudflare/dns"
}

inputs = {
  allow_overwrite = true
  items = [
    {
      type     = "A"
      name     = "demo-nix"
      content  = "178.156.148.147"
      proxied  = false
      priority = 1
    },
    {
      type     = "A"
      name     = "demo-docker"
      content  = "178.156.148.147"
      proxied  = false
      priority = 1
    },
    {
      type     = "A"
      name     = "coolify"
      content  = "178.156.148.147"
      proxied  = false
      priority = 1
    },
  ]
}
