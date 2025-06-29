resource "aws_vpc" "main" {
  cidr_block = var.vpc_config.cidr_block
  
  tags = {
    Name = var.vpc_config.vpc_name
  }
}

resource "aws_subnet" "main" {
  vpc_id = aws_vpc.main.id
  for_each = var.sub_config

  cidr_block = each.value.cidr_block
  availability_zone = each.value.az

  tags = {
    Name = each.key
  }
}

locals {
  public_sub={
    # key={} if public is true in sub_config
    for key , config in var.sub_config : key => config if config.public
  }
}

locals {
  private_sub={
    # key={} if public is true in sub_config
    for key , config in var.sub_config : key => config if !config.public
  }
}

# IGW For public subnet
resource "aws_internet_gateway" "vpc-igw" {
  vpc_id = aws_vpc.main.id
  count = length(local.public_sub) > 0 ? 1 : 0

}

resource "aws_route_table" "vpc-route" {
  vpc_id = aws_vpc.main.id
  count = length(local.public_sub) > 0 ? 1 : 0
  
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.vpc-igw[0].id
  }
}

resource "aws_route_table_association" "route_link" {
  for_each = local.public_sub

  subnet_id = aws_subnet.main[each.key].id
  route_table_id = aws_route_table.vpc-route[0].id
}