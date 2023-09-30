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

#https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_website_configuration
resource "aws_s3_bucket_website_configuration" "website_config" {
  bucket = aws_s3_bucket.s3_bucket.bucket

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}

#https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_object
# Here, /workspace/terraform-beginner-bootcamp-2023 can be replaced with ${path.root}
#https://developer.hashicorp.com/terraform/language/functions/filemd5
  # The filemd5() function is available in Terraform 0.11.12 and later
  # For Terraform 0.11.11 and earlier, use the md5() function and the file() function:
  # etag = "${md5(file("path/to/file"))}"

resource "aws_s3_object" "index_html" {
  bucket = aws_s3_bucket.s3_bucket.bucket
  key    = "index.html"
  source = var.index_html_filepath
  etag = filemd5(var.index_html_filepath)
}

resource "aws_s3_object" "error_html" {
  bucket = aws_s3_bucket.s3_bucket.bucket
  key    = "error.html"
  source = var.error_html_filepath
  etag = filemd5(var.error_html_filepath)
}