resource "aws_api_gateway_rest_api" "FIS_incidentmanagement" {
  name        = var.FIS_incidentmanagement_api_name
  description = var.FIS_incidentmanagement_api_description
  endpoint_configuration {

    types = ["REGIONAL"]

  }
}
locals {
  FIS_lambda_permission_statement_id = "Allow_Invoke_FIS_incidentmanagement_${var.env}"
}

resource "aws_api_gateway_resource" "FIS_incidentmanagement_api_gateway_resource_save" {
  path_part   = var.FIS_incidentmanagement_api_path_part_save
  parent_id   = aws_api_gateway_rest_api.FIS_incidentmanagement.root_resource_id
  rest_api_id = aws_api_gateway_rest_api.FIS_incidentmanagement.id
}

resource "aws_api_gateway_resource" "FIS_incidentmanagement_api_gateway_resource_submit" {
  path_part   = var.FIS_incidentmanagement_api_path_part_submit
  parent_id   = aws_api_gateway_rest_api.FIS_incidentmanagement.root_resource_id
  rest_api_id = aws_api_gateway_rest_api.FIS_incidentmanagement.id
}

resource "aws_api_gateway_resource" "FIS_incidentmanagement_api_gateway_resource_update" {
  path_part   = var.FIS_incidentmanagement_api_path_part_update
  parent_id   = aws_api_gateway_rest_api.FIS_incidentmanagement.root_resource_id
  rest_api_id = aws_api_gateway_rest_api.FIS_incidentmanagement.id
}

resource "aws_api_gateway_method" "FIS_incidentmanagement_api_gateway_method_save" {
  rest_api_id   = aws_api_gateway_rest_api.FIS_incidentmanagement.id
  resource_id   = aws_api_gateway_resource.FIS_incidentmanagement_api_gateway_resource_save.id
  http_method   = var.FIS_incidentmanagement_api_method
  authorization = "CUSTOM"
  authorizer_id = aws_api_gateway_authorizer.FIS_auth.id
  request_parameters = {
    "method.request.header.Accept"       = true
    "method.request.header.Content-Type" = true
  }
}

resource "aws_api_gateway_authorizer" "FIS_auth" {
  name            = "CustomAuthoriser"
  rest_api_id     = aws_api_gateway_rest_api.FIS_incidentmanagement.id
  authorizer_uri  = var.FIS_lambda_authorizer_arn
  identity_source = "method.request.header.Authorization"
  type            = "REQUEST"

}

resource "aws_api_gateway_method" "FIS_incidentmanagement_api_gateway_method_Submit" {
  rest_api_id   = aws_api_gateway_rest_api.FIS_incidentmanagement.id
  resource_id   = aws_api_gateway_resource.FIS_incidentmanagement_api_gateway_resource_submit.id
  http_method   = var.FIS_incidentmanagement_api_method
  authorization = "CUSTOM"
  authorizer_id = aws_api_gateway_authorizer.FIS_auth.id
  request_parameters = {
    "method.request.header.Accept"       = true
    "method.request.header.Content-Type" = true
  }
}

