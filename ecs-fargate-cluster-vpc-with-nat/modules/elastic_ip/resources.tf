resource "aws_eip" "eip_1" {
  network_interface = aws_instance.instance_1.primary_network_interface_id

  tags_all = {
    name    = "${var.service_name}-nat-gateway-1"
    service = var.service_name
  }
}
