resource "aws_instance" "bastion" {
  ami                    = var.AMIS[var.region]
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.public.id
  vpc_security_group_ids = [aws_security_group.bastion-allow-ssh.id]
  key_name               = aws_key_pair.generated_key.key_name
  tags = {
    Name = "Bastion Host"
  }
}

