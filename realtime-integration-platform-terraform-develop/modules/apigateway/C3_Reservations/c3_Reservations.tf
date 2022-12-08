resource "aws_api_gateway_rest_api" "create_rest_api" {
  name        = var.C3_Reservations_api_name
  description = var.C3_Reservations_api_description
  endpoint_configuration {

    types = ["REGIONAL"]

  }
}

#Replaced by AWS WAF ACL
/*
resource "aws_api_gateway_rest_api_policy" "ResourcePolicy" {
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
                    "aws:SourceIp":  ${jsonencode(concat(var.C3_Reservations_IP))}
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

locals {
  C3_Reservations_lambda_permission_statement_id = "Allow_Invoke_C3_Reservations_${var.env}"
}

resource "aws_api_gateway_resource" "C3_Reservations_api_gateway_resource" {
  path_part   = var.C3_Reservations_api_path_part
  parent_id   = aws_api_gateway_rest_api.create_rest_api.root_resource_id
  rest_api_id = aws_api_gateway_rest_api.create_rest_api.id
}

resource "aws_api_gateway_method" "C3_Reservations_api_gateway_method" {
  rest_api_id   = aws_api_gateway_rest_api.create_rest_api.id
  resource_id   = aws_api_gateway_resource.C3_Reservations_api_gateway_resource.id
  http_method   = var.C3_Reservations_api_method
  authorization = "CUSTOM"
  authorizer_id = aws_api_gateway_authorizer.C3_Reservations_auth.id
  request_parameters = {
    "method.request.header.Accept"       = true
    "method.request.header.Content-Type" = true
  }
}

resource "aws_api_gateway_authorizer" "C3_Reservations_auth" {
  name            = "CustomAuthoriser"
  rest_api_id     = aws_api_gateway_rest_api.create_rest_api.id
  authorizer_uri  = var.C3_Reservations_lambda_authorizer_arn
  identity_source = "method.request.header.Authorization"
  type            = "REQUEST"

}

resource "aws_api_gateway_integration" "C3_Reservations_api_gateway_integration" {
  rest_api_id             = aws_api_gateway_rest_api.create_rest_api.id
  resource_id             = aws_api_gateway_resource.C3_Reservations_api_gateway_resource.id
  integration_http_method = aws_api_gateway_method.C3_Reservations_api_gateway_method.http_method
  type                    = var.C3_Reservations_integration_type
  http_method             = aws_api_gateway_method.C3_Reservations_api_gateway_method.http_method
  connection_type         = var.C3_Reservations_connection_type
  connection_id           = var.api_vpc_link_id
  uri                     = var.C3_Reservations_uri
  request_parameters = {
    "integration.request.header.Accept"       = "method.request.header.Accept"
    "integration.request.header.Content-Type" = "method.request.header.Content-Type"
  }
}

resource "aws_api_gateway_method_response" "C3_Reservations_responses" {
  rest_api_id = aws_api_gateway_rest_api.create_rest_api.id
  resource_id = aws_api_gateway_resource.C3_Reservations_api_gateway_resource.id
  http_method = aws_api_gateway_method.C3_Reservations_api_gateway_method.http_method
  status_code = "200"
}

resource "aws_api_gateway_integration_response" "C3_Reservations_integration_response" {
  rest_api_id = aws_api_gateway_rest_api.create_rest_api.id
  resource_id = aws_api_gateway_resource.C3_Reservations_api_gateway_resource.id
  http_method = var.C3_Reservations_api_method
  status_code = aws_api_gateway_method_response.C3_Reservations_responses.status_code
  depends_on = [
    aws_api_gateway_integration.C3_Reservations_api_gateway_integration
  ]
}
resource "aws_api_gateway_deployment" "C3_Reservations_api_gateway_deployment" {
  rest_api_id = aws_api_gateway_rest_api.create_rest_api.id

  triggers = {
    redeployment = sha1(jsonencode([
      aws_api_gateway_resource.C3_Reservations_api_gateway_resource.id,
      aws_api_gateway_method.C3_Reservations_api_gateway_method.id,
      aws_api_gateway_integration.C3_Reservations_api_gateway_integration.id,
      aws_api_gateway_authorizer.C3_Reservations_auth.id,
      aws_api_gateway_gateway_response.C3_Reservations_api_gateway_respone.id,
      aws_cloudwatch_log_group.C3_Reservations,
      // aws_api_gateway_rest_api_policy.ResourcePolicy.id


    ]))
  }

  lifecycle {
    create_before_destroy = true
  }

}

resource "aws_api_gateway_method_settings" "C3_Reservations_settings" {
  rest_api_id = aws_api_gateway_rest_api.create_rest_api.id
  stage_name  = var.env
  method_path = "*/*"

  depends_on = [
    aws_api_gateway_stage.C3_Reservations_api_stage
  ]
  settings {
    metrics_enabled    = var.C3_Reservations_metrics_enable_flag
    logging_level      = var.C3_Reservations_logging_level
    data_trace_enabled = false

  }
}
resource "aws_cloudwatch_log_group" "C3_Reservations" {
  name              = "C3_Reservations/${var.env}"
  retention_in_days = var.log_retention_days

}

resource "aws_api_gateway_stage" "C3_Reservations_api_stage" {
  deployment_id = aws_api_gateway_deployment.C3_Reservations_api_gateway_deployment.id
  rest_api_id   = aws_api_gateway_rest_api.create_rest_api.id
  stage_name    = var.env
  variables = {
    server = "api.${var.env}.iprm.js-devops.co.uk"
    port   = "17100"
  }
  access_log_settings {
    destination_arn = aws_cloudwatch_log_group.C3_Reservations.arn
    format          = jsonencode({ "requestId" : "$context.requestId", "ip" : "$context.identity.sourceIp", "caller" : "$context.identity.caller", "user" : "$context.identity.user", "requestTime" : "$context.requestTime", "httpMethod" : "$context.httpMethod", "resourcePath" : "$context.resourcePath", "status" : "$context.status", "protocol" : "$context.protocol", "responseLength" : "$context.responseLength" })
  }

}


resource "aws_lambda_permission" "C3_ReservationsLamdaPermissions" {
  statement_id  = local.C3_Reservations_lambda_permission_statement_id
  action        = "lambda:InvokeFunction"
  function_name = var.C3_Reservations_lamda_function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.create_rest_api.execution_arn}/authorizers/${aws_api_gateway_authorizer.C3_Reservations_auth.id}"
}


resource "aws_api_gateway_base_path_mapping" "apigatewaygenericscriptBasepath" {
  api_id      = aws_api_gateway_rest_api.create_rest_api.id
  stage_name  = aws_api_gateway_stage.C3_Reservations_api_stage.stage_name
  domain_name = "api.${var.env}.iprm.js-devops.co.uk"
  base_path   = var.C3_Reservations_api_mapping_path
}

resource "aws_api_gateway_gateway_response" "C3_Reservations_api_gateway_respone" {
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
resource "aws_cloudwatch_log_subscription_filter" "cw_log_filter" {
  name            = "C3_Reservations/${var.env}"
  log_group_name  = "API-Gateway-Execution-Logs_${aws_api_gateway_rest_api.create_rest_api.id}/${var.env}"
  filter_pattern  = ""
  destination_arn = data.aws_lambda_function.ingestion_function.arn
  distribution    = "ByLogStream"
}