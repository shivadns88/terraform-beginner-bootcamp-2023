output "bucket_name" {
  description = "Bucket Name for Static Website Hosting"
  value = module.terrahouse_aws.bucket_name
}

output "s3_website_endpoint" {
  description = "S3 static website hosting endpoint"
  value = module.terrahouse_aws.website_endpoint
}

output "cloudfront_url" {
  description = "The CloudFront Distribution Domain Name"
  value = module.terrahouse_aws.cloudfront_url
}