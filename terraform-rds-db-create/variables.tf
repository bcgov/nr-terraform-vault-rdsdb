variable "vault_addr" {
  description = "address of the Vault server"
  #  default = "http://kubernetes-vault-elb-232188935.us-east-1.elb.amazonaws.com:8200"
  default = "http://127.0.0.1:8200"
}

variable "secret_keys" {
  description = "Keys (Names) For Secrets"
  type        = list(string)
  default     = ["DefaultSysAdmin", "DefaultSchema"]
}

# SECTION BELOW IS FOR THE EXCLUSIVE USE OF DB CREATION
# 

variable "aws_region" {
  description = "AWS region for all resources."

  type    = string
  default = "ca-central-1"
}

variable "aws_security_group_a" {
  description = "Value of the name tag for the security group in AZ a"
  default     = "Data_sg"
}

variable "subnet_a" {
  description = "Value of the name tag for the subnet in AZ a"
  default     = "Data_Dev_aza_net"
}

variable "subnet_b" {
  description = "Value of the name tag for the subnet in AZ b"
  default     = "Data_Dev_azb_net"
}

variable "db_name" {
  description = "The name of the database"
  type        = string
  default     = "demodb"
}

variable "db_username" {
  description = "The username for the DB master user"
  type        = string
  default     = "sysadmin"
  sensitive   = true
}

variable "db_schema" {
  description = "The default schema name for the database"
  type = string
  default = "app_schema"
  sensitive = true
}