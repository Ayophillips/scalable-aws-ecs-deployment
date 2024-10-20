output "subnet_info" {
  value = { for id, subnet in aws_subnet.subnet : id => {
    id                      = subnet.id
    map_public_ip_on_launch = subnet.map_public_ip_on_launch
  } }
}
