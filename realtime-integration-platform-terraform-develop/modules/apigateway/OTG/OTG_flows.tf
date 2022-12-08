resource "aws_api_gateway_rest_api" "create_rest_api" {
  name        = var.otg_common_api_name
  description = var.otg_common_api_description
  endpoint_configuration {

    types = ["REGIONAL"]

  }
}

locals {
  otg_common_lambda_permission_statement_id = "Allow_Invoke_otg_common_${var.env}"
}

resource "aws_api_gateway_resource" "otg_sales_api_gateway_resource" {
  path_part   = var.otg_sales_api_path_part
  parent_id   = aws_api_gateway_rest_api.create_rest_api.root_resource_id
  rest_api_id = aws_api_gateway_rest_api.create_rest_api.id
}
resource "aws_api_gateway_resource" "otg_Heartbeat_api_gateway_resource" {
  path_part   = var.otg_Heartbeat_api_path_part
  parent_id   = aws_api_gateway_rest_api.create_rest_api.root_resource_id
  rest_api_id = aws_api_gateway_rest_api.create_rest_api.id
}
resource "aws_api_gateway_resource" "otg_EODKeys_api_gateway_resource" {
  path_part   = var.otg_EODKeys_api_path_part
  parent_id   = aws_api_gateway_rest_api.create_rest_api.root_resource_id
  rest_api_id = aws_api_gateway_rest_api.create_rest_api.id
}
resource "aws_api_gateway_resource" "otg_EODTotals_api_gateway_resource" {
  path_part   = var.otg_EODTotals_api_path_part
  parent_id   = aws_api_gateway_rest_api.create_rest_api.root_resource_id
  rest_api_id = aws_api_gateway_rest_api.create_rest_api.id
}

resource "aws_api_gateway_method" "otg_sales_api_gateway_method" {
  rest_api_id   = aws_api_gateway_rest_api.create_rest_api.id
  resource_id   = aws_api_gateway_resource.otg_sales_api_gateway_resource.id
  http_method   = var.otg_common_api_method
  authorization = "CUSTOM"
  authorizer_id = aws_api_gateway_authorizer.otg_common_auth.id
}
resource "aws_api_gateway_method" "otg_Heartbeat_api_gateway_method" {
  rest_api_id   = aws_api_gateway_rest_api.create_rest_api.id
  resource_id   = aws_api_gateway_resource.otg_Heartbeat_api_gateway_resource.id
  http_method   = var.otg_common_api_method
  authorization = "CUSTOM"
  authorizer_id = aws_api_gateway_authorizer.otg_common_auth.id
}
resource "aws_api_gateway_method" "otg_EODKeys_api_gateway_method" {
  rest_api_id   = aws_api_gateway_rest_api.create_rest_api.id
  resource_id   = aws_api_gateway_resource.otg_EODKeys_api_gateway_resource.id
  http_method   = var.otg_common_api_method
  authorization = "CUSTOM"
  authorizer_id = aws_api_gateway_authorizer.otg_common_auth.id
}
resource "aws_api_gateway_method" "otg_EODTotals_api_gateway_method" {
  rest_api_id   = aws_api_gateway_rest_api.create_rest_api.id
  resource_id   = aws_api_gateway_resource.otg_EODTotals_api_gateway_resource.id
  http_method   = var.otg_common_api_method
  authorization = "CUSTOM"
  authorizer_id = aws_api_gateway_authorizer.otg_common_auth.id
}

resource "aws_api_gateway_authorizer" "otg_common_auth" {
  name            = "CustomAuthoriser"
  rest_api_id     = aws_api_gateway_rest_api.create_rest_api.id
  authorizer_uri  = var.otg_common_lambda_authorizer_arn
  identity_source = "method.request.header.Authorization"
  type            = "REQUEST"

}

resource "aws_api_gateway_integration" "otg_sales_api_gateway_integration" {
  rest_api_id             = aws_api_gateway_rest_api.create_rest_api.id
  resource_id             = aws_api_gateway_resource.otg_sales_api_gateway_resource.id
  integration_http_method = aws_api_gateway_method.otg_sales_api_gateway_method.http_method
  type                    = var.otg_common_integration_type
  http_method             = aws_api_gateway_method.otg_sales_api_gateway_method.http_method
  connection_type         = var.otg_common_connection_type
  connection_id           = var.api_vpc_link_id
  uri                     = var.otg_sales_uri
}
resource "aws_api_gateway_integration" "otg_Heartbeat_api_gateway_integration" {
  rest_api_id             = aws_api_gateway_rest_api.create_rest_api.id
  resource_id             = aws_api_gateway_resource.otg_Heartbeat_api_gateway_resource.id
  integration_http_method = aws_api_gateway_method.otg_Heartbeat_api_gateway_method.http_method
  type                    = var.otg_common_integration_type
  http_method             = aws_api_gateway_method.otg_Heartbeat_api_gateway_method.http_method
  connection_type         = var.otg_common_connection_type
  connection_id           = var.api_vpc_link_id
  uri                     = var.otg_Heartbeat_uri
}
resource "aws_api_gateway_integration" "otg_EODKeys_api_gateway_integration" {
  rest_api_id             = aws_api_gateway_rest_api.create_rest_api.id
  resource_id             = aws_api_gateway_resource.otg_EODKeys_api_gateway_resource.id
  integration_http_method = aws_api_gateway_method.otg_EODKeys_api_gateway_method.http_method
  type                    = var.otg_common_integration_type
  http_method             = aws_api_gateway_method.otg_EODKeys_api_gateway_method.http_method
  connection_type         = var.otg_common_connection_type
  connection_id           = var.api_vpc_link_id
  uri                     = var.otg_EODKeys_uri
}
resource "aws_api_gateway_integration" "otg_EODTotals_api_gateway_integration" {
  rest_api_id             = aws_api_gateway_rest_api.create_rest_api.id
  resource_id             = aws_api_gateway_resource.otg_EODTotals_api_gateway_resource.id
  integration_http_method = aws_api_gateway_method.otg_EODTotals_api_gateway_method.http_method
  type                    = var.otg_common_integration_type
  http_method             = aws_api_gateway_method.otg_EODTotals_api_gateway_method.http_method
  connection_type         = var.otg_common_connection_type
  connection_id           = var.api_vpc_link_id
  uri                     = var.otg_EODTotals_uri
}


