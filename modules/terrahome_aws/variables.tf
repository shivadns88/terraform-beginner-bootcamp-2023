variable "user_uuid" {
  type        = string
  description = "User UUID in the format of a 36-character UUID"
  
  validation {
    condition     = can(regex("^[0-9a-f]{8}-[0-9a-f]{4}-4[0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}$", var.user_uuid))
    error_message = "User UUID must be a valid 36-character UUID."
  }
}

# variable "bucket_name" {
#   type        = string
#   description = "Name of the AWS S3 bucket"
  
#   validation {
#     condition     = can(regex("^[a-z0-9.-]{3,63}$", var.bucket_name))
#     error_message = "Bucket name must be between 3 and 63 characters, and can only contain lowercase letters, numbers, hyphens, and periods."
#   }
# }

variable "public_path" {
  type        = string
  description = "Path to the public directory"
}

# variable "error_html_filepath" {
#   type        = string
#   description = "Path to the error.html file"

#   validation {
#     condition     = can(file(var.error_html_filepath)) && can(fileexists(var.error_html_filepath))
#     error_message = "The specified index_html_filepath does not exist or is not a valid file path."
#   }
# }

variable "content_version" {
  type        = number
  description = "The content version (positive integer starting at 1)"

  validation {
    condition     = var.content_version > 0 && floor(var.content_version) == var.content_version
    error_message = "The content_version must be a positive integer starting at 1."
}
}

# variable "assets_path" {
#   description = "Path to assets folder"
#   type = string
# }