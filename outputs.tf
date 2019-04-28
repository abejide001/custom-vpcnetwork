# Outut the IP'S on the terminal
output "backend-ip" {
  value = "${aws_instance.backend.private_ip}"
}

output "frontend-ip" {
  value = "${aws_instance.frontend.public_ip}"
}

output "database-ip" {
  value = "${aws_instance.database.private_ip}"
}
