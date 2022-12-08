#Local Variable Declaration 
locals {

  alb_name     = "${var.env}-retailcorp-amq-internal-nlb"
  alb_type     = "network"
  log_bucket   = "amq_nlb_logs"
  tg_name      = "${var.env}-retailcorp-amq-target-group"
  amqp_tg_name = "${var.env}-retailcorp-amqp-tg-group"

  listner_protocol = "TLS"
  listner_port     = "61617"
  alpn_policy      = "None"
  ssl_policy       = "ELBSecurityPolicy-2016-08"

  amqp_listner_port = "5671"


  rout53_record     = "retailcorpmq.${var.host_zone}"
  health_check_port = "8162"

  ws_tg_name          = "${var.env}-retailcorp-amq-ws-tg"
  ws_listner_protocol = "TLS"
  ws_listner_port     = "61619"
  ws_alpn_policy      = "None"
  ws_ssl_policy       = "ELBSecurityPolicy-2016-08"
}

resource "aws_lb" "retail_corp_alb" {
  name                             = local.alb_name
  load_balancer_type               = local.alb_type
  internal                         = true
  enable_cross_zone_load_balancing = true
  subnets                          = [var.private_subnet_id_1, var.private_subnet_id_2, var.private_subnet_id_3]
  enable_deletion_protection       = var.Enable_flag

  access_logs {
    bucket = local.log_bucket
  }

  provisioner "local-exec" {
    when    = destroy
    command = "aws elbv2 modify-load-balancer-attributes --load-balancer-arn ${self.arn} --attributes Key=deletion_protection.enabled,Value=false"
  }
}


resource "aws_lb_target_group" "retail_corp_alb_tg" {
  name        = local.tg_name
  protocol    = local.listner_protocol
  port        = local.listner_port
  target_type = "ip"
  vpc_id      = var.vpc_id # Declare and get from main

  depends_on = [
    aws_lb.retail_corp_alb
  ]

  lifecycle {
    create_before_destroy = true
  }
  health_check {
    protocol = "TCP"
    port     = local.health_check_port
  }
}
# Target group for AMQP protocol

resource "aws_lb_target_group" "retail_corp_alb_amqp_tg" {
  name        = local.amqp_tg_name
  protocol    = local.listner_protocol
  port        = local.amqp_listner_port
  target_type = "ip"
  vpc_id      = var.vpc_id # Declare and get from main

  depends_on = [
    aws_lb.retail_corp_alb
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

resource "aws_lb_target_group" "retail_corp_alb_ws_tg" {
  name        = local.ws_tg_name
  protocol    = local.ws_listner_protocol
  port        = local.ws_listner_port
  target_type = "ip"
  vpc_id      = var.vpc_id # Declare and get from main

  depends_on = [
    aws_lb.retail_corp_alb
  ]

  lifecycle {
    create_before_destroy = true
  }
  health_check {
    protocol = "TCP"
    port     = local.health_check_port
  }
}

resource "aws_lb_listener" "retail_corp_alb_listener" {
  load_balancer_arn = aws_lb.retail_corp_alb.arn
  protocol          = local.listner_protocol
  port              = local.listner_port
  alpn_policy       = local.alpn_policy
  ssl_policy        = local.ssl_policy
  certificate_arn   = var.certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.retail_corp_alb_tg.arn
  }
}

#Listner for port 5671
resource "aws_lb_listener" "retail_corp_alb_amqp_listener" {
  load_balancer_arn = aws_lb.retail_corp_alb.arn
  protocol          = local.listner_protocol
  port              = local.amqp_listner_port
  alpn_policy       = local.alpn_policy
  ssl_policy        = local.ssl_policy
  certificate_arn   = var.certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.retail_corp_alb_amqp_tg.arn
  }
}


resource "aws_lb_target_group_attachment" "retail_corp_IP1" {
  target_group_arn = aws_lb_target_group.retail_corp_alb_tg.arn
  port             = local.listner_port
  target_id        = aws_mq_broker.retail_corp_mq_1.instances.0.ip_address
}

resource "aws_lb_target_group_attachment" "retail_corp_IP2" {
  target_group_arn = aws_lb_target_group.retail_corp_alb_tg.arn
  port             = local.listner_port
  target_id        = aws_mq_broker.retail_corp_mq_2.instances.0.ip_address
}

resource "aws_lb_target_group_attachment" "retail_corp_IP3" {
  target_group_arn = aws_lb_target_group.retail_corp_alb_tg.arn
  port             = local.listner_port
  target_id        = aws_mq_broker.retail_corp_mq_3.instances.0.ip_address
}

resource "aws_lb_target_group_attachment" "retail_corp_amqp_IP1" {
  target_group_arn = aws_lb_target_group.retail_corp_alb_amqp_tg.arn
  port             = local.amqp_listner_port
  target_id        = aws_mq_broker.retail_corp_mq_1.instances.0.ip_address
}
resource "aws_lb_target_group_attachment" "retail_corp_amqp_IP2" {
  target_group_arn = aws_lb_target_group.retail_corp_alb_amqp_tg.arn
  port             = local.amqp_listner_port
  target_id        = aws_mq_broker.retail_corp_mq_2.instances.0.ip_address
}
resource "aws_lb_target_group_attachment" "retail_corp_amqp_IP3" {
  target_group_arn = aws_lb_target_group.retail_corp_alb_amqp_tg.arn
  port             = local.amqp_listner_port
  target_id        = aws_mq_broker.retail_corp_mq_3.instances.0.ip_address
}


resource "aws_lb_target_group_attachment" "retail_corp_ws_IP1" {
  target_group_arn = aws_lb_target_group.retail_corp_alb_ws_tg.arn
  port             = local.ws_listner_port
  target_id        = aws_mq_broker.retail_corp_mq_1.instances.0.ip_address
}

resource "aws_lb_target_group_attachment" "retail_corp_ws_IP2" {
  target_group_arn = aws_lb_target_group.retail_corp_alb_ws_tg.arn
  port             = local.ws_listner_port
  target_id        = aws_mq_broker.retail_corp_mq_2.instances.0.ip_address
}

resource "aws_lb_target_group_attachment" "retail_corp_ws_IP3" {
  target_group_arn = aws_lb_target_group.retail_corp_alb_ws_tg.arn
  port             = local.ws_listner_port
  target_id        = aws_mq_broker.retail_corp_mq_3.instances.0.ip_address
}


resource "aws_lb_listener" "retail_corp_alb_ws_listener" {
  load_balancer_arn = aws_lb.retail_corp_alb.arn
  protocol          = local.ws_listner_protocol
  port              = local.ws_listner_port
  alpn_policy       = local.ws_alpn_policy
  ssl_policy        = local.ws_ssl_policy
  certificate_arn   = var.certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.retail_corp_alb_ws_tg.arn
  }
}

resource "aws_route53_record" "retail_corp_dns_record" {
  zone_id = var.host_zone_id
  name    = local.rout53_record
  type    = "A"

  alias {
    name                   = aws_lb.retail_corp_alb.dns_name
    zone_id                = aws_lb.retail_corp_alb.zone_id
    evaluate_target_health = true
  }
}