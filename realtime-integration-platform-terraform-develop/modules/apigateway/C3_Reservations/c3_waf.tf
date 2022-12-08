locals {
  ipset_name     = "c3_whitelist_${var.env}_ipset"
  acl_name       = "c3_web_acl_${var.env}"
  rule_name      = "Allow_C3_${var.env}_IP_Ranges"
  log_group_name = "aws-waf-logs-${var.env}-c3"
}


resource "aws_wafv2_ip_set" "c3_whitelist_ipset" {
  name               = local.ipset_name
  description        = "C3 Whitelisted IP Set"
  scope              = "REGIONAL"
  ip_address_version = "IPV4"
  addresses          = concat(var.C3_Reservations_IP)

}

resource "aws_wafv2_web_acl" "c3_web_acl" {
  name        = local.acl_name
  description = "Web ACL for C3 API"
  scope       = "REGIONAL"

  depends_on = [
    aws_wafv2_ip_set.c3_whitelist_ipset
  ]

  default_action {
    block {}
  }

  lifecycle {
    ignore_changes = [tags]
  }

  rule {
    name     = local.rule_name
    priority = 0

    action {
      allow {}
    }

    statement {
      ip_set_reference_statement {
        arn = aws_wafv2_ip_set.c3_whitelist_ipset.arn
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = var.C3_Reservations_metrics_enable_flag
      metric_name                = "C3_Rule_Metric"
      sampled_requests_enabled   = false
    }
  }

  visibility_config {
    cloudwatch_metrics_enabled = var.C3_Reservations_metrics_enable_flag
    metric_name                = "C3_Acl_Metric"
    sampled_requests_enabled   = false
  }
}


resource "aws_wafv2_web_acl_association" "associate_to_c3_api" {
  resource_arn = aws_api_gateway_stage.C3_Reservations_api_stage.arn
  web_acl_arn  = aws_wafv2_web_acl.c3_web_acl.arn
}

resource "aws_cloudwatch_log_group" "c3_wafv2_log_group" {
  name              = local.log_group_name
  retention_in_days = var.log_retention_days
}

resource "aws_wafv2_web_acl_logging_configuration" "c3_waf_logging_configuration" {
  log_destination_configs = [aws_cloudwatch_log_group.c3_wafv2_log_group.arn]
  resource_arn            = aws_wafv2_web_acl.c3_web_acl.arn
}