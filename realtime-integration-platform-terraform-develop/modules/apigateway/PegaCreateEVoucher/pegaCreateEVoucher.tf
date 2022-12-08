resource "aws_api_gateway_rest_api" "createEVoucher" {
  name        = var.pegaEVoucher_api_name
  description = "API created for 9.12 pega createEVoucher functionality"
  endpoint_configuration {
    types = ["REGIONAL"]
  }
}

locals {
  lambda_permission_statement_id = "Allow_My_Post_Session_Invoke_Pega_CreateEVoucher_${var.env}"
}
resource "aws_api_gateway_resource" "createEVoucherResource" {
  path_part   = var.pegaEVoucher_api_path_part
  parent_id   = aws_api_gateway_rest_api.createEVoucher.root_resource_id
  rest_api_id = aws_api_gateway_rest_api.createEVoucher.id
}
resource "aws_api_gateway_method" "createEVoucherMethod" {
  rest_api_id   = aws_api_gateway_rest_api.createEVoucher.id
  resource_id   = aws_api_gateway_resource.createEVoucherResource.id
  http_method   = var.pegaEVoucher_api_method
  authorization = var.pegaEVoucher_auth_type
  authorizer_id = aws_api_gateway_authorizer.apigatewaygenericscriptauth.id
  request_parameters = {
    "method.request.header.Accept"       = true
    "method.request.header.Content-Type" = true
  }
}

#Replaced by AWS WAF ACL
/*
resource "aws_api_gateway_rest_api_policy" "Resource_policy" {
  rest_api_id = aws_api_gateway_rest_api.createEVoucher.id

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
                  "${aws_api_gateway_rest_api.createEVoucher.execution_arn}/*"
                  ],
            "Condition": {
                "StringNotEquals": {
                    "aws:SourceIp":  ${jsonencode(concat(var.pega_IP))}
                }
            }
        },
        {
            "Effect": "Allow",
            "Principal": "*",
            "Action": "execute-api:Invoke",
            "Resource": [
                  "${aws_api_gateway_rest_api.createEVoucher.execution_arn}/*"
                  ]
        }
    ]
}
EOF

} */

resource "aws_api_gateway_authorizer" "apigatewaygenericscriptauth" {
  name            = "CustomAuthoriser"
  rest_api_id     = aws_api_gateway_rest_api.createEVoucher.id
  authorizer_uri  = var.lambda_authorizer_arn
  identity_source = "method.request.header.Authorization"
  type            = "REQUEST"

}
resource "aws_api_gateway_integration" "createEVoucherIntegration" {
  rest_api_id             = aws_api_gateway_rest_api.createEVoucher.id
  resource_id             = aws_api_gateway_resource.createEVoucherResource.id
  integration_http_method = aws_api_gateway_method.createEVoucherMethod.http_method
  type                    = var.pegaEVoucher_integration_type
  http_method             = aws_api_gateway_method.createEVoucherMethod.http_method
  connection_type         = var.pegaEVoucher_connection_type
  connection_id           = var.api_vpc_link_id
  uri                     = "https://$${stageVariables.server}:$${stageVariables.port}/ws/Js_B2B_CustomerMgmt_Customer.provider:createEVoucher/Js_B2B_CustomerMgmt_Customer_provider_createEVoucher_Port"
  request_parameters = {
    "integration.request.header.Accept"       = "method.request.header.Accept"
    "integration.request.header.Content-Type" = "method.request.header.Content-Type"
  }
}
resource "aws_api_gateway_method_response" "createEVoucherMethodResponse" {
  rest_api_id = aws_api_gateway_rest_api.createEVoucher.id
  resource_id = aws_api_gateway_resource.createEVoucherResource.id
  http_method = aws_api_gateway_method.createEVoucherMethod.http_method
  status_code = var.pegaEVoucher_status_code
}

