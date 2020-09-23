resource "aws_directory_service_directory" "simple_ad" {
  name     = var.name
  password = random_string.password.result
  size     = var.size

  vpc_settings {
    vpc_id     = aws_vpc.vpc.id
    subnet_ids = [aws_subnet.public.0.id,aws_subnet.public.1.id]
  }

  alias       = var.alias
  description = var.description
  short_name  = var.short_name
  enable_sso  = var.enable_sso
  type        = var.type
  tags        = var.tags
}


resource "random_string" "password" {
  length           = 31
  min_upper        = 1
  min_lower        = 1
  min_numeric      = 1
  override_special = "!#$%^&*()_-+="
}