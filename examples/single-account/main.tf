#-------------------------------------
# general resources
#-------------------------------------
module "resource_group" {
  source = "../../modules/infrastructure/resource-group"
  name   = var.name
  tags   = var.tags
}
