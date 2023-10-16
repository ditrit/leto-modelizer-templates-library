data "aws_availability_zones" "eu-west-3a" {
  state = "available"

  filter {
    name = "eu-west-3a"
  }
}

data "aws_availability_zones" "eu-west-3b" {
  state = "available"

  filter {
    name = "eu-west-3b"
  }
}

data "aws_availability_zones" "eu-west-3c" {
  state = "available"

  filter {
    name = "eu-west-3c"
  }
}

resource "aws_vpc" "main_vpc" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "frontend_subnet_az1" {
  vpc_id            = aws_vpc.main_vpc
  cidr_block        = "10.0.0.0/24"
  availability_zone = "eu-west-3a"

  tags {
    Name = "frontend_subnet_az1"
  }
}

resource "aws_subnet" "frontend_subnet_az2" {
  vpc_id            = aws_vpc.main_vpc
  cidr_block        = "10.0.1.0/24"
  availability_zone = "eu-west-3b"

  tags {
    Name = "frontend_subnet_az2"
  }
}

resource "aws_subnet" "frontend_subnet_az3" {
  vpc_id            = aws_vpc.main_vpc
  cidr_block        = "10.0.2.0/24"
  availability_zone = "eu-west-3c"

  tags {
    Name = "frontend_subnet_az3"
  }
}

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

  owners = ["099720109477"]
}

resource "aws_security_group" "frontend_secgroup_ssh" {
  name        = "frontend_secgroup_ssh"
  description = "SSH Rules for the Front-End servers"
  vpc_id      = aws_vpc.main_vpc

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
  }

  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
  }
}

resource "aws_security_group" "lb_secgroup_https" {
  name        = "lb_secgroup_https"
  description = "HTTPS Rules for the LoadBalancer"
  vpc_id      = aws_vpc.main_vpc

  ingress {
    from_port = 443
    to_port   = 443
    protocol  = "tcp"
  }

  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
  }
}

resource "aws_security_group" "lb_secgroup_http" {
  name        = "lb_secgroup_http"
  description = "HTTP Rules for the LoadBalancer"
  vpc_id      = aws_vpc.main_vpc


  ingress {
    from_port = 80
    to_port   = 80
    protocol  = "tcp"
  }

  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
  }
}

resource "aws_lb" "frontend_lb" {
  name               = "frontend-lb"
  load_balancer_type = "application"
  security_groups    = [
    aws_security_group.lb_secgroup_https.id,
    aws_security_group.lb_secgroup_http.id
  ]

  subnets = [
    aws_subnet.frontend_subnet_az1.id,
    aws_subnet.frontend_subnet_az2.id,
    aws_subnet.frontend_subnet_az3.id
  ]
}

resource "aws_lb_listener" "https_lb_listener" {
  load_balancer_arn = [aws_lb.frontend_lb.id]
  port              = "443"
  protocol          = "HTTPS"

  default_action {
    type             = "forward"
    target_group_arn = ["lb_target"]
  }
}

resource "aws_lb_listener" "http_lb_listener" {
  load_balancer_arn = [aws_lb.frontend_lb.id]
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = ["lb_target"]
  }
}

resource "aws_lb_target_group" "lb_target" {
  name        = "lbtarget"
  target_type = "instance"
  port        = 8000
  protocol    = "HTTP"
  vpc_id      = [aws_vpc.main_vpc.id]
}
