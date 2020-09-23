resource "aws_directory_service_directory" "simple_ad" {
  alias       = var.alias
  description = var.description
  enable_sso  = var.enable_sso
  name        = var.name
  password    = random_string.password.result
  short_name  = var.short_name
  size        = var.size
  type        = var.type
  tags        = var.tags

  vpc_settings {
    vpc_id     = aws_vpc.vpc.id
    subnet_ids = [aws_subnet.private.0.id, aws_subnet.private.1.id]
  }
}


resource "random_string" "password" {
  length           = 31
  min_upper        = 1
  min_lower        = 1
  min_numeric      = 1
  override_special = "!#$%^&*()_-+="
}