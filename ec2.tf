
resource "aws_security_group" "instance"{
    
    vpc_id = "vpc-4bb98331"
    name_prefix = "example-"	
    lifecycle {
    create_before_destroy = true
  }
    ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

