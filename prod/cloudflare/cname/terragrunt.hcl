include "root" {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "git::https://www.github.com/gmmcal/gmmcal-iac-modules.git//modules/cloudflare/dns?ref=v0.1.0"
}

inputs = {
  allow_overwrite = true
  items = [
    {
      type    = "CNAME"
      name    = "calendar"
      content = "ghs.googlehosted.com"
      proxied = false
      ttl     = 1
    },
    {
      type    = "CNAME"
      name    = "drive"
      content = "ghs.googlehosted.com"
      proxied = false
      ttl     = 1
    },
    {
      type    = "CNAME"
      name    = "webmail"
      content = "ghs.googlehosted.com"
      proxied = false
      ttl     = 1
    },
  ]
}
