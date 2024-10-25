variable "cloudflare_token" {
  sensitive   = true
  type        = string
  description = "IP Address of service"
}
variable "items" {
  default = []
  type = list(object({
    name     = string,
    content  = string,
    type     = string,
    proxied  = bool,
    priority = number,
  }))
}
variable "allow_overwrite" {
  type        = bool
  default     = false
  description = "IP Address of service"
}
