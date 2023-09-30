terraform {
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

# provider "aws" {
# }

resource "aws_s3_bucket" "s3_bucket" {
  bucket = var.bucket_name

  tags = {
    User_Uuid        = var.user_uuid
  }

}

