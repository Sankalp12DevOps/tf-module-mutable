resource "aws_spot_instance_request" "spot" {
  count                     = 0 #var.SP_COUNT  
  ami                       = data.aws_ami.my_image.id
  instance_type             = var.INSTANCE_TYPE
  wait_for_fulfillment      = true
  vpc_security_group_ids    = [aws_security_group.allow_tls_prvtappservers.id]
  subnet_id                 = element(data.terraform_remote_state.vpc.outputs.PRVT_SUBNET_IDS,count.index)
  tags = {
    Name = "${var.COMPONENT}-${var.ENV}-${count.index}-spot"
  }
}


resource "aws_instance" "od" {
  count                         = var.OD_COUNT
  ami                           = data.aws_ami.my_image.id
  instance_type                 = var.INSTANCE_TYPE
  vpc_security_group_ids        = [aws_security_group.allow_tls_prvtappservers.id]
  subnet_id                     = element(data.terraform_remote_state.vpc.outputs.PRVT_SUBNET_IDS,count.index)
  tags = {
     Name = "${var.COMPONENT}-${var.ENV}-${count.index}-od"
  }
}

resource "aws_ec2_tag" "tags" {
  count       = var.OD_COUNT + var.SP_COUNT
  resource_id = element(local.INSTANCE_IDS,count.index)
  key         = "Name"
  value       = "${var.COMPONENT}-${var.ENV}-${count.index}"
}