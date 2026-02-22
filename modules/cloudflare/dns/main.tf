terraform {
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 5"
    }
  }
}

provider "cloudflare" {
  api_token = var.cloudflare_token
}

resource "cloudflare_dns_record" "this" {
  for_each = { for index, item in var.items : index => item }

  zone_id         = var.zone_id
  name            = each.value.name
  content         = each.value.content
  type            = each.value.type
  proxied         = each.value.proxied
  priority        = each.value.priority
  ttl             = each.value.ttl
}
