#Local variable Declaration
locals {

  alb_type = "network"

  application_type = "application"
  log_bucket       = "api_nlb_logs"
  tg_name_SIP      = "${var.env}-sip-api-target-group-${random_string.alb_prefix.result}"
  tg_name_912      = "${var.env}-912-api-target-group-${random_string.alb_prefix.result}"

  nlb_tg_name_sip      = "${var.env}-sip-alb-target-group"
  nlb_tg_name_912      = "${var.env}-912-alb-target-group"
  nlb_tg_name_sip_1011 = "${var.env}-sip1011-alb-target-group"
  nlb_tg_name_TN_1011  = "${var.env}-TN1011-alb-target-group"


  applicationLoadBalancer_tg_name_SIP      = "${var.env}-sip-api-target-group"
  applicationLoadBalancer_tg_name_SIP_1011 = "${var.env}-sip1011-api-target-group"

  applicationLoadBalancer_tg_name_912     = "${var.env}-912-api-target-group"
  applicationLoadBalancer_tg_name_TN_1011 = "${var.env}-TN1011-api-target-group"

  api_vpc_link       = "app-intg-platform-${var.env}-vpc-link"
  custom_domain_name = "api.${var.env}.iprm.js-devops.co.uk"

  cloudwatch_logging_role = "app-intg-platform-apigateway-logging-role"

  listner_protocol  = "TLS"
  alpn_policy       = "None"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  availability_zone = "all"

  applicationLoadBalancer_listner_protocol = "HTTPS"
}

resource "random_string" "alb_prefix" {
  length  = 5
  upper   = false
  special = false
}

resource "aws_api_gateway_vpc_link" "api_vpc_link" {
  name        = local.api_vpc_link
  description = "VPC Link for API Gateway"
  target_arns = [aws_lb.api_alb.arn]
}

output "api_vpc_link_id" {
  value       = aws_api_gateway_vpc_link.api_vpc_link.id
  description = "VPC Link id Output"
}

resource "aws_lb" "api_alb" {
  name                             = "${var.env}-intg-api-internal-nlb"
  load_balancer_type               = local.alb_type
  internal                         = true
  enable_cross_zone_load_balancing = true
  subnets                          = [var.private_subnet_id_1, var.private_subnet_id_2, var.private_subnet_id_3]
  enable_deletion_protection       = true

  access_logs {
    bucket = local.log_bucket
  }

}

resource "aws_api_gateway_domain_name" "api_custom_domain_97" {
  regional_certificate_arn = var.certificate_arn
  domain_name              = local.custom_domain_name
  security_policy          = "TLS_1_2"
  endpoint_configuration {
    types = ["REGIONAL"]
  }
}
//Route 53 record 
resource "aws_route53_record" "custom_domain_route53" {
  name    = aws_api_gateway_domain_name.api_custom_domain_97.domain_name
  type    = "A"
  zone_id = var.zone_id
  alias {
    evaluate_target_health = true
    name                   = aws_api_gateway_domain_name.api_custom_domain_97.regional_domain_name
    zone_id                = aws_api_gateway_domain_name.api_custom_domain_97.regional_zone_id
  }
}

data "aws_iam_role" "aws_logging_iam_role" {
  name = local.cloudwatch_logging_role

}
resource "aws_api_gateway_account" "aws_api_Iprm_gateway_account" {
  cloudwatch_role_arn = data.aws_iam_role.aws_logging_iam_role.arn
}

########################################################################################
#NLB to ALB Routing



resource "aws_lb_target_group" "api_nlb_target_group_SIP" {
  name        = local.nlb_tg_name_sip
  protocol    = "TCP"
  port        = var.listner_port_SIP
  target_type = "alb"
  vpc_id      = var.vpc_id


  health_check {
    path     = "/invoke/wm.server/ping"
    protocol = local.applicationLoadBalancer_listner_protocol
    timeout  = "10"
    interval = "30"


  }

  depends_on = [
    aws_lb.api_applicationLoadBalancer
  ]
  lifecycle {
    create_before_destroy = true
    ignore_changes = [
      name
    ]
  }
}

resource "aws_lb_target_group" "api_nlb_target_group_SIP_1011" {
  name        = local.nlb_tg_name_sip_1011
  protocol    = "TCP"
  port        = var.listner_port_SIP_1011
  target_type = "alb"
  vpc_id      = var.vpc_id


  health_check {
    path     = "/invoke/wm.server/ping"
    protocol = local.applicationLoadBalancer_listner_protocol
    timeout  = "10"
    interval = "30"


  }

  depends_on = [
    aws_lb.api_applicationLoadBalancer
  ]
  lifecycle {
    create_before_destroy = true
    ignore_changes = [
      name
    ]
  }
}

resource "aws_lb_target_group" "api_nlb_target_group_912" {
  name        = local.nlb_tg_name_912
  protocol    = "TCP"
  port        = var.listner_port_912
  target_type = "alb"
  vpc_id      = var.vpc_id


  health_check {
    path     = "/invoke/wm.server/ping"
    protocol = local.applicationLoadBalancer_listner_protocol
    timeout  = "10"
    interval = "30"


  }


  depends_on = [
    aws_lb.api_applicationLoadBalancer
  ]
  lifecycle {
    create_before_destroy = true
    ignore_changes = [
      name
    ]
  }
}

