variable "hetzner_token" {
  sensitive   = true
  type        = string
  description = "IP Address of service"
}

variable "firewall_ports" {
  default = []
  type    = list(object({
    port         = string,
    description  = string,
  }))
}

variable "labels" {
  type = map
}
