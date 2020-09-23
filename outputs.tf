output "password" {
  value = random_string.password.result
}

output "directory_id" {
  value = aws_directory_service_directory.simple_ad.id
}

output "directory_url" {
  value = aws_directory_service_directory.simple_ad.access_url
}

output "dns_ip" {
  value = aws_directory_service_directory.simple_ad.dns_ip_addresses
}

output "directory_security_group_id" {
  value = aws_directory_service_directory.simple_ad.security_group_id
}