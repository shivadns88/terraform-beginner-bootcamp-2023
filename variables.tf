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