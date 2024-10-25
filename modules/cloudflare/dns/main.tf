terraform {
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 4.0"
    }
  }
}

provider "cloudflare" {
  api_token = var.cloudflare_token
}

resource "cloudflare_record" "this" {
  for_each = { for index, item in var.items : index => item }

  allow_overwrite = var.allow_overwrite
  zone_id         = "dfe972bed4d38c43a2652967cd649799"
  name            = each.value.name
  content         = each.value.content
  type            = each.value.type
  proxied         = each.value.proxied
  priority        = each.value.priority
}
