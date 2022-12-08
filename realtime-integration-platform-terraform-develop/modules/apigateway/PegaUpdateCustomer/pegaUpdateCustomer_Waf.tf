locals {
  ipset_name     = "pega_updateCustomer_whitelist_${var.env}_ipset"
  acl_name       = "pega_updateCustomer_web_acl_${var.env}"
  rule_name      = "Allow_pega_updateCustomer_${var.env}_IP_Ranges"
  log_group_name = "aws-waf-logs-${var.env}-pega_updateCustomer"
}


resource "aws_wafv2_ip_set" "pega_updateCustomer_whitelist_ipset" {
  name               = local.ipset_name
  description        = "pega_updateCustomer Whitelisted IP"
  scope              = "REGIONAL"
  ip_address_version = "IPV4"
  addresses          = concat(var.pega_IP)

}

resource "aws_wafv2_web_acl" "pega_updateCustomer_web_acl" {
  name        = local.acl_name
  description = "Web ACL for pega_updateCustomer API"
  scope       = "REGIONAL"

  depends_on = [
    aws_wafv2_ip_set.pega_updateCustomer_whitelist_ipset
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
        arn = aws_wafv2_ip_set.pega_updateCustomer_whitelist_ipset.arn
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = var.pega_updateCustomer_metrics_enabled_flag
      metric_name                = "pega_updateCustomer_Rule_Metric"
      sampled_requests_enabled   = false
    }
  }

  visibility_config {
    cloudwatch_metrics_enabled = var.pega_updateCustomer_metrics_enabled_flag
    metric_name                = "pega_updateCustomer_Acl_Metric"
    sampled_requests_enabled   = false
  }
}


resource "aws_wafv2_web_acl_association" "associate_to_pega_updateCustomer_api" {
  resource_arn = aws_api_gateway_stage.pega_updateCustomer_api_stage.arn
  web_acl_arn  = aws_wafv2_web_acl.pega_updateCustomer_web_acl.arn
}


resource "aws_cloudwatch_log_group" "pega_updateCustomer_wafv2_log_group" {
  name              = local.log_group_name
  retention_in_days = var.log_retention_days
}

resource "aws_wafv2_web_acl_logging_configuration" "pega_updateCustomer_waf_logging_configuration" {
  log_destination_configs = [aws_cloudwatch_log_group.pega_updateCustomer_wafv2_log_group.arn]
  resource_arn            = aws_wafv2_web_acl.pega_updateCustomer_web_acl.arn
}
