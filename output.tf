output "vpc_id" {
  value       = aws_vpc.our_own_vpc.id
}

output "subnet_id" {
  value       = aws_subnet.public_subnets.id
}