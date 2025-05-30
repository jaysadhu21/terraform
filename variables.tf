variable "region" {
  description = "AWS region for the infrastructure"
  type        = string
  default     = "ap-southeast-1"
}

variable "accepter_vpc_name" {
  description = "Name of the accepter VPC for peering"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for the custom VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "subnet_cidrs" {
  description = "List of CIDR blocks for public subnets"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}