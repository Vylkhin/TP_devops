provider "aws"{
  region = var.region
}

data "aws_ami" "ubuntu"{
  most_recent = true

  filter{
    name = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter{
    name = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "instance_jenkins_server_lespagnol"{
  count = var.create_instance ? var.instance_number : 0
  ami = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  key_name = var.ssh_key

  tags = {
    Name = "instance_jenkins_server_lespagnol"
  }
}

resource "aws_security_group" "security_group_jenkins_ssh_lespagnol"{
  name = "security_group_jenkins_ssh_lespagnol"

  ingress{
    description = "Allow SSH"
    from_port = 22
    to_port = 22
    protocol = "tcp"
  }

  egress{
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "security_group_jenkins_ssh_lespagnol"
  }
}

resource "aws_security_group" "security_group_jenkins_jenkins_lespagnol"{
  name = "security_group_jenkins_jenkins_lespagnol"

  ingress{
    description = "Jenkins port"
    from_port = 8080
    to_port = 8080
    protocol = "tcp"
  }

  egress{
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "security_group_jenkins_jenkins_lespagnol"
  }
}

resource "aws_security_group" "security_group_jenkins_web_lespagnol"{
  name = "security_group_jenkins_web_lespagnol"

  ingress{
    description = "Web"
    from_port = 80
    to_port = 80
    protocol = "tcp"
  }

  egress{
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "security_group_jenkins_web_lespagnol"
  }
}
