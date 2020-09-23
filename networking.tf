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

resource "aws_subnet" "private" {
  count             = 2
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = local.private_subnets[count.index]
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

resource "aws_route_table" "private" {

  vpc_id = aws_vpc.vpc.id

  tags = merge(
    {
      "Name" = format("%s-public", var.name)
    },
    var.tags
  )

}

resource "aws_route_table_association" "private" {
  count          = 2
  subnet_id      = element(aws_subnet.private.*.id, count.index)
  route_table_id = aws_route_table.private.id
}