data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket = "my-terraform-learn"
    key = "${var.ENV}/terraform/terraform.tfstate"
    region = "ap-south-1"
  }
}

data "terraform_remote_state" "lb" {
  backend = "s3"
  config = {
    bucket = "my-terraform-learn"
    key    = "${var.ENV}/lb/terraform.tfstate"
    region = "ap-south-1"
  }
}

data "aws_ami" "my_image" {
  most_recent      = true
  name_regex       = "ansible-jenkins"
  owners           = ["self"]

}