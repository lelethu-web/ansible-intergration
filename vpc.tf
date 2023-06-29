# Creating Own VPC with  CIDR BLOCK of "10.0.0.0/16"

resource "aws_vpc" "our_own_vpc" {
 cidr_block = var.vpc_cidr_block
 tags = {
   Name = "Own VPC"
 }
}

# Public Subnet For Instance 

resource "aws_subnet" "public_subnets" {
vpc_id     = aws_vpc.our_own_vpc.id
cidr_block = var.public_subnet_ips
availability_zone  = var.availability_zone
map_public_ip_on_launch = true
tags = {
 Name = "Public Subnet"
    }
}

# Enabling VPC to connect to the internet

resource "aws_internet_gateway" "own_vpc-igw" {
    vpc_id = aws_vpc.our_own_vpc.id
    tags = {
        Name = "Own-VPC-Internet-Gateway"
    }
}

# Creating Routing table to assocciate the public subnet

 resource "aws_route_table" "own_routing-table" {
    vpc_id = aws_vpc.our_own_vpc.id
    route {
        cidr_block = "0.0.0.0/0"         
        gateway_id = aws_internet_gateway.own_vpc-igw.id
    }
    tags = {
        Name = "Own-VPC-Routing-Table"
    }
}

# Associate the Routing Table and the public Subnet

resource "aws_route_table_association" "association"{
    subnet_id = aws_subnet.public_subnets.id
    route_table_id = aws_route_table.own_routing-table.id
}
# END OF VPC