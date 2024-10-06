variable "VarProduction" {
  description = "Nombre de la instancia EC2 VarProduction"
  type        = string
}

variable "VarIntranetCIDR" {
  description = "CIDR de la VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "VarSubnetCIDR" {
  description = "CIDR de la Subnet"
  type        = string
  default     = "10.0.1.0/24"
}

resource "aws_vpc" "production" {
  cidr_block = var.VarIntranetCIDR
}

resource "aws_subnet" "subnetCIDR" {
  vpc_id            = aws_vpc.production.id
  cidr_block        = var.VarSubnetCIDR
  availability_zone = "us-east-2a"
}

resource "aws_security_group" "groupInstances" {
  vpc_id = aws_vpc.production.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "web-server-instance" {
  ami             = "ami-0c55b159cbfafe1f0"
  instance_type   = "t2.micro"
  subnet_id       = aws_subnet.subnetCIDR.id
  security_groups = [aws_security_group.groupInstances.id]

  root_block_device {
    volume_size = 30
    volume_type = "gp2"
  }

  tags = {
    Name = var.VarProduction
  }
}