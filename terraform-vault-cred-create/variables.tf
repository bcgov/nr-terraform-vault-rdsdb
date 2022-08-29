variable "vault_addr" {
  description = "address of the Vault server"
  default = "http://127.0.0.1:8200"
}

variable "secret_keys" {
  description = "Keys (Names) For Secrets"
  type        = list(string)
  default     = ["DefaultSysAdmin", "DefaultSchema"]
}
