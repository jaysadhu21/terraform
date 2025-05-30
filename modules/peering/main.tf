# Fetch requester VPC details
data "aws_vpc" "requester" {
  id = var.requester_vpc_id
}

# Fetch accepter VPC details
data "aws_vpc" "accepter" {
  id = var.accepter_vpc_id
}

# Fetch main route tables for both VPCs
data "aws_route_table" "requester_main" {
  vpc_id = var.requester_vpc_id
  filter {
    name   = "association.main"
    values = ["true"]
  }
}

data "aws_route_table" "accepter_main" {
  vpc_id = var.accepter_vpc_id
  filter {
    name   = "association.main"
    values = ["true"]
  }
}

# Create VPC peering connection
resource "aws_vpc_peering_connection" "peer" {
  vpc_id        = var.requester_vpc_id
  peer_vpc_id   = var.accepter_vpc_id
  auto_accept   = true

  tags = {
    Name = "peer-to-${var.accepter_vpc_name}"
  }
}

# Add route to accepter VPC in requester VPC's route table
resource "aws_route" "requester_to_accepter" {
  route_table_id            = data.aws_route_table.requester_main.id
  destination_cidr_block    = data.aws_vpc.accepter.cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.peer.id
}

# Add route to requester VPC in accepter VPC's route table
resource "aws_route" "accepter_to_requester" {
  route_table_id            = data.aws_route_table.accepter_main.id
  destination_cidr_block    = data.aws_vpc.requester.cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.peer.id
}