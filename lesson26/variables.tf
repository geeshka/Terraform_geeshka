variable "subntets" {
  type        = list(string)
  default     = ["eu-central-1a", "eu-central-1b", "eu-central-1c"]
  description = "description"
}

variable "instance_number" {
  type        = number
  default     = 2
  description = "description"
}

variable "key_name" {
  type        = string
  default     = "geeshka"
  description = "description"
}

locals {
  nginx_port   = 8181
  my_public_ip = lookup(data.external.my_ip.result, "ip", "127.0.0.1")
}
