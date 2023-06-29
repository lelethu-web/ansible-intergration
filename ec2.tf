resource "tls_private_key" "rsa" {
	algorithm = "RSA"
	rsa_bits  = 4096
}

resource "aws_key_pair"  "terra_key" {
  key_name = "tf-key"
	public_key  = tls_private_key.rsa.public_key_openssh
  
  provisioner "local-exec" {
	 command = "echo '${tls_private_key.rsa.private_key_openssh}' > ./terraform_key-private-key.pem"
	    }
  }

# Get the correct Image and create the EC2 instance

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

# Making the instance accessible on port 22 and port 80

resource "aws_security_group" "http_access" {
  vpc_id = var.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]

  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
   
  ingress {
    from_port   = 81
    to_port     = 81
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "http-and-ssh-access"
  }
}

# now adding the EC2 Instance
resource "aws_instance" "nginxweb" {
  subnet_id              = var.subnet_id
  # vpc_id                 = var.vpc_id
  vpc_security_group_ids = [aws_security_group.http_access.id]
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.instance_type
  availability_zone      = var.availability_zone
  key_name  = aws_key_pair.terra_key.key_name
  tags = {
    Name = "Nginx-Web-Server"
  }

    connection {
    type     = "ssh"
    user     = "ubuntu"
    private_key = tls_private_key.rsa.private_key_openssh
    host     = self.public_ip
    }

   provisioner "remote-exec" {
    inline = [
      "sudo mkdir -p /tmp/configure",
      "sudo chmod go+w /tmp/configure",
    ]
  }

  provisioner "file" {
    source      = "./configure/"
    destination = "/tmp/configure"
  }
}

resource "terraform_data" "nginxweb" {
  
  triggers_replace = aws_instance.nginxweb.id

  connection {
    type     = "ssh"
    user     = "ubuntu"
    private_key = tls_private_key.rsa.private_key_openssh
    host = aws_instance.nginxweb.public_ip
  }

  provisioner "remote-exec" {
    
    inline = [
           "sudo chmod go+x /tmp/configure/ansibleinstall.sh",
           "sudo /tmp/configure/ansibleinstall.sh args",
        ]
    }
}