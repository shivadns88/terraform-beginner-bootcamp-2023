terraform {
  required_providers {
    terratowns = {
      source = "local.providers/local/terratowns"
      version = "1.0.0"
    }
  }

#Following lines of code will be used to migrate the terraform state to terraform cloud
#   cloud {
#     organization = "shivadns88_tech"

#     workspaces {
#       name = "terra-house-one"
#     }
#   }

}

provider "terratowns" {
  endpoint = var.terratowns_endpoint
  user_uuid = var.teacherseat_user_uuid 
  token = var.terratowns_access_token
}

#https://developer.hashicorp.com/terraform/language/modules/sources
module "terrahouse_aws" {
  source = "./modules/terrahouse_aws"
  user_uuid = var.teacherseat_user_uuid
  index_html_filepath = var.index_html_filepath
  error_html_filepath = var.error_html_filepath
  content_version = var.content_version
  assets_path = var.assets_path
}

resource "terratowns_home" "home" {
  name = "shivaDNS building a home online!!!"
  description = <<DESCRIPTION
Building a home in Canada is not easy.
It is crazy expensive!
I am broke, so building a home online.
DESCRIPTION
  domain_name = module.terrahouse_aws.cloudfront_url
  town = "missingo"
  content_version = 1
}