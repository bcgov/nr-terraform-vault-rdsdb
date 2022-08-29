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

resource "vault_generic_secret" "awssecrets" {
  path      = var.name
  count     = length(var.secret_keys)
  data_json = <<EOT
    {
    "${var.secret_keys[0]}": "${random_password.awsdb.0.result}",
    "${var.secret_keys[1]}": "${random_password.awsdb.1.result}"
    }
    EOT
}

data "vault_generic_secret" "dbsecrets_auth" {
  path = var.name
}
