variable "user_uuid" {
  type        = string
  description = "User UUID in the format of a 36-character UUID"
  
  validation {
    condition     = can(regex("^[0-9a-f]{8}-[0-9a-f]{4}-4[0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}$", var.user_uuid))
    error_message = "User UUID must be a valid 36-character UUID."
  }
}