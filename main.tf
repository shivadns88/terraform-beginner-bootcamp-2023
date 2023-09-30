terraform {

#Following lines of code will be used to migrate the terraform state to terraform cloud
#   cloud {
#     organization = "shivadns88_tech"

#     workspaces {
#       name = "terra-house-one"
#     }
#   }

}

#https://developer.hashicorp.com/terraform/language/modules/sources
module "terrahouse_aws" {
  source = "./modules/terrahouse_aws"
  user_uuid = var.user_uuid
  bucket_name = var.bucket_name
}