resource "aws_api_gateway_integration_response" "apigatewaygenericscript_IntegrationResponse" {
  rest_api_id = aws_api_gateway_rest_api.createEVoucher.id
  resource_id = aws_api_gateway_resource.createEVoucherResource.id
  http_method = var.pegaEVoucher_api_method
  status_code = aws_api_gateway_method_response.createEVoucherMethodResponse.status_code
  depends_on = [
    aws_api_gateway_integration.createEVoucherIntegration
  ]
}

resource "aws_api_gateway_gateway_response" "apigatewaygenericscript_GatewayResponse" {
  rest_api_id   = aws_api_gateway_rest_api.createEVoucher.id
  status_code   = var.pegaEVoucher_gatewayResponse
  response_type = var.pegaEVoucher_responseType

  response_templates = {
    "application/json" = "{\"message\":Access Denied.Incorrect password or username.Please check with Integration webMethods Team}"
  }
  response_parameters = {
    "gatewayresponse.header.WWW-Authenticate" = "'Basic'"
  }
}

resource "aws_api_gateway_deployment" "createEVoucher" {
  rest_api_id = aws_api_gateway_rest_api.createEVoucher.id

  triggers = {
    redeployment = sha1(jsonencode([
      aws_api_gateway_resource.createEVoucherResource.id,
      aws_api_gateway_method.createEVoucherMethod.id,
      aws_api_gateway_integration.createEVoucherIntegration.id,
      /*aws_api_gateway_rest_api_policy.ResourcePolicy.id,*/
      aws_cloudwatch_log_group.pega_CreateEVoucher
    ]))
  }

  lifecycle {
    create_before_destroy = true
  }
}
resource "aws_cloudwatch_log_group" "pega_CreateEVoucher" {
  name              = "pega_CreateEVoucher/${var.env}"
  retention_in_days = var.log_retention_days

}

resource "aws_api_gateway_method_settings" "pega_CreateEVoucher_settings" {
  rest_api_id = aws_api_gateway_rest_api.createEVoucher.id
  stage_name  = var.env
  method_path = "*/*"

  depends_on = [
    aws_api_gateway_stage.createEVoucher
  ]
  settings {
    metrics_enabled    = var.pegaEVoucher_api_metrics_enabled_flag
    logging_level      = var.pegaEVoucher_api_logging_level
    data_trace_enabled = false

  }
}

resource "aws_api_gateway_stage" "createEVoucher" {
  deployment_id = aws_api_gateway_deployment.createEVoucher.id
  rest_api_id   = aws_api_gateway_rest_api.createEVoucher.id
  stage_name    = var.env
  variables = {
    server = "api.${var.env}.iprm.js-devops.co.uk"
    port   = "17100"
  }
  access_log_settings {
    destination_arn = aws_cloudwatch_log_group.pega_CreateEVoucher.arn
    format          = jsonencode({ "requestId" : "$context.requestId", "ip" : "$context.identity.sourceIp", "caller" : "$context.identity.caller", "user" : "$context.identity.user", "requestTime" : "$context.requestTime", "httpMethod" : "$context.httpMethod", "resourcePath" : "$context.resourcePath", "status" : "$context.status", "protocol" : "$context.protocol", "responseLength" : "$context.responseLength" })
  }
}

resource "aws_lambda_permission" "pega_CreateEVoucherLamdaPermissions" {
  statement_id_prefix = local.lambda_permission_statement_id
  action              = "lambda:InvokeFunction"
  function_name       = var.lamda_function_name

  principal  = "apigateway.amazonaws.com"
  source_arn = "${aws_api_gateway_rest_api.createEVoucher.execution_arn}/authorizers/${aws_api_gateway_authorizer.apigatewaygenericscriptauth.id}"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_api_gateway_base_path_mapping" "apigatewaygenericscriptBasepath" {
  api_id      = aws_api_gateway_rest_api.createEVoucher.id
  stage_name  = aws_api_gateway_stage.createEVoucher.stage_name
  domain_name = "api.${var.env}.iprm.js-devops.co.uk"
  base_path   = var.pegaEVoucher_api_mapping_path_part
}