variable "cloudflare_token" {
  sensitive   = true
  type        = string
  description = "IP Address of service"
}
variable "items" {
  default = []
  type = list(object({
    name     = string,
    ttl      = number,
    content  = string,
    type     = string,
    proxied  = bool,
    priority = optional(number),
  }))
}

variable "allow_overwrite" {
  type        = bool
  default     = false
  description = "IP Address of service"
}

variable "zone_id" {
  type        = string
  default     = "dfe972bed4d38c43a2652967cd649799"
}
