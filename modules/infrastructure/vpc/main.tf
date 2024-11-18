data "aws_availability_zones" "available" {
  state = "available"
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.1.1"

  name = var.name
  cidr = var.cidr_block

  azs             = [data.aws_availability_zones.available.names[0], data.aws_availability_zones.available.names[1]]
  private_subnets = var.private_subnets
  public_subnets  = var.public_subnets

  enable_nat_gateway   = true
  single_nat_gateway   = true
  enable_dns_hostnames = true

  enable_flow_log                      = false
  create_flow_log_cloudwatch_iam_role  = false
  create_flow_log_cloudwatch_log_group = false

  public_subnet_tags = {
    "kubernetes.io/cluster/${var.name}" = "shared"
    "kubernetes.io/role/elb"            = 1
    "Type"                              = "public"
    "SubnetType"                        = "Public"
  }

  private_subnet_tags = {
    "kubernetes.io/cluster/${var.name}" = "shared"
    "kubernetes.io/role/internal-elb"   = 1
    "Type"                              = "private"
    "SubnetType"                        = "Private"
  }

  tags = var.tags
}

data "aws_subnet" "private" {
  for_each = {
    for k, v in module.vpc.private_subnets : k => v
  }

  id     = each.value
  vpc_id = module.vpc.vpc_id
}

data "aws_subnet" "public" {
  for_each = {
    for k, v in module.vpc.public_subnets : k => v
  }

  id     = each.value
  vpc_id = module.vpc.vpc_id
}
