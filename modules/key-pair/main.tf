resource "tls_private_key" "rsa-4096-example" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_secretsmanager_secret" "this" {
  name = "${var.key_pair_name}-key-pair"
}

resource "aws_secretsmanager_secret_version" "name" {
  secret_id = aws_secretsmanager_secret.this.id
  secret_string = jsonencode({
    private_key = tls_private_key.rsa-4096-example.private_key_pem
    public_key  = tls_private_key.rsa-4096-example.public_key_openssh
  })
}

resource "aws_key_pair" "this" {
  key_name   = var.key_pair_name
  public_key = tls_private_key.rsa-4096-example.public_key_openssh
  lifecycle {
    ignore_changes = [public_key]
  }
}

