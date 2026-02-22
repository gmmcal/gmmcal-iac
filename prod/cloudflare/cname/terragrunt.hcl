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
      type     = "CNAME"
      name     = "calendar"
      content  = "ghs.googlehosted.com"
      proxied  = false
      priority = 1
    },
    {
      type     = "CNAME"
      name     = "drive"
      content  = "ghs.googlehosted.com"
      proxied  = false
      priority = 1
    },
    {
      type     = "CNAME"
      name     = "webmail"
      content  = "ghs.googlehosted.com"
      proxied  = false
      priority = 1
    },
  ]
}