resource "aws_lb_target_group" "api_nlb_target_group_TN_1011" {
  name        = local.nlb_tg_name_TN_1011
  protocol    = "TCP"
  port        = var.listner_port_TN_1011
  target_type = "alb"
  vpc_id      = var.vpc_id


  health_check {
    path     = "/invoke/wm.server/ping"
    protocol = local.applicationLoadBalancer_listner_protocol
    timeout  = "10"
    interval = "30"


  }


  depends_on = [
    aws_lb.api_applicationLoadBalancer
  ]
  lifecycle {
    create_before_destroy = true
    ignore_changes = [
      name
    ]
  }
}

resource "aws_lb_listener" "api_nlb_listener_SIP" {
  load_balancer_arn = aws_lb.api_alb.arn
  protocol          = "TCP"
  port              = var.listner_port_SIP


  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.api_nlb_target_group_SIP.arn
  }
}

resource "aws_lb_listener" "api_nlb_listener_SIP_1011" {
  load_balancer_arn = aws_lb.api_alb.arn
  protocol          = "TCP"
  port              = var.listner_port_SIP_1011


  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.api_nlb_target_group_SIP_1011.arn
  }
}

resource "aws_lb_listener" "api_nlb_listener_912" {
  load_balancer_arn = aws_lb.api_alb.arn
  protocol          = "TCP"
  port              = var.listner_port_912

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.api_nlb_target_group_912.arn
  }
}

resource "aws_lb_listener" "api_nlb_listener_TN_1011" {
  load_balancer_arn = aws_lb.api_alb.arn
  protocol          = "TCP"
  port              = var.listner_port_TN_1011

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.api_nlb_target_group_TN_1011.arn
  }
}

resource "aws_lb_target_group_attachment" "aip_nlb_SIP_target_group_attachment" {

  target_group_arn = aws_lb_target_group.api_nlb_target_group_SIP.arn
  port             = var.listner_port_SIP
  target_id        = aws_lb.api_applicationLoadBalancer.arn

}

resource "aws_lb_target_group_attachment" "aip_nlb_SIP_1011_target_group_attachment" {

  target_group_arn = aws_lb_target_group.api_nlb_target_group_SIP_1011.arn
  port             = var.listner_port_SIP_1011
  target_id        = aws_lb.api_applicationLoadBalancer.arn

  depends_on = [
    aws_lb_listener.api_applicationLoadBalancer_listener_SIP_1011
  ]

}

resource "aws_lb_target_group_attachment" "aip_nlb_912_target_group_attachment" {

  target_group_arn = aws_lb_target_group.api_nlb_target_group_912.arn
  port             = var.listner_port_912
  target_id        = aws_lb.api_applicationLoadBalancer.arn

}

resource "aws_lb_target_group_attachment" "aip_nlb_TN_1011_target_group_attachment" {

  target_group_arn = aws_lb_target_group.api_nlb_target_group_TN_1011.arn
  port             = var.listner_port_TN_1011
  target_id        = aws_lb.api_applicationLoadBalancer.arn

  depends_on = [
    aws_lb_listener.api_applicationLoadBalancer_listener_TN_1011
  ]

}


#########################################################################################


#Application Load Balancer creation
resource "aws_lb" "api_applicationLoadBalancer" {
  name                       = "${var.env}-intg-api-internal-alb"
  load_balancer_type         = local.application_type
  internal                   = true
  subnets                    = [var.private_subnet_id_1, var.private_subnet_id_2, var.private_subnet_id_3]
  security_groups            = [aws_security_group.alb_sg.id]
  enable_deletion_protection = true

  access_logs {
    bucket = local.log_bucket
  }

}

resource "aws_lb_target_group" "api_applicationLoadBalancer_target_group_SIP" {
  name        = local.applicationLoadBalancer_tg_name_SIP
  protocol    = local.applicationLoadBalancer_listner_protocol
  port        = var.listner_port_SIP
  target_type = "ip"
  vpc_id      = var.vpc_id

  health_check {
    path     = "/invoke/wm.server/ping"
    matcher  = "200"
    timeout  = "10"
    interval = "30"
    protocol = local.applicationLoadBalancer_listner_protocol
  }

  depends_on = [
    aws_lb.api_applicationLoadBalancer
  ]
  lifecycle {
    create_before_destroy = true
    ignore_changes = [
      name
    ]
  }
}

resource "aws_lb_target_group" "api_applicationLoadBalancer_target_group_SIP_1011" {
  name        = local.applicationLoadBalancer_tg_name_SIP_1011
  protocol    = local.applicationLoadBalancer_listner_protocol
  port        = var.listner_port_SIP
  target_type = "ip"
  vpc_id      = var.vpc_id

  health_check {
    path     = "/invoke/wm.server/ping"
    matcher  = "200"
    timeout  = "10"
    interval = "30"
    protocol = local.applicationLoadBalancer_listner_protocol
  }

  depends_on = [
    aws_lb.api_applicationLoadBalancer
  ]
  lifecycle {
    create_before_destroy = true
    ignore_changes = [
      name
    ]
  }
}

