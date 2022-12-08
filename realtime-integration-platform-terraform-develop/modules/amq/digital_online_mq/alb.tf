#Local variable declaration -demo
locals {
  alb_name   = "${var.env}-digital-amq-internal-nlb"
  alb_type   = "network"
  log_bucket = "amq_nlb_logs"
  tg_name    = "${var.env}-digital-amq-target-group"

  listner_protocol    = "TLS"
  listner_port        = "61617"
  alpn_policy         = "None"
  ssl_policy          = "ELBSecurityPolicy-2016-08"
  ws_tg_name          = "${var.env}-digital-amq-ws-tg"
  ws_listner_protocol = "TLS"

  ws_listner_port = "61619"
  ws_alpn_policy  = "None"
  ws_ssl_policy   = "ELBSecurityPolicy-2016-08"

  stomp_listner_port = "61614"
  stomp_tg_name      = "${var.env}-digital-amq-stomp-tg"

  rout53_record     = "digitalmq.${var.host_zone}"
  health_check_port = "8162"

  // rout53_record_appriss = "r10eposmq.${var.host_zone}"
}


resource "aws_lb" "digital_online_alb" {
  name                             = local.alb_name
  load_balancer_type               = local.alb_type
  internal                         = true
  enable_cross_zone_load_balancing = true
  subnets                          = [var.private_subnet_id_1, var.private_subnet_id_2]
  enable_deletion_protection       = var.Enable_flag

  access_logs {
    bucket = local.log_bucket
  }

  provisioner "local-exec" {
    when    = destroy
    command = "aws elbv2 modify-load-balancer-attributes --load-balancer-arn ${self.arn} --attributes Key=deletion_protection.enabled,Value=false"
  }
}

resource "aws_lb_target_group" "digital_online_alb_tg" {
  name        = local.tg_name
  protocol    = local.listner_protocol
  port        = local.listner_port
  target_type = "ip"
  vpc_id      = var.vpc_id

  depends_on = [
    aws_lb.digital_online_alb
  ]
  lifecycle {
    create_before_destroy = true
  }
  health_check {
    protocol = "TCP"
    port     = local.health_check_port
  }
}


resource "aws_lb_listener" "digital_online_alb_listener" {
  load_balancer_arn = aws_lb.digital_online_alb.arn
  protocol          = local.listner_protocol
  port              = local.listner_port
  alpn_policy       = local.alpn_policy
  ssl_policy        = local.ssl_policy
  certificate_arn   = var.certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.digital_online_alb_tg.arn
  }
}



resource "aws_lb_target_group_attachment" "digital_online_IP1" {
  target_group_arn = aws_lb_target_group.digital_online_alb_tg.arn
  port             = local.listner_port
  target_id        = aws_mq_broker.digital_online_mq.instances.0.ip_address
}

resource "aws_lb_target_group_attachment" "digital_online_IP2" {
  target_group_arn = aws_lb_target_group.digital_online_alb_tg.arn
  port             = local.listner_port
  target_id        = aws_mq_broker.digital_online_mq.instances.1.ip_address
}

resource "aws_route53_record" "digital_online_dns_record" {
  zone_id = var.host_zone_id
  name    = local.rout53_record
  type    = "A"

  alias {
    name                   = aws_lb.digital_online_alb.dns_name
    zone_id                = aws_lb.digital_online_alb.zone_id
    evaluate_target_health = true
  }
}
/*********************************
resource "aws_route53_record" "digital_online_dns_appriss_record" {
  zone_id = var.host_zone_id
  name    = local.rout53_record_appriss
  type    = "A"

  alias {
    name                   = aws_lb.digital_online_alb.dns_name
    zone_id                = aws_lb.digital_online_alb.zone_id
    evaluate_target_health = true
  }
}
******************************/


resource "aws_lb_target_group" "digital_online_alb_ws_tg" {
  name        = local.ws_tg_name
  protocol    = local.ws_listner_protocol
  port        = local.ws_listner_port
  target_type = "ip"
  vpc_id      = var.vpc_id

  depends_on = [
    aws_lb.digital_online_alb
  ]
  lifecycle {
    create_before_destroy = true
  }
  health_check {
    protocol = "TCP"
    port     = local.health_check_port
  }
}

resource "aws_lb_target_group_attachment" "digital_online_ws_IP1" {
  target_group_arn = aws_lb_target_group.digital_online_alb_ws_tg.arn
  port             = local.ws_listner_port
  target_id        = aws_mq_broker.digital_online_mq.instances.0.ip_address
}

resource "aws_lb_target_group_attachment" "digital_online_ws_IP2" {
  target_group_arn = aws_lb_target_group.digital_online_alb_ws_tg.arn
  port             = local.ws_listner_port
  target_id        = aws_mq_broker.digital_online_mq.instances.1.ip_address

}

resource "aws_lb_listener" "digital_online_alb_ws_listener" {
  load_balancer_arn = aws_lb.digital_online_alb.arn
  protocol          = local.ws_listner_protocol
  port              = local.ws_listner_port
  alpn_policy       = local.ws_alpn_policy
  ssl_policy        = local.ws_ssl_policy
  certificate_arn   = var.certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.digital_online_alb_ws_tg.arn
  }
}


resource "aws_lb_target_group" "digital_online_alb_tg_stomp" {
  name        = local.stomp_tg_name
  protocol    = local.listner_protocol
  port        = local.stomp_listner_port
  target_type = "ip"
  vpc_id      = var.vpc_id

  depends_on = [
    aws_lb.digital_online_alb
  ]
  lifecycle {
    create_before_destroy = true
  }
  health_check {
    protocol = "TCP"
    port     = local.health_check_port
  }
}


resource "aws_lb_listener" "digital_online_alb_listener_stomp" {
  load_balancer_arn = aws_lb.digital_online_alb.arn
  protocol          = local.listner_protocol
  port              = local.stomp_listner_port
  alpn_policy       = local.alpn_policy
  ssl_policy        = local.ssl_policy
  certificate_arn   = var.certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.digital_online_alb_tg_stomp.arn
  }
}


resource "aws_lb_target_group_attachment" "digital_online_stomp_IP1" {
  target_group_arn = aws_lb_target_group.digital_online_alb_tg_stomp.arn
  port             = local.stomp_listner_port
  target_id        = aws_mq_broker.digital_online_mq.instances.0.ip_address
}

resource "aws_lb_target_group_attachment" "digital_online_stomp_IP2" {
  target_group_arn = aws_lb_target_group.digital_online_alb_tg_stomp.arn
  port             = local.stomp_listner_port
  target_id        = aws_mq_broker.digital_online_mq.instances.1.ip_address
}