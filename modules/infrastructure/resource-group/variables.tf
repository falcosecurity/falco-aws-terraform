#---------------------------------
# optionals - with default
#---------------------------------

variable "name" {
  type        = string
  description = "Name to be assigned to all child resources. A suffix may be added internally when required. Use default value unless you need to install multiple instances"
  default     = "ffc"
}


variable "tags" {
  type        = map(string)
  description = "falcosecurity-for-cloud tags. always include 'product' default tag for resource-group proper functioning"
  default = {
    "product" = "falcosecurity-for-cloud"
  }
}