resource "aws_api_gateway_method_response" "otg_sales_responses" {
  rest_api_id = aws_api_gateway_rest_api.create_rest_api.id
  resource_id = aws_api_gateway_resource.otg_sales_api_gateway_resource.id
  http_method = aws_api_gateway_method.otg_sales_api_gateway_method.http_method
  status_code = "200"
}
resource "aws_api_gateway_method_response" "otg_Heartbeat_responses" {
  rest_api_id = aws_api_gateway_rest_api.create_rest_api.id
  resource_id = aws_api_gateway_resource.otg_Heartbeat_api_gateway_resource.id
  http_method = aws_api_gateway_method.otg_Heartbeat_api_gateway_method.http_method
  status_code = "200"
}
resource "aws_api_gateway_method_response" "otg_EODKeys_responses" {
  rest_api_id = aws_api_gateway_rest_api.create_rest_api.id
  resource_id = aws_api_gateway_resource.otg_EODKeys_api_gateway_resource.id
  http_method = aws_api_gateway_method.otg_EODKeys_api_gateway_method.http_method
  status_code = "200"
}
resource "aws_api_gateway_method_response" "otg_EODTotals_responses" {
  rest_api_id = aws_api_gateway_rest_api.create_rest_api.id
  resource_id = aws_api_gateway_resource.otg_EODTotals_api_gateway_resource.id
  http_method = aws_api_gateway_method.otg_EODTotals_api_gateway_method.http_method
  status_code = "200"
}

resource "aws_api_gateway_integration_response" "otg_sales_integration_response" {
  rest_api_id = aws_api_gateway_rest_api.create_rest_api.id
  resource_id = aws_api_gateway_resource.otg_sales_api_gateway_resource.id
  http_method = var.otg_common_api_method
  status_code = aws_api_gateway_method_response.otg_sales_responses.status_code
  depends_on = [
    aws_api_gateway_integration.otg_sales_api_gateway_integration
  ]
}

#Replaced by AWS WAF ACL
/* resource "aws_api_gateway_rest_api_policy" "ResourcePolicy" {
  rest_api_id = aws_api_gateway_rest_api.create_rest_api.id

  policy = <<EOF

{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Deny",
            "Principal": {
                "AWS": "*"
            },
            "Action": "execute-api:Invoke",
            "Resource": [
                  "${aws_api_gateway_rest_api.create_rest_api.execution_arn}/*"
                  ],
            "Condition": {
                "NotIpAddress": {
                    "aws:SourceIp":  ${jsonencode(concat(var.otg_IP))}
                }
            }
        },
        {
            "Effect": "Allow",
            "Principal": "*",
            "Action": "execute-api:Invoke",
            "Resource": [
                  "${aws_api_gateway_rest_api.create_rest_api.execution_arn}/*"
                  ]
        }
    ]
}
EOF
} */

