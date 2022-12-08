resource "aws_api_gateway_rest_api" "pega_updateCustomer" {
  name        = var.pega_updateCustomer_api_name
  description = var.pega_updateCustomer_api_description
  endpoint_configuration {

    types = ["REGIONAL"]

  }
}

locals {
  lambda_permission_statement_id = "Allow_Invoke_pega_updateCustomer_${var.env}"
}
resource "aws_api_gateway_resource" "pega_updateCustomer_api_gateway_resource" {
  path_part   = var.pega_updateCustomer_api_path_part
  parent_id   = aws_api_gateway_rest_api.pega_updateCustomer.root_resource_id
  rest_api_id = aws_api_gateway_rest_api.pega_updateCustomer.id
}

resource "aws_api_gateway_method" "pega_updateCustomer_api_gateway_method" {
  rest_api_id   = aws_api_gateway_rest_api.pega_updateCustomer.id
  resource_id   = aws_api_gateway_resource.pega_updateCustomer_api_gateway_resource.id
  http_method   = "POST"
  authorization = var.pega_updateCustomer_auth_type
  authorizer_id = aws_api_gateway_authorizer.pega_updateCustomer_apigatewaygenericscriptauth.id
  request_parameters = {
    "method.request.header.Accept"       = true
    "method.request.header.Content-Type" = true
  }
}

resource "aws_api_gateway_authorizer" "pega_updateCustomer_apigatewaygenericscriptauth" {
  name            = "CustomAuthoriser"
  rest_api_id     = aws_api_gateway_rest_api.pega_updateCustomer.id
  authorizer_uri  = var.lambda_authorizer_arn
  identity_source = "method.request.header.Authorization"
  type            = "REQUEST"

}
resource "aws_api_gateway_integration" "pega_updateCustomer_api_gateway_integration" {
  rest_api_id             = aws_api_gateway_rest_api.pega_updateCustomer.id
  resource_id             = aws_api_gateway_resource.pega_updateCustomer_api_gateway_resource.id
  integration_http_method = aws_api_gateway_method.pega_updateCustomer_api_gateway_method.http_method
  type                    = var.pega_updateCustomer_integration_type
  http_method             = aws_api_gateway_method.pega_updateCustomer_api_gateway_method.http_method
  connection_type         = var.pega_updateCustomer_connection_type
  connection_id           = var.api_vpc_link_id
  uri                     = var.pega_updateCustomer_uri
  request_parameters = {
    "integration.request.header.Accept"       = "method.request.header.Accept"
    "integration.request.header.Content-Type" = "method.request.header.Content-Type"
  }
}

resource "aws_api_gateway_method_response" "pega_updateCustomer_responses" {
  rest_api_id = aws_api_gateway_rest_api.pega_updateCustomer.id
  resource_id = aws_api_gateway_resource.pega_updateCustomer_api_gateway_resource.id
  http_method = aws_api_gateway_method.pega_updateCustomer_api_gateway_method.http_method
  status_code = "200"
}

