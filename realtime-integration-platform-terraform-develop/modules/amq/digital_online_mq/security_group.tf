# Local variable declaration
locals {
  sg_name = "${var.env}-digital-online-mq-sg"
}

resource "aws_security_group" "digital_online_mq_sg" {
  name        = local.sg_name
  description = "Allow JS inbound traffic to Digital Online MQ"
  vpc_id      = var.vpc_id

  ingress {
    description = "Manged by terraform: AMQ Front end Access"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = concat(var.inbound_js_vnp_cidr_range)
  }

  ingress {
    description = "Manged by terraform: AMQ Front end Access"
    from_port   = 8162
    to_port     = 8162
    protocol    = "tcp"
    cidr_blocks = concat(var.inbound_js_vnp_cidr_range)
  }

  ingress {
    description = "Manged by terraform: NLB Health check access"
    from_port   = 8162
    to_port     = 8162
    protocol    = "tcp"
    cidr_blocks = concat(var.env_vpc_cidr_range)
  }



  ingress {
    description = "Manged by terraform: AMQ SSL port"
    from_port   = 61614
    to_port     = 61619
    protocol    = "tcp"
    cidr_blocks = concat(var.inbound_js_app_cidr_range)
  }

  egress {
    description = "Manged by terraform"
    from_port   = 0
    to_port     = 0
    protocol    = "all"
    cidr_blocks = concat(var.outbound_cidr_block_list)
    #ipv6_cidr_blocks = ["::/0"] --> Not Required
  }

  tags = {
    Name = local.sg_name
  }
}