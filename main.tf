terraform {

  # cloud {
  #   organization = "ORGANIZATION-NAME"
  #   workspaces {
  #     name = "learn-terraform-cloud-migrate"
  #   }
  # }

#Following lines of code will be used to migrate the terraform state to terraform cloud
  cloud {
    organization = "shivadns88_tech"

    workspaces {
      name = "terra-house-one"
    }
  }
  
  required_providers {
    random = {
      source = "hashicorp/random"
      version = "3.5.1"
    }
    aws = {
      source = "hashicorp/aws"
      version = "5.17.0"
    }
  }
}

provider "random" {
  # Configuration options
}

resource "random_string" "bucket_name" {
  length           = 32
  special          = false
  lower = true
  upper = false
}

resource "aws_s3_bucket" "s3_bucket" {
  bucket = random_string.bucket_name.result
}

output "random_bucket_name" {
  value = random_string.bucket_name.id
}
