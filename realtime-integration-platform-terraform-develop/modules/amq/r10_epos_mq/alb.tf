#Local variable declaration 
locals {
  alb_name   = "${var.env}-r10epos-amq-internal-nlb"
  alb_type   = "network"
  log_bucket = "amq_nlb_logs"
  tg_name    = "${var.env}-r10epos-amq-target-group"

  listner_protocol      = "TLS"
  listner_port          = "61617"
  alpn_policy           = "None"
  ssl_policy            = "ELBSecurityPolicy-2016-08"
  listner_appriss_port1 = "61614"
  tg_appris_name_1      = "${var.env}-r10appriss-amq-tg1"
  listner_appriss_port2 = "61615"
  listner_appriss_port3 = "61616"
  tg_appris_name_2      = "${var.env}-r10appriss-amq-tg2"
  tg_appris_name_3      = "${var.env}-r10appriss-amq-tg3"
  amqp_listner_port     = "5671"
  amqp_tg_name          = "${var.env}-r10epos-amqp-target-group"

  rout53_record = "r10eposmq.${var.host_zone}"

  health_check_port = "8162"

  ws_tg_name          = "${var.env}-r10epos-amq-ws-tg"
  ws_listner_protocol = "TLS"
  ws_listner_port     = "61619"
  ws_alpn_policy      = "None"
  ws_ssl_policy       = "ELBSecurityPolicy-2016-08"

}
/**********************************
resource "aws_eip" "eip_subnet_1" {

  associate_with_private_ip = "var.private_ipaddress_1"
  tags = {
    "Name" = "eip_subnet_1"
  }
}

resource "aws_eip" "eip_subnet_2" {

  associate_with_private_ip = "var.private_ipaddress_2"

  tags = {
    "Name" = "eip_subnet_2"
  }
}

resource "aws_eip" "eip_subnet_3" {

  associate_with_private_ip = "var.private_ipaddress_3"
  tags = {
    "Name" = "eip_subnet_3"
  }
}
****************************************************/



resource "aws_lb" "r10_epos_alb" {
  name                             = local.alb_name
  load_balancer_type               = local.alb_type
  internal                         = true
  enable_cross_zone_load_balancing = true
  //vpc_id                           = var.vpc_id
  //subnets                    = [var.private_subnet_id_1, var.private_subnet_id_2, var.private_subnet_id_3]

  enable_deletion_protection = var.Enable_flag
  subnet_mapping {
    subnet_id            = var.private_subnet_id_1
    private_ipv4_address = var.private_ipaddress_1
  }

  subnet_mapping {
    subnet_id            = var.private_subnet_id_2
    private_ipv4_address = var.private_ipaddress_2
  }
  subnet_mapping {
    subnet_id            = var.private_subnet_id_3
    private_ipv4_address = var.private_ipaddress_3
  }

  access_logs {
    bucket = local.log_bucket
  }

  provisioner "local-exec" {
    when = destroy
    #command = "echo ${self.arn}"
    command = "aws elbv2 modify-load-balancer-attributes --load-balancer-arn ${self.arn} --attributes Key=deletion_protection.enabled,Value=false"
  }
}


resource "aws_lb_target_group" "r10_epos_alb_tg" {
  name        = local.tg_name
  protocol    = local.listner_protocol
  port        = local.listner_port
  target_type = "ip"
  vpc_id      = var.vpc_id # Declare and get from main

  depends_on = [
    aws_lb.r10_epos_alb
  ]

  lifecycle {
    create_before_destroy = true
  }
  health_check {
    protocol = "TCP"
    port     = local.health_check_port
  }
}

# Listener for port 61619

resource "aws_lb_target_group" "r10_epos_alb_ws_tg" {
  name        = local.ws_tg_name
  protocol    = local.ws_listner_protocol
  port        = local.ws_listner_port
  target_type = "ip"
  vpc_id      = var.vpc_id # Declare and get from main

  depends_on = [
    aws_lb.r10_epos_alb
  ]

  lifecycle {
    create_before_destroy = true
  }
  health_check {
    protocol = "TCP"
    port     = local.health_check_port
  }
}