resource "aws_lb_target_group" "api_applicationLoadBalancer_target_group_912" {
  name        = local.applicationLoadBalancer_tg_name_912
  protocol    = local.applicationLoadBalancer_listner_protocol
  port        = var.listner_port_912
  target_type = "ip"
  vpc_id      = var.vpc_id

  health_check {
    path     = "/invoke/wm.server/ping"
    matcher  = "200"
    timeout  = "10"
    interval = "30"
    protocol = local.applicationLoadBalancer_listner_protocol
  }

  depends_on = [
    aws_lb.api_applicationLoadBalancer
  ]
  lifecycle {
    create_before_destroy = true
    ignore_changes = [
      name
    ]
  }
}


resource "aws_lb_target_group" "api_applicationLoadBalancer_target_group_TN_1011" {
  name        = local.applicationLoadBalancer_tg_name_TN_1011
  protocol    = local.applicationLoadBalancer_listner_protocol
  port        = var.listner_port_912
  target_type = "ip"
  vpc_id      = var.vpc_id

  health_check {
    path     = "/invoke/wm.server/ping"
    matcher  = "200"
    timeout  = "10"
    interval = "30"
    protocol = local.applicationLoadBalancer_listner_protocol
  }

  depends_on = [
    aws_lb.api_applicationLoadBalancer
  ]
  lifecycle {
    create_before_destroy = true
    ignore_changes = [
      name
    ]
  }
}

resource "aws_lb_listener" "api_applicationLoadBalancer_listener_SIP" {
  load_balancer_arn = aws_lb.api_applicationLoadBalancer.arn
  protocol          = local.applicationLoadBalancer_listner_protocol
  port              = var.listner_port_SIP
  ssl_policy        = local.ssl_policy
  certificate_arn   = var.certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.api_applicationLoadBalancer_target_group_SIP.arn
  }
}

resource "aws_lb_listener" "api_applicationLoadBalancer_listener_SIP_1011" {
  load_balancer_arn = aws_lb.api_applicationLoadBalancer.arn
  protocol          = local.applicationLoadBalancer_listner_protocol
  port              = var.listner_port_SIP_1011
  ssl_policy        = local.ssl_policy
  certificate_arn   = var.certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.api_applicationLoadBalancer_target_group_SIP_1011.arn
  }
}

resource "aws_lb_listener" "api_applicationLoadBalancer_listener_912" {
  load_balancer_arn = aws_lb.api_applicationLoadBalancer.arn
  protocol          = local.applicationLoadBalancer_listner_protocol
  port              = var.listner_port_912
  ssl_policy        = local.ssl_policy
  certificate_arn   = var.certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.api_applicationLoadBalancer_target_group_912.arn
  }
}

resource "aws_lb_listener" "api_applicationLoadBalancer_listener_TN_1011" {
  load_balancer_arn = aws_lb.api_applicationLoadBalancer.arn
  protocol          = local.applicationLoadBalancer_listner_protocol
  port              = var.listner_port_TN_1011
  ssl_policy        = local.ssl_policy
  certificate_arn   = var.certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.api_applicationLoadBalancer_target_group_TN_1011.arn
  }
}

resource "aws_lb_target_group_attachment" "aip_applicationLoadBalancer_SIP_target_group_attachment" {
  count             = length(var.sip_ip_address)
  target_group_arn  = aws_lb_target_group.api_applicationLoadBalancer_target_group_SIP.arn
  port              = var.listner_port_SIP
  target_id         = var.sip_ip_address[count.index]
  availability_zone = local.availability_zone
}

resource "aws_lb_target_group_attachment" "aip_applicationLoadBalancer_SIP_target_group_attachment_1011" {
  count             = length(var.sip_1011_ip_address)
  target_group_arn  = aws_lb_target_group.api_applicationLoadBalancer_target_group_SIP_1011.arn
  port              = var.listner_port_SIP
  target_id         = var.sip_1011_ip_address[count.index]
  availability_zone = local.availability_zone
}
resource "aws_lb_target_group_attachment" "aip_applicationLoadBalancer_912_target_group_attachment" {
  count             = length(var.TN_ip_address)
  target_group_arn  = aws_lb_target_group.api_applicationLoadBalancer_target_group_912.arn
  port              = var.listner_port_912
  target_id         = var.TN_ip_address[count.index]
  availability_zone = local.availability_zone
}

resource "aws_lb_target_group_attachment" "aip_applicationLoadBalancer_TN_1011_target_group_attachment" {
  count             = length(var.TN_1011_ip_address)
  target_group_arn  = aws_lb_target_group.api_applicationLoadBalancer_target_group_TN_1011.arn
  port              = var.listner_port_912
  target_id         = var.TN_1011_ip_address[count.index]
  availability_zone = local.availability_zone
}

##########################################################################################################


