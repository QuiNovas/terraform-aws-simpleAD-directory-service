resource "random_shuffle" "az" {
  input        = var.availability_zones
  result_count = 2
}

resource "aws_vpc" "vpc" {
  cidr_block = var.cidr_block
  tags = {
    Name = var.name
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = merge(
    {
      "Name" = format("%s", var.name)
    },
    var.tags
  )
}

resource "aws_subnet" "public" {
  count             = 2
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = local.public_subnets[count.index]
  availability_zone = element(random_shuffle.az.result, count.index)

  tags = merge(
    {
      "Name" = format(
        "%s-public-%s",
        var.name,
        element(random_shuffle.az.result, count.index),
      )
    },
    var.tags,
  )
}

resource "aws_route_table" "public" {

  vpc_id = aws_vpc.vpc.id

  tags = merge(
    {
      "Name" = format("%s-public", var.name)
    },
    var.tags
  )

}

resource "aws_route" "public_internet_gateway" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id

  timeouts {
    create = "5m"
  }
}

resource "aws_route_table_association" "public" {
  count          = 2
  subnet_id      = element(aws_subnet.public.*.id, count.index)
  route_table_id = aws_route_table.public.id
}