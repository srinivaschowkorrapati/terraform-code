# Local variable declaration
locals {
  sg_name = "${var.env}-alb-sg"

}

resource "aws_security_group" "alb_sg" {
  name        = local.sg_name
  description = "Allow JS inbound traffic to ALB"
  vpc_id      = var.vpc_id

  ingress {
    description = "Manged by terraform: AMQ Front end Access"
    from_port   = 15003
    to_port     = 15101
    protocol    = "tcp"
    cidr_blocks = concat(var.inbound_js_app_cidr_range)
  }

  ingress {
    description = "Manged by terraform: AMQ Front end Access"
    from_port   = 17003
    to_port     = 17101
    protocol    = "tcp"
    cidr_blocks = concat(var.inbound_js_app_cidr_range)
  }


  egress {
    description = "Manged by terraform"
    from_port   = 0
    to_port     = 0
    protocol    = "all"
    cidr_blocks = concat(var.outbound_cidr_block_list)
  }

  tags = {
    Name = local.sg_name
  }
}