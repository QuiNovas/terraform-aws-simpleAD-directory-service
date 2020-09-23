module "simple_ad_password" {
  description = "The password for the directory administrator or connector user."
  name        = "simple-ad-credentials/${aws_directory_service_directory.simple_ad.id}"
  value       = jsonencode({ "password" = random_string.password.result })
  source      = "QuiNovas/standard-secret/aws"
  version     = "3.0.2"
}