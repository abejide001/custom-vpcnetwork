# Create the nat gateway
resource "aws_nat_gateway" "gw" {
  allocation_id = "${aws_eip.nat.id}"

  tags {
    Name = "gw Nat"
  }

  depends_on = ["aws_internet_gateway.default"] # Ensures the internet gateway is created first
  subnet_id  = "${aws_subnet.public.id}"
}
