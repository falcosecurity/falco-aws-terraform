variable "name" {
  description = "VPC name"
  type        = string
}

variable "tags" {
  type        = map(string)
  description = "falcosecurity-for-cloud tags. always include 'product' default tag for resource-group proper functioning"
  default = {
    "product" = "falcosecurity-for-cloud"
  }
}

variable "cidr_block" {
  type        = string
  default     = "10.0.0.0/16"
  description = "The CIDR block for the VPC"
}

variable "private_subnets" {
  type        = list(string)
  description = "The private subnets. If you are enabling the VPC module."
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "public_subnets" {
  type        = list(string)
  description = "The public subnets. If you are enabling the VPC module."
  default     = ["10.0.4.0/24", "10.0.5.0/24"]
}
