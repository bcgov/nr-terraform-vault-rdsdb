[![Lifecycle:Experimental](https://img.shields.io/badge/Lifecycle-Experimental-339999)](<Redirect-URL>)

# nr-terraform-db-vault
Set of Terraform scripts intended for the creation of databases in AWS using Terraform and saving/getting secrets from Vault

<i>Requisites</i>:
- Set up your local environment with the respective AWS credentials before running these modules
- Set up your local environment with your Vault Token credentials and Vault path (VAULT_ADDR and VAULT_TOKEN)
- Create a path "aws/db_secrets" in your local or remote Vault


<i>Modules</i>:

<b>terraform-vault-cred-create</b> : Creates a pair of key values, intended to be used by terraform-rds-db-create during the creation of a database.
<b>terraform-rds-db-create</b>     : Retrieves credentials from Vault and creates an RDS Aurora Postgres DB. This module relies on credentials existing in Vault.
