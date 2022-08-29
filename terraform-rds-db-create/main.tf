variable "name" { default = "aws/db_secrets" }

provider "vault" {
  address         = var.vault_addr
  skip_tls_verify = false
}

provider "aws" {
  region = "ca-central-1"
}

terraform {
  backend "local" {
    path = "terraform.tfstate"
  }
}

resource "random_password" "awsdb" {
  length           = 32
  special          = true
  count            = length(var.secret_keys)
  override_special = "#_^!%"
}

data "vault_generic_secret" "dbsecrets_auth" {
  path = var.name
}

# SECTION RELATED TO DB CREATION ONLY
#

data "aws_vpc" "selected" {
  state = "available"
}

data "aws_subnet" "a" {
  filter {
    name   = "tag:Name"
    values = [var.subnet_a]
  }
}

data "aws_subnet" "b" {
  filter {
    name   = "tag:Name"
    values = [var.subnet_b]
  }
}

data "aws_security_group" "a" {
  filter {
    name   = "tag:Name"
    values = [var.aws_security_group_a]
  }
}
