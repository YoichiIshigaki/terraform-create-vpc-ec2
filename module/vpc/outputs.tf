output "vpc_id" {
  value = aws_vpc.aws-tf-vpc.id
}

output "public_subnet_id" {
    value = aws_subnet.aws-tf-public-subnet.id
}