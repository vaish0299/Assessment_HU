resource "tls_private_key" "terrafrom_generated_private_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "generated_key" {
  key_name   = "aws_keys_pairs"
  public_key = tls_private_key.terrafrom_generated_private_key.public_key_openssh
  provisioner "local-exec" {
    command = <<-EOT
       rm -rf aws_keys_pairs.pem
       echo '${tls_private_key.terrafrom_generated_private_key.private_key_pem}' > aws_keys_pairs.pem
       chmod 400 aws_keys_pairs.pem
     EOT
  }
}