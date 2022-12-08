resource "aws_api_gateway_rest_api" "incidentMgmt_Telephonica" {
  name        = var.incidentMgmt_Telephonica_api_name
  description = var.incidentMgmt_Telephonica_api_description
  endpoint_configuration {

    types = ["REGIONAL"]

  }
}
locals {
  Telefonica_lambda_permission_statement_id = "Allow_Invoke_incidentMgmt_Telephonica_${var.env}"
}

resource "aws_api_gateway_resource" "incidentMgmt_Telephonica_api_gateway_resource" {
  path_part   = var.incidentMgmt_Telephonica_api_path_part
  parent_id   = aws_api_gateway_rest_api.incidentMgmt_Telephonica.root_resource_id
  rest_api_id = aws_api_gateway_rest_api.incidentMgmt_Telephonica.id
}
resource "aws_api_gateway_method" "incidentMgmt_Telephonica_api_gateway_method_POST" {
  rest_api_id   = aws_api_gateway_rest_api.incidentMgmt_Telephonica.id
  resource_id   = aws_api_gateway_resource.incidentMgmt_Telephonica_api_gateway_resource.id
  http_method   = var.incidentMgmt_Telephonica_api_method1
  authorization = "CUSTOM"
  authorizer_id = aws_api_gateway_authorizer.Telefonica_auth.id
  request_parameters = {
    "method.request.header.Accept"       = true
    "method.request.header.Content-Type" = true
  }
}

resource "aws_api_gateway_authorizer" "Telefonica_auth" {
  name            = "CustomAuthoriser"
  rest_api_id     = aws_api_gateway_rest_api.incidentMgmt_Telephonica.id
  authorizer_uri  = var.telefonica_lambda_authorizer_arn
  identity_source = "method.request.header.Authorization"
  type            = "REQUEST"

}

