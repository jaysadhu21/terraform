variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "subnet_cidrs" {
  description = "List of CIDR blocks for public subnets"
  type        = list(string)
}

variable "azs" {
  description = "List of availability zones"
  type        = list(string)
}