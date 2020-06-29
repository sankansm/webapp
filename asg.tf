resource "aws_launch_configuration" "example" {
  image_id        = data.aws_ami.baked_ami.id
  instance_type   = "t2.micro"
  security_groups = [aws_security_group.instance.id]
  key_name = "seekdevops"
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "example" {
  launch_configuration = aws_launch_configuration.example.id
  availability_zones   = data.aws_availability_zones.all.names
  vpc_zone_identifier = ["subnet-d12914ef", "subnet-0e6b8568"]
  min_size = 2
  max_size = 10

  load_balancers    = [aws_elb.example.name]
  health_check_type = "ELB"

  tag {
    key                 = "Name"
    value               = "${var.component}"
    propagate_at_launch = true
  }
}