terraform {
  required_providers {
    hcloud = {
      source  = "hetznercloud/hcloud"
      version = "~> 1.0"
    }
  }
}

provider "hcloud" {
  token = var.hetzner_token
}

data "hcloud_ssh_key" "this" {
  name = "gmmcal"
}

resource "hcloud_firewall" "this" {
  name = "gustavocunha.dev"

  # rule {
  #   description = "Allow DB traffic"
  #   direction   = "in"
  #   protocol    = "tcp"
  #   port        = "5432"
  #   source_ips = [
  #     "0.0.0.0/0",
  #     "::/0"
  #   ]
  # }

  rule {
    description = "Allow HTTPS traffic"
    direction   = "in"
    protocol    = "tcp"
    port        = "443"
    source_ips = [
      "0.0.0.0/0",
      "::/0"
    ]
  }

  rule {
    description = "Allow SSH traffic"
    direction   = "in"
    protocol    = "tcp"
    port        = "22"
    source_ips = [
      "0.0.0.0/0",
      "::/0"
    ]
  }
}

resource "hcloud_network" "private" {
  name     = "gustavocunha.dev"
  ip_range = "10.0.1.0/24"
}

resource "hcloud_network_subnet" "this" {
  type         = "cloud"
  network_id   = hcloud_network.private.id
  network_zone = "eu-central"
  ip_range     = "10.0.1.0/24"
}

resource "hcloud_placement_group" "this" {
  name = "gustavocunha.dev"
  type = "spread"
  labels = {
    key = "value"
  }
}

resource "hcloud_server" "this" {
  name               = "gustavocunha.dev"
  server_type        = "cx22"
  location           = "nbg1"
  image              = "ubuntu-24.04"
  ssh_keys           = [data.hcloud_ssh_key.this.id]
  firewall_ids       = [hcloud_firewall.this.id]
  placement_group_id = hcloud_placement_group.this.id
}

resource "hcloud_server_network" "srvnetwork" {
  server_id  = hcloud_server.this.id
  network_id = hcloud_network.private.id
  ip         = "10.0.1.2"
}
