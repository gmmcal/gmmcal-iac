include "root" {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "${path_relative_from_include("root")}//modules/cloudflare/dns"
}

inputs = {
  allow_overwrite = true
  items = [
    {
      type     = "MX"
      name     = "gustavocunha.dev"
      content  = "aspmx.l.google.com"
      proxied  = false
      priority = 1
      ttl      = 1
    },
    {
      type     = "MX"
      name     = "gustavocunha.dev"
      content  = "aspmx2.googlemail.com"
      proxied  = false
      priority = 10
      ttl      = 1
    },
    {
      type     = "MX"
      name     = "gustavocunha.dev"
      content  = "aspmx3.googlemail.com"
      proxied  = false
      priority = 10
      ttl      = 1
    },
    {
      type     = "MX"
      name     = "gustavocunha.dev"
      content  = "alt1.aspmx.l.google.com"
      proxied  = false
      priority = 5
      ttl      = 1
    },
    {
      type     = "MX"
      name     = "gustavocunha.dev"
      content  = "alt2.aspmx.l.google.com"
      proxied  = false
      priority = 5
      ttl      = 1
    },
  ]
}
