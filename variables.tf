variable "user_uuid" {
  type = string
}

variable "bucket_name" {
  type = string
}

variable "index_html_filepath" {
  type        = string
  description = "Path to the index.html file"
}


variable "error_html_filepath" {
  type        = string
  description = "Path to the error.html file"
}

variable "content_version" {
  type        = number
  description = "The content version (positive integer starting at 1)"
}


variable "assets_path" {
  description = "Path to assets folder"
  type = string
}