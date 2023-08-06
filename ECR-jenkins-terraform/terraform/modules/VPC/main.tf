# Create VPC
resource "aws_vpc" "tooling-vpc" {
  cidr_block                     = var.vpc_cidr
  enable_dns_support             = var.enable_dns_support
  enable_dns_hostnames           = var.enable_dns_hostnames
  tags = merge(
    var.tags,
    {
      Name = format("%s-VPC", var.name)
    },
  )
}

# Create subnet
resource "aws_subnet" "tooling_subnet" {
  vpc_id                  = aws_vpc.tooling-vpc.id
  cidr_block              = var.subnet_cidr
  availability_zone      = var.zone
  map_public_ip_on_launch = true         

  tags = merge(
    var.tags,
    {
      Name = format("%s-pubsubnet", var.name)
    },
  )

}

# create and associaote route table
resource "aws_route_table" "tooling_route_table" {
  vpc_id = aws_vpc.tooling-vpc.id
}

resource "aws_route" "tooling_route" {
  route_table_id         = aws_route_table.tooling_route_table.id
  destination_cidr_block = "0.0.0.0/0" 
  gateway_id             = aws_internet_gateway.tooling-ig.id
}

resource "aws_route_table_association" "tooling_association" {
  subnet_id      = aws_subnet.tooling_subnet.id
  route_table_id = aws_route_table.tooling_route_table.id
}







