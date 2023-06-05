variable "type" {
  type    = string
  default = "t2.micro"
}

variable "instance_count" {
  type    = number
  default = 1
}

variable "key_name" {
  type        = string
  description = "description"
}

variable "name" {
  type = string
}

variable "nginx_port" {
  type    = number
  default = 8181
}

variable "security_group_id" {
  type        = string
  default     = ""
  description = "SG ID"

  validation {
    condition     = var.security_group_id == "" || startswith(var.security_group_id, "sg-")
    error_message = "Security Group Id must start with the prefix sg-."
  }
}
variable "root_disk_type" {
  description = "Root disk type"
  default     = "gp2"
  validation {
    condition     = can(regex("^(gp2|gp3|standard)$", var.root_disk_type))
    error_message = "Invalid disk type. Only 'gp2', 'gp3', or 'standard' are allowed."
  }
}

variable "root_disk_size" {
  description = "Root disk size"
  default     = 8
}

variable "instance_profile_name" {
  type    = string
  default = "tf-instance-profile"
}

variable "iam_policy_name" {
  type    = string
  default = "tf-policy"
}

variable "role_name" {
  type    = string
  default = "tf-role"
}


