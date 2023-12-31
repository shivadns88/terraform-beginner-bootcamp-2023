resource "aws_s3_bucket" "s3_bucket" {
  #bucket = var.bucket_name
# we need to assign a random bucket name
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

  #https://developer.hashicorp.com/terraform/language/meta-arguments/lifecycle

resource "aws_s3_object" "index_html" {
  bucket = aws_s3_bucket.s3_bucket.bucket
  key    = "index.html"
  source = "${var.public_path}/index.html"
  content_type = "text/html"

  etag = filemd5("${var.public_path}/index.html")

  lifecycle {
    replace_triggered_by = [terraform_data.content_version.output]
    ignore_changes = [etag]
      # Ignore changes to etags
  }
}

resource "aws_s3_object" "upload_assets" {
  for_each = fileset("${var.public_path}/assets", "*.{jpg,png,gif}")
  bucket = aws_s3_bucket.s3_bucket.bucket
  key    = "assets/${each.key}"
  source = "${var.public_path}/assets/${each.key}"
  etag = filemd5("${var.public_path}/assets/${each.key}")
  lifecycle {
    replace_triggered_by = [terraform_data.content_version.output]
    ignore_changes = [etag]
      # Ignore changes to etags
  }
}

resource "aws_s3_object" "error_html" {
  bucket = aws_s3_bucket.s3_bucket.bucket
  key    = "error.html"
  source = "${var.public_path}/error.html"
  content_type = "text/html"

  etag = filemd5("${var.public_path}/error.html")

  # lifecycle {
  #   ignore_changes = [etag]
  #     # Ignore changes to etags
  # }
}

#https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_policy

resource "aws_s3_bucket_policy" "bucket_policy" {
  bucket = aws_s3_bucket.s3_bucket.bucket
  #policy = data.aws_iam_policy_document.allow_access_from_another_account.json
  policy = jsonencode(
    {
    "Version" = "2012-10-17",
    "Statement" = {
        "Sid" = "AllowCloudFrontServicePrincipalReadOnly",
        "Effect" = "Allow",
        "Principal" = {
            "Service" = "cloudfront.amazonaws.com"
        },
        "Action" = "s3:GetObject",
        "Resource" = "arn:aws:s3:::${aws_s3_bucket.s3_bucket.id}/*",
        "Condition" = {
            "StringEquals" = {
                "AWS:SourceArn" = "arn:aws:cloudfront::${data.aws_caller_identity.current.account_id}:distribution/${aws_cloudfront_distribution.s3_distribution.id}"
                #"AWS:SourceArn": data.aws_caller_identity.current.arn
            }
        }
    }
}
  )
}

resource "terraform_data" "content_version" {
  input = var.content_version
} 

#fileset("${path.root}/public/assets", "*.{jpg,png,gif}")