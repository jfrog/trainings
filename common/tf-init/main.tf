locals {
  today_date = formatdate("YYYYMMDD", timestamp())
}

resource "artifactory_managed_user" "main" {
  count = var.user_count

  name              = "user${count.index + 1}_${local.today_date}"
  password          = var.user_password
  email             = "user${count.index + 1}@example.com"
  admin             = true
  disable_ui_access = false
}