locals {
  dns_yaml = yamldecode(var.config)
  dns      = { for each in local.dns_yaml : each.friendly_name => each }
}

resource "cloudflare_record" "record" {
  for_each = local.dns

  zone_id = var.cloudflare_zone_id

  # Record
  name = each.value.name
  type = each.value.type

  proxied = lookup(each.value, "proxied", true)
  ttl     = lookup(each.value, "ttl", 1) # defaults to auto

  value    = each.value.data.value
  priority = can(each.value.data.priority) ? each.value.data.priority : null

  # Meta
  comment = lookup(each.value, "comment", "")
}
