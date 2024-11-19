output "aws_route_table_main_id" {
  value       = aws_route_table.main.id
  description = "The ID of the main route table"
}

# output "aws_main_route_table_association_main_id" {
#   value       = aws_main_route_table_association.main.id
#   description = "The ID of the main route table association"
# }

output "aws_route_table_public_id" {
  value       = aws_route_table.public.id
  description = "The ID of the public route table"
}

output "aws_route_table_association_public_az1_id" {
  value       = aws_route_table_association.public_association_az1.id
  description = "The ID of the public route table association"
}

output "aws_route_table_association_public_az2_id" {
  value       = aws_route_table_association.public_association_az2.id
  description = "The ID of the public route table association"
}

output "aws_route_table_private1_id" {
  value       = aws_route_table.private1.id
  description = "The ID of the private route table 1"
}

output "aws_route_table_association_private_az1_id" {
  value       = aws_route_table_association.private_association_az1.id
  description = "The ID of the private route table association"
}

output "aws_route_table_private2_id" {
  value       = aws_route_table.private2.id
  description = "The ID of the private route table 2"
}

output "aws_route_table_association_private_az2_id" {
  value       = aws_route_table_association.private_association_az2.id
  description = "The ID of the private route table association"
}