resource "aws_api_gateway_method" "incidentMgmt_Telephonica_api_gateway_method_PUT" {
  rest_api_id   = aws_api_gateway_rest_api.incidentMgmt_Telephonica.id
  resource_id   = aws_api_gateway_resource.incidentMgmt_Telephonica_api_gateway_resource.id
  http_method   = var.incidentMgmt_Telephonica_api_method2
  authorization = "CUSTOM"
  authorizer_id = aws_api_gateway_authorizer.Telefonica_auth.id
  request_parameters = {
    "method.request.header.Accept"       = true
    "method.request.header.Content-Type" = true
  }
}
/*comment added to redeploy*/
resource "aws_api_gateway_integration" "incidentMgmt_Telephonica_Integration_POST" {
  rest_api_id = aws_api_gateway_rest_api.incidentMgmt_Telephonica.id
  resource_id = aws_api_gateway_resource.incidentMgmt_Telephonica_api_gateway_resource.id

  integration_http_method = aws_api_gateway_method.incidentMgmt_Telephonica_api_gateway_method_POST.http_method

  type            = var.incidentMgmt_Telephonica_integration_type
  http_method     = var.incidentMgmt_Telephonica_api_method1
  connection_type = var.incidentMgmt_Telephonica_connection_type
  connection_id   = var.api_vpc_link_id
  uri             = var.incidentMgmt_Telephonica_POST_uri
  request_parameters = {
    "integration.request.header.Accept"       = "method.request.header.Accept"
    "integration.request.header.Content-Type" = "method.request.header.Content-Type"
  }
  depends_on = [
    aws_api_gateway_method.incidentMgmt_Telephonica_api_gateway_method_POST
  ]
}
resource "aws_api_gateway_integration" "incidentMgmt_Telephonica_Integration_PUT" {
  rest_api_id = aws_api_gateway_rest_api.incidentMgmt_Telephonica.id
  resource_id = aws_api_gateway_resource.incidentMgmt_Telephonica_api_gateway_resource.id

  integration_http_method = aws_api_gateway_method.incidentMgmt_Telephonica_api_gateway_method_PUT.http_method

  type            = var.incidentMgmt_Telephonica_integration_type
  http_method     = var.incidentMgmt_Telephonica_api_method2
  connection_type = var.incidentMgmt_Telephonica_connection_type
  connection_id   = var.api_vpc_link_id
  uri             = var.incidentMgmt_Telephonica_PUT_uri
  request_parameters = {
    "integration.request.header.Accept"       = "method.request.header.Accept"
    "integration.request.header.Content-Type" = "method.request.header.Content-Type"
  }
  depends_on = [
  aws_api_gateway_method.incidentMgmt_Telephonica_api_gateway_method_PUT]
}
resource "aws_api_gateway_method_response" "incidentMgmt_Telephonica_MethodResponse_POST" {
  rest_api_id = aws_api_gateway_rest_api.incidentMgmt_Telephonica.id
  resource_id = aws_api_gateway_resource.incidentMgmt_Telephonica_api_gateway_resource.id

  http_method = aws_api_gateway_method.incidentMgmt_Telephonica_api_gateway_method_POST.http_method

  status_code = var.incidentMgmt_Telephonica_status_code
}
resource "aws_api_gateway_method_response" "incidentMgmt_Telephonica_MethodResponse_PUT" {
  rest_api_id = aws_api_gateway_rest_api.incidentMgmt_Telephonica.id
  resource_id = aws_api_gateway_resource.incidentMgmt_Telephonica_api_gateway_resource.id

  http_method = aws_api_gateway_method.incidentMgmt_Telephonica_api_gateway_method_PUT.http_method

  status_code = var.incidentMgmt_Telephonica_status_code
}
resource "aws_api_gateway_integration_response" "apigatewaygenericscript_IntegrationResponse_POST" {
  rest_api_id = aws_api_gateway_rest_api.incidentMgmt_Telephonica.id
  resource_id = aws_api_gateway_resource.incidentMgmt_Telephonica_api_gateway_resource.id
  http_method = var.incidentMgmt_Telephonica_api_method1
  status_code = var.incidentMgmt_Telephonica_status_code
  depends_on = [
    aws_api_gateway_integration.incidentMgmt_Telephonica_Integration_POST
  ]
}
resource "aws_api_gateway_integration_response" "apigatewaygenericscript_IntegrationResponse_PUT" {
  rest_api_id = aws_api_gateway_rest_api.incidentMgmt_Telephonica.id
  resource_id = aws_api_gateway_resource.incidentMgmt_Telephonica_api_gateway_resource.id
  http_method = var.incidentMgmt_Telephonica_api_method2
  status_code = var.incidentMgmt_Telephonica_status_code
  depends_on = [
    aws_api_gateway_integration.incidentMgmt_Telephonica_Integration_PUT
  ]
}
resource "aws_api_gateway_deployment" "incidentMgmt_Telephonica" {
  rest_api_id = aws_api_gateway_rest_api.incidentMgmt_Telephonica.id

  triggers = {
    redeployment = sha1(jsonencode([
      aws_api_gateway_resource.incidentMgmt_Telephonica_api_gateway_resource,
      aws_api_gateway_method.incidentMgmt_Telephonica_api_gateway_method_POST,
      aws_api_gateway_method.incidentMgmt_Telephonica_api_gateway_method_PUT,
      aws_api_gateway_integration.incidentMgmt_Telephonica_Integration_POST,
      aws_api_gateway_integration.incidentMgmt_Telephonica_Integration_PUT,
      aws_api_gateway_authorizer.Telefonica_auth,
      aws_api_gateway_gateway_response.Telephonica_api_gateway_respone,
      //aws_api_gateway_rest_api_policy.Telephonica_api_resource_policy.id,
      aws_cloudwatch_log_group.Telephonica_V01
    ]))
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_cloudwatch_log_group" "Telephonica_V01" {
  name              = "Telephonica/${var.env}"
  retention_in_days = var.log_retention_days

}
resource "aws_api_gateway_stage" "incidentMgmt_Telephonica" {
  deployment_id = aws_api_gateway_deployment.incidentMgmt_Telephonica.id
  rest_api_id   = aws_api_gateway_rest_api.incidentMgmt_Telephonica.id
  stage_name    = var.env
  variables = {
    server = "api.${var.env}.iprm.js-devops.co.uk"
    port   = "17003"
  }
  access_log_settings {
    destination_arn = aws_cloudwatch_log_group.Telephonica_V01.arn
    format          = jsonencode({ "requestId" : "$context.requestId", "ip" : "$context.identity.sourceIp", "caller" : "$context.identity.caller", "user" : "$context.identity.user", "requestTime" : "$context.requestTime", "httpMethod" : "$context.httpMethod", "resourcePath" : "$context.resourcePath", "status" : "$context.status", "protocol" : "$context.protocol", "responseLength" : "$context.responseLength" })
  }
  depends_on = [
    aws_api_gateway_deployment.incidentMgmt_Telephonica
  ]
}
resource "aws_api_gateway_base_path_mapping" "apigatewaygenericscriptBasepath" {
  api_id      = aws_api_gateway_rest_api.incidentMgmt_Telephonica.id
  stage_name  = aws_api_gateway_stage.incidentMgmt_Telephonica.stage_name
  domain_name = "api.${var.env}.iprm.js-devops.co.uk"
  base_path   = var.telephonica_api_mapping_part
}

resource "aws_lambda_permission" "Telefonica_IncidentMGMTLamdaPermissions" {
  statement_id_prefix = local.Telefonica_lambda_permission_statement_id
  action              = "lambda:InvokeFunction"
  function_name       = var.telefonica_lamda_function_name
  principal           = "apigateway.amazonaws.com"
  source_arn          = "${aws_api_gateway_rest_api.incidentMgmt_Telephonica.execution_arn}/authorizers/${aws_api_gateway_authorizer.Telefonica_auth.id}"

  lifecycle {
    create_before_destroy = true
  }

}

resource "aws_api_gateway_gateway_response" "Telephonica_api_gateway_respone" {
  rest_api_id   = aws_api_gateway_rest_api.incidentMgmt_Telephonica.id
  status_code   = "401"
  response_type = "UNAUTHORIZED"

  response_templates = {
    "application/json" = "{\"message\":Access Denied.Incorrect password or userid.Please check with Integration webMethods Team}"
  }

  response_parameters = {
    "gatewayresponse.header.Authorization" = "'Basic'"
  }
}

/* resource "aws_api_gateway_rest_api_policy" "Telephonica_api_resource_policy" {
  rest_api_id = aws_api_gateway_rest_api.incidentMgmt_Telephonica.id

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
         {
            "Effect": "Allow",
            "Principal": "*",
            "Action": "execute-api:Invoke",
            "Resource": "${aws_api_gateway_rest_api.incidentMgmt_Telephonica.execution_arn}/*"
        },        
        {
            "Effect": "Deny",
            "Principal": "*",
            "Action": "execute-api:Invoke",
            "Resource": "${aws_api_gateway_rest_api.incidentMgmt_Telephonica.execution_arn}/*",
            "Condition": {
                "NotIpAddress": {
                    "aws:SourceIp":  ${jsonencode(concat(var.telephonica_allowedipaddresses))}
                }
            }
        }
       
    ]
}
EOF

} */


resource "aws_api_gateway_method_settings" "Telephonica_settings" {
  rest_api_id = aws_api_gateway_rest_api.incidentMgmt_Telephonica.id
  stage_name  = var.env
  method_path = "*/*"

  settings {
    metrics_enabled    = var.incidentMgmt_Telephonica_metrics_enabled_flag
    logging_level      = var.incidentMgmt_Telephonica_logging_level
    data_trace_enabled = true

  }
}