resource "aws_lb_target_group" "r10_epos_amqp_alb_tg" {
  name        = local.amqp_tg_name
  protocol    = local.listner_protocol
  port        = local.amqp_listner_port
  target_type = "ip"
  vpc_id      = var.vpc_id # Declare and get from main

  depends_on = [
    aws_lb.r10_epos_alb
  ]

  lifecycle {
    create_before_destroy = true
  }
  health_check {
    protocol = "TCP"
    port     = local.health_check_port
  }
}

resource "aws_lb_listener" "r10_epos_amqp_alb_listener" {
  load_balancer_arn = aws_lb.r10_epos_alb.arn
  protocol          = local.listner_protocol
  port              = local.amqp_listner_port
  alpn_policy       = local.alpn_policy
  ssl_policy        = local.ssl_policy
  certificate_arn   = var.certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.r10_epos_amqp_alb_tg.arn
  }
}

resource "aws_lb_target_group_attachment" "r10_epos_amqp_IP1" {
  target_group_arn = aws_lb_target_group.r10_epos_amqp_alb_tg.arn
  port             = local.amqp_listner_port
  target_id        = aws_mq_broker.r10_epos_mq_1.instances.0.ip_address
}

resource "aws_lb_target_group_attachment" "r10_epos_amqp_IP2" {
  target_group_arn = aws_lb_target_group.r10_epos_amqp_alb_tg.arn
  port             = local.amqp_listner_port
  target_id        = aws_mq_broker.r10_epos_mq_2.instances.0.ip_address
}

resource "aws_lb_target_group_attachment" "r10_epos_amqp_IP3" {
  target_group_arn = aws_lb_target_group.r10_epos_amqp_alb_tg.arn
  port             = local.amqp_listner_port
  target_id        = aws_mq_broker.r10_epos_mq_3.instances.0.ip_address
}

resource "aws_lb_target_group_attachment" "r10_epos_ws_IP1" {
  target_group_arn = aws_lb_target_group.r10_epos_alb_ws_tg.arn
  port             = local.ws_listner_port
  target_id        = aws_mq_broker.r10_epos_mq_1.instances.0.ip_address
}

resource "aws_lb_target_group_attachment" "r10_epos_ws_IP2" {
  target_group_arn = aws_lb_target_group.r10_epos_alb_ws_tg.arn
  port             = local.ws_listner_port
  target_id        = aws_mq_broker.r10_epos_mq_2.instances.0.ip_address
}

resource "aws_lb_target_group_attachment" "r10_epos_ws_IP3" {
  target_group_arn = aws_lb_target_group.r10_epos_alb_ws_tg.arn
  port             = local.ws_listner_port
  target_id        = aws_mq_broker.r10_epos_mq_3.instances.0.ip_address
}

resource "aws_lb_listener" "r10_epos_alb_ws_listener" {
  load_balancer_arn = aws_lb.r10_epos_alb.arn
  protocol          = local.ws_listner_protocol
  port              = local.ws_listner_port
  alpn_policy       = local.ws_alpn_policy
  ssl_policy        = local.ws_ssl_policy
  certificate_arn   = var.certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.r10_epos_alb_ws_tg.arn
  }
}

resource "aws_lb_target_group" "r10_appriss_alb_tg_1" {
  name        = local.tg_appris_name_1
  protocol    = local.listner_protocol
  port        = local.listner_appriss_port1
  target_type = "ip"
  vpc_id      = var.vpc_id # Declare and get from main

  depends_on = [
    aws_lb.r10_epos_alb
  ]

  lifecycle {
    create_before_destroy = true
  }
  health_check {
    protocol = "TCP"
    port     = local.health_check_port
  }
}

resource "aws_lb_target_group" "r10_appriss_alb_tg_2" {
  name        = local.tg_appris_name_2
  protocol    = local.listner_protocol
  port        = local.listner_appriss_port1
  target_type = "ip"
  vpc_id      = var.vpc_id # Declare and get from main

  depends_on = [
    aws_lb.r10_epos_alb
  ]

  lifecycle {
    create_before_destroy = true
  }
  health_check {
    protocol = "TCP"
    port     = local.health_check_port
  }
}

