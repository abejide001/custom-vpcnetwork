# Create the route table association for the public subnet
resource "aws_route_table_association" "public" {
  subnet_id      = "${aws_subnet.public.id}"
  route_table_id = "${aws_route_table.public.id}"
}

# Create the route table association for the private subnet specifying the subnet id and the route table id
resource "aws_route_table_association" "nat" {
  subnet_id      = "${aws_subnet.private.id}"
  route_table_id = "${aws_route_table.nat.id}"
}