resource "aws_api_gateway_integration_response" "otg_Heartbeat_integration_response" {
  rest_api_id = aws_api_gateway_rest_api.create_rest_api.id
  resource_id = aws_api_gateway_resource.otg_Heartbeat_api_gateway_resource.id
  http_method = var.otg_common_api_method
  status_code = aws_api_gateway_method_response.otg_Heartbeat_responses.status_code
  depends_on = [
    aws_api_gateway_integration.otg_Heartbeat_api_gateway_integration
  ]
}
resource "aws_api_gateway_integration_response" "otg_EODKeys_integration_response" {
  rest_api_id = aws_api_gateway_rest_api.create_rest_api.id
  resource_id = aws_api_gateway_resource.otg_EODKeys_api_gateway_resource.id
  http_method = var.otg_common_api_method
  status_code = aws_api_gateway_method_response.otg_EODKeys_responses.status_code
  depends_on = [
    aws_api_gateway_integration.otg_EODKeys_api_gateway_integration
  ]
}
resource "aws_api_gateway_integration_response" "otg_EODTotals_integration_response" {
  rest_api_id = aws_api_gateway_rest_api.create_rest_api.id
  resource_id = aws_api_gateway_resource.otg_EODTotals_api_gateway_resource.id
  http_method = var.otg_common_api_method
  status_code = aws_api_gateway_method_response.otg_EODTotals_responses.status_code
  depends_on = [
    aws_api_gateway_integration.otg_EODTotals_api_gateway_integration
  ]
}
resource "aws_api_gateway_deployment" "otg_common_api_gateway_deployment" {
  rest_api_id = aws_api_gateway_rest_api.create_rest_api.id

  triggers = {
    redeployment = sha1(jsonencode([
      aws_api_gateway_resource.otg_sales_api_gateway_resource,
      aws_api_gateway_resource.otg_Heartbeat_api_gateway_resource,
      aws_api_gateway_resource.otg_EODKeys_api_gateway_resource,
      aws_api_gateway_resource.otg_EODTotals_api_gateway_resource,
      aws_api_gateway_method.otg_sales_api_gateway_method,
      aws_api_gateway_method.otg_Heartbeat_api_gateway_method,
      aws_api_gateway_method.otg_EODKeys_api_gateway_method,
      aws_api_gateway_method.otg_EODTotals_api_gateway_method,
      aws_api_gateway_integration.otg_sales_api_gateway_integration,
      aws_api_gateway_integration.otg_Heartbeat_api_gateway_integration,
      aws_api_gateway_integration.otg_EODKeys_api_gateway_integration,
      aws_api_gateway_integration.otg_EODTotals_api_gateway_integration,
      aws_cloudwatch_log_group.otg_common

    ]))
  }


  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_api_gateway_stage" "otg_common_api_stage" {
  deployment_id = aws_api_gateway_deployment.otg_common_api_gateway_deployment.id
  rest_api_id   = aws_api_gateway_rest_api.create_rest_api.id
  stage_name    = var.env
  variables = {
    server = "api.${var.env}.iprm.js-devops.co.uk"
    port   = "17003"
  }
  access_log_settings {
    destination_arn = aws_cloudwatch_log_group.otg_common.arn
    format          = jsonencode({ "requestId" : "$context.requestId", "ip" : "$context.identity.sourceIp", "caller" : "$context.identity.caller", "user" : "$context.identity.user", "requestTime" : "$context.requestTime", "httpMethod" : "$context.httpMethod", "resourcePath" : "$context.resourcePath", "status" : "$context.status", "protocol" : "$context.protocol", "responseLength" : "$context.responseLength" })
  }

  lifecycle {
    ignore_changes = [cache_cluster_size]
  }

}

resource "aws_cloudwatch_log_group" "otg_common" {
  name              = "OTG/${var.env}"
  retention_in_days = var.log_retention_days

}

resource "aws_api_gateway_method_settings" "otg_common_settings" {
  rest_api_id = aws_api_gateway_rest_api.create_rest_api.id
  stage_name  = var.env
  method_path = "*/*"

  depends_on = [
    aws_api_gateway_stage.otg_common_api_stage
  ]
  settings {
    metrics_enabled    = var.otg_common_metrics_enabled_flag
    logging_level      = var.otg_common_logging_level
    data_trace_enabled = false

  }
}

resource "aws_lambda_permission" "otg_commonLamdaPermissions" {
  statement_id  = local.otg_common_lambda_permission_statement_id
  action        = "lambda:InvokeFunction"
  function_name = var.otg_common_lambda_function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.create_rest_api.execution_arn}/authorizers/${aws_api_gateway_authorizer.otg_common_auth.id}"
}

resource "aws_api_gateway_base_path_mapping" "apigatewaygenericscriptBasepath" {
  api_id      = aws_api_gateway_rest_api.create_rest_api.id
  stage_name  = aws_api_gateway_stage.otg_common_api_stage.stage_name
  domain_name = "api.${var.env}.iprm.js-devops.co.uk"
  base_path   = var.otg_common_api_mapping_path
}


resource "aws_api_gateway_gateway_response" "otg_common_api_gateway_respone" {
  rest_api_id   = aws_api_gateway_rest_api.create_rest_api.id
  status_code   = "401"
  response_type = "UNAUTHORIZED"

  response_templates = {
    "application/json" = "{\"message\":Access Denied.Incorrect password or username.Please check with Integration webMethods Team}"
  }

  response_parameters = {
    "gatewayresponse.header.Authorization" = "'Basic'"
  }
}

data "aws_lambda_function" "ingestion_function" {
  function_name = "newrelic-log-ingestion"
}

resource "aws_cloudwatch_log_subscription_filter" "cw_log_filter_OTG_Sales" {
  name            = "OTG_Sales/${var.env}"
  log_group_name  = "API-Gateway-Execution-Logs_${aws_api_gateway_rest_api.create_rest_api.id}/${var.env}"
  filter_pattern  = ""
  destination_arn = data.aws_lambda_function.ingestion_function.arn
  distribution    = "ByLogStream"
}