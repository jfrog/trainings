locals {
  today_date = formatdate("YYYYMMDD", timestamp())
}

resource "artifactory_managed_user" "main" {
  for_each = var.users

  name              = "${each.key}_${local.today_date}"
  password          = var.user_password
  email             = each.value
  admin             = true
  disable_ui_access = false
}

resource "artifactory_managed_user" "edge" {
  provider = artifactory.edge
  for_each = var.users

  name              = "${each.key}_${local.today_date}"
  password          = var.user_password
  email             = each.value
  admin             = true
  disable_ui_access = false
}