resource "aws_api_gateway_method" "FIS_incidentmanagement_api_gateway_method_update" {
  rest_api_id   = aws_api_gateway_rest_api.FIS_incidentmanagement.id
  resource_id   = aws_api_gateway_resource.FIS_incidentmanagement_api_gateway_resource_update.id
  http_method   = var.FIS_incidentmanagement_api_method
  authorization = "CUSTOM"
  authorizer_id = aws_api_gateway_authorizer.FIS_auth.id
  request_parameters = {
    "method.request.header.Accept"       = true
    "method.request.header.Content-Type" = true
  }
}
/*comment added to redeploy*/
resource "aws_api_gateway_integration" "FIS_incidentmanagement_Integration_save" {
  rest_api_id = aws_api_gateway_rest_api.FIS_incidentmanagement.id
  resource_id = aws_api_gateway_resource.FIS_incidentmanagement_api_gateway_resource_save.id

  integration_http_method = aws_api_gateway_method.FIS_incidentmanagement_api_gateway_method_save.http_method

  type            = var.FIS_incidentmanagement_integration_type
  http_method     = var.FIS_incidentmanagement_api_method
  connection_type = var.FIS_incidentmanagement_connection_type
  connection_id   = var.api_vpc_link_id
  uri             = var.FIS_incidentmanagement_save_uri
  request_parameters = {
    "integration.request.header.Accept"       = "method.request.header.Accept"
    "integration.request.header.Content-Type" = "method.request.header.Content-Type"
  }
  depends_on = [
    aws_api_gateway_method.FIS_incidentmanagement_api_gateway_method_save
  ]
}
resource "aws_api_gateway_integration" "FIS_incidentmanagement_Integration_submit" {
  rest_api_id = aws_api_gateway_rest_api.FIS_incidentmanagement.id
  resource_id = aws_api_gateway_resource.FIS_incidentmanagement_api_gateway_resource_submit.id

  integration_http_method = aws_api_gateway_method.FIS_incidentmanagement_api_gateway_method_Submit.http_method

  type            = var.FIS_incidentmanagement_integration_type
  http_method     = var.FIS_incidentmanagement_api_method
  connection_type = var.FIS_incidentmanagement_connection_type
  connection_id   = var.api_vpc_link_id
  uri             = var.FIS_incidentmanagement_submit_uri
  request_parameters = {
    "integration.request.header.Accept"       = "method.request.header.Accept"
    "integration.request.header.Content-Type" = "method.request.header.Content-Type"
  }
  depends_on = [
  aws_api_gateway_method.FIS_incidentmanagement_api_gateway_method_Submit]
}
resource "aws_api_gateway_integration" "FIS_incidentmanagement_Integration_update" {
  rest_api_id             = aws_api_gateway_rest_api.FIS_incidentmanagement.id
  resource_id             = aws_api_gateway_resource.FIS_incidentmanagement_api_gateway_resource_update.id
  integration_http_method = aws_api_gateway_method.FIS_incidentmanagement_api_gateway_method_update.http_method

  type            = var.FIS_incidentmanagement_integration_type
  http_method     = var.FIS_incidentmanagement_api_method
  connection_type = var.FIS_incidentmanagement_connection_type
  connection_id   = var.api_vpc_link_id
  uri             = var.FIS_incidentmanagement_update_uri
  request_parameters = {
    "integration.request.header.Accept"       = "method.request.header.Accept"
    "integration.request.header.Content-Type" = "method.request.header.Content-Type"
  }
  depends_on = [
  aws_api_gateway_method.FIS_incidentmanagement_api_gateway_method_update]
}
resource "aws_api_gateway_method_response" "FIS_incidentmanagement_MethodResponse_save" {
  rest_api_id = aws_api_gateway_rest_api.FIS_incidentmanagement.id
  resource_id = aws_api_gateway_resource.FIS_incidentmanagement_api_gateway_resource_save.id

  http_method = aws_api_gateway_method.FIS_incidentmanagement_api_gateway_method_save.http_method

  status_code = var.FIS_incidentmanagement_status_code
}

resource "aws_api_gateway_method_response" "FIS_incidentmanagement_MethodResponse_update" {
  rest_api_id = aws_api_gateway_rest_api.FIS_incidentmanagement.id
  resource_id = aws_api_gateway_resource.FIS_incidentmanagement_api_gateway_resource_update.id

  http_method = aws_api_gateway_method.FIS_incidentmanagement_api_gateway_method_update.http_method

  status_code = var.FIS_incidentmanagement_status_code
}
resource "aws_api_gateway_method_response" "FIS_incidentmanagement_MethodResponse_submit" {
  rest_api_id = aws_api_gateway_rest_api.FIS_incidentmanagement.id
  resource_id = aws_api_gateway_resource.FIS_incidentmanagement_api_gateway_resource_submit.id

  http_method = aws_api_gateway_method.FIS_incidentmanagement_api_gateway_method_Submit.http_method

  status_code = var.FIS_incidentmanagement_status_code
}
resource "aws_api_gateway_integration_response" "apigatewaygenericscript_IntegrationResponse_submit" {
  rest_api_id = aws_api_gateway_rest_api.FIS_incidentmanagement.id
  resource_id = aws_api_gateway_resource.FIS_incidentmanagement_api_gateway_resource_submit.id
  http_method = var.FIS_incidentmanagement_api_method
  status_code = var.FIS_incidentmanagement_status_code
  depends_on = [
    aws_api_gateway_integration.FIS_incidentmanagement_Integration_submit
  ]
}

resource "aws_api_gateway_integration_response" "apigatewaygenericscript_IntegrationResponse_update" {
  rest_api_id = aws_api_gateway_rest_api.FIS_incidentmanagement.id
  resource_id = aws_api_gateway_resource.FIS_incidentmanagement_api_gateway_resource_update.id
  http_method = var.FIS_incidentmanagement_api_method
  status_code = var.FIS_incidentmanagement_status_code
  depends_on = [
    aws_api_gateway_integration.FIS_incidentmanagement_Integration_update
  ]
}

