resource "aws_internet_gateway" "tooling-ig" {
  vpc_id = aws_vpc.tooling-vpc.id

  tags = merge(
    var.tags,
    {
      Name = format("%s-%s", var.name, "IG")
    }
  )
}

