resource "aws_api_gateway_rest_api" "pega_searchCustomer" {
  name        = var.pega_searchCustomer_api_name
  description = var.pega_searchCustomer_api_description
  endpoint_configuration {

    types = ["REGIONAL"]

  }
}

locals {
  lambda_permission_statement_id = "Allow_Invoke_Pega_searchCustomer_${var.env}"
}
resource "aws_api_gateway_resource" "pega_searchCustomer_api_gateway_resource" {
  path_part   = var.pega_searchCustomer_api_path_part
  parent_id   = aws_api_gateway_rest_api.pega_searchCustomer.root_resource_id
  rest_api_id = aws_api_gateway_rest_api.pega_searchCustomer.id
}

resource "aws_api_gateway_method" "pega_searchCustomer_api_gateway_method" {
  rest_api_id   = aws_api_gateway_rest_api.pega_searchCustomer.id
  resource_id   = aws_api_gateway_resource.pega_searchCustomer_api_gateway_resource.id
  http_method   = "POST"
  authorization = var.pega_searchCustomer_auth_type
  authorizer_id = aws_api_gateway_authorizer.pega_searchCustomer_apigatewaygenericscriptauth.id
  request_parameters = {
    "method.request.header.Accept"       = true
    "method.request.header.Content-Type" = true
  }
}

/*resource "aws_api_gateway_rest_api_policy" "ResourcePolicy" {
  rest_api_id = aws_api_gateway_rest_api.pega_searchCustomer.id

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
                  "${aws_api_gateway_rest_api.pega_searchCustomer.execution_arn}/*"
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
                  "${aws_api_gateway_rest_api.pega_searchCustomer.execution_arn}/*"
                  ]
        }
    ]
}
EOF
}*/

resource "aws_api_gateway_authorizer" "pega_searchCustomer_apigatewaygenericscriptauth" {
  name            = "CustomAuthoriser"
  rest_api_id     = aws_api_gateway_rest_api.pega_searchCustomer.id
  authorizer_uri  = var.lambda_authorizer_arn
  identity_source = "method.request.header.Authorization"
  type            = "REQUEST"

}
resource "aws_api_gateway_integration" "pega_searchCustomer_api_gateway_integration" {
  rest_api_id             = aws_api_gateway_rest_api.pega_searchCustomer.id
  resource_id             = aws_api_gateway_resource.pega_searchCustomer_api_gateway_resource.id
  integration_http_method = aws_api_gateway_method.pega_searchCustomer_api_gateway_method.http_method
  type                    = var.pega_searchCustomer_integration_type
  http_method             = aws_api_gateway_method.pega_searchCustomer_api_gateway_method.http_method
  connection_type         = var.pega_searchCustomer_connection_type
  connection_id           = var.api_vpc_link_id
  uri                     = var.pega_searchCustomer_uri
  request_parameters = {
    "integration.request.header.Accept"       = "method.request.header.Accept"
    "integration.request.header.Content-Type" = "method.request.header.Content-Type"
  }
}

resource "aws_api_gateway_method_response" "pega_searchCustomer_responses" {
  rest_api_id = aws_api_gateway_rest_api.pega_searchCustomer.id
  resource_id = aws_api_gateway_resource.pega_searchCustomer_api_gateway_resource.id
  http_method = aws_api_gateway_method.pega_searchCustomer_api_gateway_method.http_method
  status_code = "200"
}

resource "aws_api_gateway_integration_response" "pega_searchCustomer_integration_response" {
  rest_api_id = aws_api_gateway_rest_api.pega_searchCustomer.id
  resource_id = aws_api_gateway_resource.pega_searchCustomer_api_gateway_resource.id
  http_method = var.pega_searchCustomer_api_method
  status_code = aws_api_gateway_method_response.pega_searchCustomer_responses.status_code
  depends_on = [
    aws_api_gateway_integration.pega_searchCustomer_api_gateway_integration
  ]
}
resource "aws_api_gateway_deployment" "pega_searchCustomer_api_gateway_deployment" {
  rest_api_id = aws_api_gateway_rest_api.pega_searchCustomer.id

  triggers = {
    redeployment = sha1(jsonencode([
      aws_api_gateway_resource.pega_searchCustomer_api_gateway_resource.id,
      aws_api_gateway_method.pega_searchCustomer_api_gateway_method.id,
      aws_api_gateway_integration.pega_searchCustomer_api_gateway_integration.id,
      //aws_api_gateway_rest_api_policy.ResourcePolicy.id,
      aws_cloudwatch_log_group.pega_searchCustomer
    ]))
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_cloudwatch_log_group" "pega_searchCustomer" {
  name              = "pega_searchCustomer/${var.env}"
  retention_in_days = var.log_retention_days

}

resource "aws_api_gateway_method_settings" "pega_searchCustomer_settings" {
  rest_api_id = aws_api_gateway_rest_api.pega_searchCustomer.id
  stage_name  = var.env
  method_path = "*/*"

  depends_on = [
    aws_api_gateway_stage.pega_searchCustomer_api_stage
  ]

  settings {
    metrics_enabled    = var.pega_searchCustomer_metrics_enabled_flag
    logging_level      = var.pega_searchCustomer_logging_level
    data_trace_enabled = false

  }
}
resource "aws_api_gateway_stage" "pega_searchCustomer_api_stage" {
  deployment_id = aws_api_gateway_deployment.pega_searchCustomer_api_gateway_deployment.id
  rest_api_id   = aws_api_gateway_rest_api.pega_searchCustomer.id
  stage_name    = var.env
  variables = {

    server = "api.${var.env}.iprm.js-devops.co.uk"
    port   = "17100"
  }
  access_log_settings {
    destination_arn = aws_cloudwatch_log_group.pega_searchCustomer.arn
    format          = jsonencode({ "requestId" : "$context.requestId", "ip" : "$context.identity.sourceIp", "caller" : "$context.identity.caller", "user" : "$context.identity.user", "requestTime" : "$context.requestTime", "httpMethod" : "$context.httpMethod", "resourcePath" : "$context.resourcePath", "status" : "$context.status", "protocol" : "$context.protocol", "responseLength" : "$context.responseLength" })
  }
}

resource "aws_lambda_permission" "pega_searchCustomer_LamdaPermissions" {
  statement_id_prefix = local.lambda_permission_statement_id
  action              = "lambda:InvokeFunction"
  function_name       = var.lamda_function_name

  principal  = "apigateway.amazonaws.com"
  source_arn = "${aws_api_gateway_rest_api.pega_searchCustomer.execution_arn}/authorizers/${aws_api_gateway_authorizer.pega_searchCustomer_apigatewaygenericscriptauth.id}"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_api_gateway_base_path_mapping" "pega_searchCustomer_Basepath" {
  api_id      = aws_api_gateway_rest_api.pega_searchCustomer.id
  stage_name  = aws_api_gateway_stage.pega_searchCustomer_api_stage.stage_name
  domain_name = "api.${var.env}.iprm.js-devops.co.uk"
  base_path   = var.pega_searchCustomer_api_mapping_part
}