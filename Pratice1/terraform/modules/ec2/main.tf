# ============================================================
# Public EC2
# ============================================================
resource "aws_instance" "public" {
  ami = "?"
  instance_type = "?"
  subnet_id = "?"
  vpc_security_group_ids = "?" // gắn với security group của public ec2
  key_name = "?"
  associate_public_ip_address = true
  
  tags = {
    Name = "?"
  }
}

# ============================================================
# Private EC2
# ============================================================
resource "aws_instance" "private" {
  ami = "?"
  instance_type = "?"
  subnet_id = "?"
  vpc_security_group_ids = "?"
  key_name = "?"
  associate_public_ip_address = true

  tags = {
    Name = "?"
  }
}



