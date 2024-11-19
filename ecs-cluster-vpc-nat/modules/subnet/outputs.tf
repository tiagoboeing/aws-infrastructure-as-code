# Public Subnets
output "aws_subnet_public1_az_1a_id" {
  value = aws_subnet.public1_az_1a.id
}

output "aws_subnet_public2_az_1b_id" {
  value = aws_subnet.public2_az_1b.id
}

# Private Subnets
output "aws_subnet_private1_az_1a_id" {
  value = aws_subnet.private1_az_1a.id
}

output "aws_subnet_private2_az_1b_id" {
  value = aws_subnet.private2_az_1b.id
}
