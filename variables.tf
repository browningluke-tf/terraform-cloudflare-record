variable "cloudflare_zone_id" {
  type = string
}

variable "config" {
  description = "yaml data defining dns records"
  type        = string
}
