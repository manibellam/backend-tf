resource "aws_instance" "web" {
ami           = var.ami
instance_type = var.instancetype
subnet_id = var.subnet
vpc_security_group_ids= var.vpc-sg
key_name = var.key
disable_api_termination =false

tags = {
    Name = var.instance-name
    }
}

resource "aws_eip" "web" {
    instance = aws_instance.web.id
    vpc=true
  
}





resource "aws_lb" "Mynewloadbalancer" {
  name               = "test-lb-tf"
  internal           = false
  load_balancer_type = "application"
  security_groups    = ["sg-01c5bfc89afa663ee"]
  subnets            = ["subnet-7752873f", "subnet-50079709"]

  enable_deletion_protection = true
}

resource "aws_lb_target_group" "test" {
  name     = "tf-example-lb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = "vpc-4b3dcd2d"
}

resource "aws_lb_target_group" "test443" {
  name     = "tf-example-lb-tg443"
  port     = 443
  protocol = "HTTPS"
  vpc_id   = "vpc-4b3dcd2d"
}


resource "aws_lb_target_group_attachment" "test" {
  target_group_arn = aws_lb_target_group.test.arn
  target_id        = aws_instance.web.id
  port             = 80
}

resource "aws_lb_target_group_attachment" "test443" {
  target_group_arn = aws_lb_target_group.test443.arn
  target_id        = aws_instance.web.id
  port             = 443
}


resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.Mynewloadbalancer.arn
  port              = "80"
 # protocol          = "HTTPS"
 # ssl_policy        = "ELBSecurityPolicy-2016-08"
 # certificate_arn   = "arn:aws:iam::187416307283:server-certificate/test_cert_rab3wuqwgja25ct3n4jdj2tzu4"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.test.arn
  }
}

### Variables

variable "ami" {
    default ="ami-02f26adf094f51167"
    type=string
}
variable "instancetype" {
    default ="t2.micro"
    type=string
}
variable "subnet" {
    default ="subnet-7752873f"
    type=string
}

variable "vpc-sg" {
    default= ["sg-00366413a237bc080", "sg-01c5bfc89afa663ee"]
    type= list(string) 
}

variable "instance-name" {
    default = "terraform instance"
    type = string
}
variable "key" {
    default =  "mani"
    type = string
      
}
