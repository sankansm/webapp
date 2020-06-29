data "aws_availability_zones" "all" {
    
}

data "aws_ami" "baked_ami"{
    most_recent      = true
    owners           = ["725732953117"]
}