resource "aws_api_gateway_integration_response" "apigatewaygenericscript_IntegrationResponse_save" {
  rest_api_id = aws_api_gateway_rest_api.FIS_incidentmanagement.id
  resource_id = aws_api_gateway_resource.FIS_incidentmanagement_api_gateway_resource_save.id
  http_method = var.FIS_incidentmanagement_api_method
  status_code = var.FIS_incidentmanagement_status_code
  depends_on = [
    aws_api_gateway_integration.FIS_incidentmanagement_Integration_save
  ]
}
resource "aws_api_gateway_deployment" "FIS_incidentmanagement_deployment" {
  rest_api_id = aws_api_gateway_rest_api.FIS_incidentmanagement.id

  triggers = {
    redeployment = sha1(jsonencode([
      aws_api_gateway_resource.FIS_incidentmanagement_api_gateway_resource_save,
      aws_api_gateway_resource.FIS_incidentmanagement_api_gateway_resource_submit,
      aws_api_gateway_resource.FIS_incidentmanagement_api_gateway_resource_update,
      aws_api_gateway_method.FIS_incidentmanagement_api_gateway_method_save,
      aws_api_gateway_method.FIS_incidentmanagement_api_gateway_method_Submit,
      aws_api_gateway_integration.FIS_incidentmanagement_Integration_save,
      aws_api_gateway_integration.FIS_incidentmanagement_Integration_submit,
      aws_api_gateway_method.FIS_incidentmanagement_api_gateway_method_update,
      aws_api_gateway_integration.FIS_incidentmanagement_Integration_update,
      aws_api_gateway_authorizer.FIS_auth,
      aws_api_gateway_gateway_response.FIS_api_gateway_respone,
      //aws_api_gateway_rest_api_policy.FIS_api_resource_policy.id,
      aws_cloudwatch_log_group.FIS
    ]))
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_cloudwatch_log_group" "FIS" {
  name              = "FIS/${var.env}"
  retention_in_days = var.log_retention_days

}
resource "aws_api_gateway_stage" "FIS_incidentmanagement_stage" {
  deployment_id = aws_api_gateway_deployment.FIS_incidentmanagement_deployment.id
  rest_api_id   = aws_api_gateway_rest_api.FIS_incidentmanagement.id
  stage_name    = var.env
  variables = {
    server = "api.${var.env}.iprm.js-devops.co.uk"
    port   = "17100"
  }
  access_log_settings {
    destination_arn = aws_cloudwatch_log_group.FIS.arn
    format          = jsonencode({ "requestId" : "$context.requestId", "ip" : "$context.identity.sourceIp", "caller" : "$context.identity.caller", "user" : "$context.identity.user", "requestTime" : "$context.requestTime", "httpMethod" : "$context.httpMethod", "resourcePath" : "$context.resourcePath", "status" : "$context.status", "protocol" : "$context.protocol", "responseLength" : "$context.responseLength" })
  }
  depends_on = [
    aws_api_gateway_deployment.FIS_incidentmanagement_deployment
  ]
}
resource "aws_api_gateway_base_path_mapping" "FISBasepath" {
  api_id      = aws_api_gateway_rest_api.FIS_incidentmanagement.id
  stage_name  = aws_api_gateway_stage.FIS_incidentmanagement_stage.stage_name
  domain_name = "api.${var.env}.iprm.js-devops.co.uk"
  base_path   = var.FIS_api_mapping_part
}

resource "aws_lambda_permission" "FIS_IncidentMGMTLamdaPermissions" {
  statement_id_prefix = local.FIS_lambda_permission_statement_id
  action              = "lambda:InvokeFunction"
  function_name       = var.FIS_lambda_function_name
  principal           = "apigateway.amazonaws.com"
  source_arn          = "${aws_api_gateway_rest_api.FIS_incidentmanagement.execution_arn}/authorizers/${aws_api_gateway_authorizer.FIS_auth.id}"

  lifecycle {
    create_before_destroy = true
  }

}

resource "aws_api_gateway_gateway_response" "FIS_api_gateway_respone" {
  rest_api_id   = aws_api_gateway_rest_api.FIS_incidentmanagement.id
  status_code   = "401"
  response_type = "UNAUTHORIZED"

  response_templates = {
    "application/json" = "{\"message\":Access Denied.Incorrect password or userid.Please check with Integration webMethods Team}"
  }

  response_parameters = {
    "gatewayresponse.header.Authorization" = "'Basic'"
  }
}

/*resource "aws_api_gateway_rest_api_policy" "FIS_api_resource_policy" {
  rest_api_id = aws_api_gateway_rest_api.FIS_incidentmanagement.id

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
         {
            "Effect": "Allow",
            "Principal": "*",
            "Action": "execute-api:Invoke",
            "Resource": "${aws_api_gateway_rest_api.FIS_incidentmanagement.execution_arn}/*"
        },        
        {
            "Effect": "Deny",
            "Principal": "*",
            "Action": "execute-api:Invoke",
            "Resource": "${aws_api_gateway_rest_api.FIS_incidentmanagement.execution_arn}/*",
            "Condition": {
                "NotIpAddress": {
                    "aws:SourceIp":  ${jsonencode(concat(var.FIS_allowedipaddresses))}
                }
            }
        }
       
    ]
}
EOF

}*/


resource "aws_api_gateway_method_settings" "FIS_settings" {
  rest_api_id = aws_api_gateway_rest_api.FIS_incidentmanagement.id
  stage_name  = var.env
  method_path = "*/*"

  settings {
    metrics_enabled    = var.FIS_incidentmanagement_metrics_enabled_flag
    logging_level      = var.FIS_incidentmanagement_logging_level
    data_trace_enabled = true

  }
  depends_on = [
    aws_api_gateway_stage.FIS_incidentmanagement_stage
  ]
}
