terraform {

  # cloud {
  #   organization = "ORGANIZATION-NAME"
  #   workspaces {
  #     name = "learn-terraform-cloud-migrate"
  #   }
  # }

#Following lines of code will be used to migrate the terraform state to terraform cloud
#   cloud {
#     organization = "shivadns88_tech"

#     workspaces {
#       name = "terra-house-one"
#     }
#   }
  
  required_providers {
    # random = {
    #   source = "hashicorp/random"
    #   version = "3.5.1"
    # }
    aws = {
      source = "hashicorp/aws"
      version = "5.17.0"
    }
  }
}

provider "aws" {

}

# provider "random" {
#   # Configuration options
# }