resource "aws_lb_target_group" "r10_appriss_alb_tg_3" {
  name        = local.tg_appris_name_3
  protocol    = local.listner_protocol
  port        = local.listner_appriss_port1
  target_type = "ip"
  vpc_id      = var.vpc_id # Declare and get from main

  depends_on = [
    aws_lb.r10_epos_alb
  ]

  lifecycle {
    create_before_destroy = true
  }
  health_check {
    protocol = "TCP"
    port     = local.health_check_port
  }
}



resource "aws_lb_listener" "r10_epos_alb_listener" {
  load_balancer_arn = aws_lb.r10_epos_alb.arn
  protocol          = local.listner_protocol
  port              = local.listner_port
  alpn_policy       = local.alpn_policy
  ssl_policy        = local.ssl_policy
  certificate_arn   = var.certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.r10_epos_alb_tg.arn
  }
}

resource "aws_lb_listener" "r10_appriss_alb_listener_1" {
  load_balancer_arn = aws_lb.r10_epos_alb.arn
  protocol          = local.listner_protocol
  port              = local.listner_appriss_port1
  alpn_policy       = local.alpn_policy
  ssl_policy        = local.ssl_policy
  certificate_arn   = var.certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.r10_appriss_alb_tg_1.arn
  }
}

resource "aws_lb_listener" "r10_appriss_alb_listener_2" {
  load_balancer_arn = aws_lb.r10_epos_alb.arn
  protocol          = local.listner_protocol
  port              = local.listner_appriss_port2
  alpn_policy       = local.alpn_policy
  ssl_policy        = local.ssl_policy
  certificate_arn   = var.certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.r10_appriss_alb_tg_2.arn
  }
}

resource "aws_lb_listener" "r10_appriss_alb_listener_3" {
  load_balancer_arn = aws_lb.r10_epos_alb.arn
  protocol          = local.listner_protocol
  port              = local.listner_appriss_port3
  alpn_policy       = local.alpn_policy
  ssl_policy        = local.ssl_policy
  certificate_arn   = var.certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.r10_appriss_alb_tg_3.arn
  }
}

resource "aws_lb_target_group_attachment" "r10_appriss_IP_3" {
  target_group_arn = aws_lb_target_group.r10_appriss_alb_tg_3.arn
  port             = local.listner_appriss_port1
  target_id        = aws_mq_broker.r10_epos_mq_3.instances.0.ip_address
}

resource "aws_lb_target_group_attachment" "r10_appriss_IP_2" {
  target_group_arn = aws_lb_target_group.r10_appriss_alb_tg_2.arn
  port             = local.listner_appriss_port1
  target_id        = aws_mq_broker.r10_epos_mq_2.instances.0.ip_address
}



resource "aws_lb_target_group_attachment" "r10_appriss_IP_1" {
  target_group_arn = aws_lb_target_group.r10_appriss_alb_tg_1.arn
  port             = local.listner_appriss_port1
  target_id        = aws_mq_broker.r10_epos_mq_1.instances.0.ip_address
}


resource "aws_lb_target_group_attachment" "r10_epos_IP1" {
  target_group_arn = aws_lb_target_group.r10_epos_alb_tg.arn
  port             = local.listner_port
  target_id        = aws_mq_broker.r10_epos_mq_1.instances.0.ip_address
}

resource "aws_lb_target_group_attachment" "r10_epos_IP2" {
  target_group_arn = aws_lb_target_group.r10_epos_alb_tg.arn
  port             = local.listner_port
  target_id        = aws_mq_broker.r10_epos_mq_2.instances.0.ip_address
}

resource "aws_lb_target_group_attachment" "r10_epos_IP3" {
  target_group_arn = aws_lb_target_group.r10_epos_alb_tg.arn
  port             = local.listner_port
  target_id        = aws_mq_broker.r10_epos_mq_3.instances.0.ip_address
}


resource "aws_route53_record" "r10_epos_dns_record" {
  zone_id = var.host_zone_id
  name    = local.rout53_record
  type    = "A"

  alias {
    name                   = aws_lb.r10_epos_alb.dns_name
    zone_id                = aws_lb.r10_epos_alb.zone_id
    evaluate_target_health = true
  }
} 