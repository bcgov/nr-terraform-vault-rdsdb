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