resource "aws_api_gateway_integration_response" "pega_updateCustomer_integration_response" {
  rest_api_id = aws_api_gateway_rest_api.pega_updateCustomer.id
  resource_id = aws_api_gateway_resource.pega_updateCustomer_api_gateway_resource.id
  http_method = var.pega_updateCustomer_api_method
  status_code = aws_api_gateway_method_response.pega_updateCustomer_responses.status_code
  depends_on = [
    aws_api_gateway_integration.pega_updateCustomer_api_gateway_integration
  ]
}
resource "aws_api_gateway_deployment" "pega_updateCustomer_api_gateway_deployment" {
  rest_api_id = aws_api_gateway_rest_api.pega_updateCustomer.id

  triggers = {
    redeployment = sha1(jsonencode([
      aws_api_gateway_resource.pega_updateCustomer_api_gateway_resource.id,
      aws_api_gateway_method.pega_updateCustomer_api_gateway_method.id,
      aws_api_gateway_integration.pega_updateCustomer_api_gateway_integration.id,
      aws_api_gateway_gateway_response.pega_updateCustomer_api_gateway_respone,
      //aws_api_gateway_rest_api_policy.ResourcePolicy.id,
      aws_cloudwatch_log_group.pega_updateCustomer
    ]))
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_cloudwatch_log_group" "pega_updateCustomer" {
  name              = "pega_updateCustomer/${var.env}"
  retention_in_days = var.log_retention_days

}

resource "aws_api_gateway_method_settings" "pega_updateCustomer_settings" {
  rest_api_id = aws_api_gateway_rest_api.pega_updateCustomer.id
  stage_name  = var.env
  method_path = "*/*"

  depends_on = [
    aws_api_gateway_stage.pega_updateCustomer_api_stage
  ]

  settings {
    metrics_enabled    = var.pega_updateCustomer_metrics_enabled_flag
    logging_level      = var.pega_updateCustomer_logging_level
    data_trace_enabled = false

  }
}

resource "aws_api_gateway_stage" "pega_updateCustomer_api_stage" {
  deployment_id = aws_api_gateway_deployment.pega_updateCustomer_api_gateway_deployment.id
  rest_api_id   = aws_api_gateway_rest_api.pega_updateCustomer.id
  stage_name    = var.env
  variables = {

    server = "api.${var.env}.iprm.js-devops.co.uk"
    port   = "17100"
  }
  access_log_settings {
    destination_arn = aws_cloudwatch_log_group.pega_updateCustomer.arn
    format          = jsonencode({ "requestId" : "$context.requestId", "ip" : "$context.identity.sourceIp", "caller" : "$context.identity.caller", "user" : "$context.identity.user", "requestTime" : "$context.requestTime", "httpMethod" : "$context.httpMethod", "resourcePath" : "$context.resourcePath", "status" : "$context.status", "protocol" : "$context.protocol", "responseLength" : "$context.responseLength" })
  }
}

resource "aws_lambda_permission" "pega_updateCustomer_LamdaPermissions" {
  statement_id_prefix = local.lambda_permission_statement_id
  action              = "lambda:InvokeFunction"
  function_name       = var.lamda_function_name

  principal  = "apigateway.amazonaws.com"
  source_arn = "${aws_api_gateway_rest_api.pega_updateCustomer.execution_arn}/authorizers/${aws_api_gateway_authorizer.pega_updateCustomer_apigatewaygenericscriptauth.id}"
  lifecycle {
    create_before_destroy = true
  }
}

/*resource "aws_api_gateway_rest_api_policy" "ResourcePolicy" {
  rest_api_id = aws_api_gateway_rest_api.pega_updateCustomer.id

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
                  "${aws_api_gateway_rest_api.pega_updateCustomer.execution_arn}/*"
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
                  "${aws_api_gateway_rest_api.pega_updateCustomer.execution_arn}/*"
                  ]
        }
    ]
}
EOF
}*/
resource "aws_api_gateway_base_path_mapping" "pega_updateCustomer_Basepath" {
  api_id      = aws_api_gateway_rest_api.pega_updateCustomer.id
  stage_name  = aws_api_gateway_stage.pega_updateCustomer_api_stage.stage_name
  domain_name = "api.${var.env}.iprm.js-devops.co.uk"
  base_path   = var.pega_updateCustomer_api_mapping_part
}
resource "aws_api_gateway_gateway_response" "pega_updateCustomer_api_gateway_respone" {
  rest_api_id   = aws_api_gateway_rest_api.pega_updateCustomer.id
  status_code   = "401"
  response_type = "UNAUTHORIZED"

  response_templates = {
    "application/json" = "{\"message\":Access Denied.Incorrect password or username.Please check with Integration webMethods Team}"
  }

  response_parameters = {
    "gatewayresponse.header.Authorization" = "'Basic'"
  }
}