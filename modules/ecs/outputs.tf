output "subnet_id" {
  value = aws_subnet.subnet[each.key].id
}
