# Fetch the default VPC
data "aws_vpc" "default" {
  filter {
    name   = "isDefault"
    values = ["true"]
  }
}

# Fetch availability zones for the region
data "aws_availability_zones" "available" {
  state = "available"
}

# Create custom VPC and subnets
module "vpc" {
  source       = "./modules/vpc"
  vpc_cidr     = var.vpc_cidr
  subnet_cidrs = var.subnet_cidrs
  azs          = slice(data.aws_availability_zones.available.names, 0, 3)
}

# Set up VPC peering with the default VPC
module "peering" {
  source            = "./modules/peering"
  requester_vpc_id  = module.vpc.vpc_id
  accepter_vpc_id   = data.aws_vpc.default.id
  accepter_vpc_name = var.accepter_vpc_name
}

# Outputs
output "custom_vpc_id" {
  description = "ID of the custom VPC"
  value       = module.vpc.vpc_id
}

output "default_vpc_id" {
  description = "ID of the default VPC"
  value       = data.aws_vpc.default.id
}

output "peering_connection_id" {
  description = "ID of the VPC peering connection"
  value       = module.peering.peering_connection_id
}

output "public_subnet_ids" {
  description = "IDs of the public subnets"
  value       = module.vpc.public_subnet_ids
}