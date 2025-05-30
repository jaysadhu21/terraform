variable "requester_vpc_id" {
  description = "ID of the requester VPC"
  type        = string
}

variable "accepter_vpc_id" {
  description = "ID of the accepter VPC"
  type        = string
}

variable "accepter_vpc_name" {
  description = "Name of the accepter VPC for tagging"
  type        = string
}