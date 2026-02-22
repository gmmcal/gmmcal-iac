terraform {
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 5"
    }
    hcloud = {
      source  = "hetznercloud/hcloud"
      version = "~> 1"
    }
  }
}

provider "cloudflare" {
  api_token = var.cloudflare_token
}

provider "hcloud" {
  token = var.hetzner_token
}
