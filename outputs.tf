output "bucket_name" {
  description = "Bucket Name for Static Website Hosting"
  value = module.home_dream_hosting.bucket_name
}

output "s3_website_endpoint" {
  description = "S3 static website hosting endpoint"
  value = module.home_dream_hosting.website_endpoint
}

output "cloudfront_url" {
  description = "The CloudFront Distribution Domain Name"
  value = module.home_dream_hosting.domain_name
}