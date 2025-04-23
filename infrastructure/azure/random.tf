resource "random_id" "this" {
  byte_length = 2
}

resource "random_pet" "this" {
  length    = 1
  separator = ""
}

resource "random_password" "postgresql_user_password" {
  length  = 25
  special = false
}

resource "random_integer" "vnet_cidr" {
  min = 25
  max = 250
}