# resource "random_string" "bucket_name" {
#   length           = 32
#   special          = false
#   lower = true
#   upper = false
# }

resource "aws_s3_bucket" "s3_bucket" {
  bucket = var.bucket_name

  tags = {
    User_Uuid        = var.user_uuid
  }

}


