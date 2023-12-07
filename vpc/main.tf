locals {
  
  # tags = merge(
  #   #{ "Name" = var.name },
  #   var.tags,
  #   #var.vpc_tags,
  # )

  vpc_tags = var.vpc_tags
  tags = var.tags
}
resource "aws_vpc" "vpc" {
cidr_block = var.vpc_cidr_block
 
  #tags = local.vpc_tags
   tags = merge(
     #{ "Name" = var.name },
     var.tags,
     var.vpc_tags,
   )

}

resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.vpc.id
   tags = "${local.tags}"
}

resource "aws_eip" "ip" {
  tags = local.tags
}

resource "aws_nat_gateway" "natgw" {
  allocation_id = aws_eip.ip.id
  subnet_id     = aws_subnet.pub_sub1.id
   tags = local.tags
}

#subnets & its 
resource "aws_subnet" "pub_sub1" {

cidr_block = var.pub_sub1_cidr
availability_zone = var.pub_sub1_az
vpc_id = aws_vpc.vpc.id
tags = local.tags
}

resource "aws_subnet" "pub_sub2" {

cidr_block = var.pub_sub2_cidr
availability_zone = var.pub_sub2_az
vpc_id = aws_vpc.vpc.id
tags = local.tags
}

resource "aws_subnet" "priv_sub1" {

cidr_block = var.priv_sub1_cidr
availability_zone = var.priv_sub1_az
vpc_id = aws_vpc.vpc.id
tags = local.tags
}

resource "aws_subnet" "priv_sub2" {

cidr_block = var.priv_sub2_cidr
availability_zone = var.priv_sub2_az
vpc_id = aws_vpc.vpc.id

tags = local.tags

}

#route tables

resource "aws_route_table" "priv_rt" {
    vpc_id = aws_vpc.vpc.id

  tags = local.tags
   
}
resource "aws_route_table" "pub_rt" {
    vpc_id = aws_vpc.vpc.id
  tags = local.tags
   
}
resource "aws_route_table_association" "pub-sub1-rt-association" {
    route_table_id = aws_route_table.pub_rt.id
    subnet_id = aws_subnet.pub_sub1.id
   
}
resource "aws_route_table_association" "pub-sub2-rt-association" {
    route_table_id = aws_route_table.pub_rt.id
    subnet_id = aws_subnet.pub_sub2.id
   
}
resource "aws_route_table_association" "priv-rt1-association" {
    route_table_id = aws_route_table.priv_rt.id
    subnet_id = aws_subnet.priv_sub1.id
    
}
resource "aws_route_table_association" "priv-rt2-association" {
    route_table_id = aws_route_table.priv_rt.id
    subnet_id = aws_subnet.priv_sub2.id
    
}
resource "aws_route" "route-pub-rt" {
  route_table_id = aws_route_table.pub_rt.id
  destination_cidr_block = var.rt_destination_cidr
  gateway_id = aws_internet_gateway.igw.id
  
}
resource "aws_route" "route-priv1-rt" {
  route_table_id = aws_route_table.priv_rt.id
  destination_cidr_block = var.rt_destination_cidr
  gateway_id = aws_nat_gateway.natgw.id

}
