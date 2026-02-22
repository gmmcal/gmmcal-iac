terraform {
  required_providers {
    hcloud = {
      source  = "hetznercloud/hcloud"
      version = "~> 1"
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
  for_each = { for index, item in var.firewall_ports : index => item }

  name   = each.value.description
  labels = var.labels

  apply_to {
    server = hcloud_server.this.id
  }

  rule {
    direction   = "in"
    protocol    = "tcp"
    port        = each.value.port
    source_ips = [
      "0.0.0.0/0",
      "::/0"
    ]
  }
}

resource "hcloud_network" "private" {
  name     = "gustavocunha.dev"
  ip_range = "10.0.1.0/24"
  labels   = var.labels
}

resource "hcloud_network_subnet" "this" {
  type         = "cloud"
  network_id   = hcloud_network.private.id
  network_zone = "eu-central"
  ip_range     = "10.0.1.0/24"
}

resource "hcloud_placement_group" "this" {
  name   = "gustavocunha.dev"
  type   = "spread"
  labels = var.labels
}

resource "hcloud_server" "this" {
  name               = "gustavocunha.dev"
  server_type        = var.plan
  location           = "nbg1"
  image              = "ubuntu-24.04"
  ssh_keys           = [data.hcloud_ssh_key.this.id]
  placement_group_id = hcloud_placement_group.this.id
  labels             = var.labels
}

resource "hcloud_server_network" "srvnetwork" {
  server_id  = hcloud_server.this.id
  network_id = hcloud_network.private.id
  ip         = "10.0.1.2"
}
