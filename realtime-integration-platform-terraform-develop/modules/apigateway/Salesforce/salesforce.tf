resource "aws_api_gateway_rest_api" "createFixedDeal" {
  name        = var.salesforce_api_name
  description = var.salesforce_api_description
  endpoint_configuration {

    types = ["REGIONAL"]

  }
}

locals {
  lambda_permission_statement_id = "Allow_Invoke_createFixedDeal_${var.env}"
}
resource "aws_api_gateway_resource" "createFixedDeal_api_gateway_resource" {
  path_part   = var.createFixedDeal_api_path_part
  parent_id   = aws_api_gateway_rest_api.createFixedDeal.root_resource_id
  rest_api_id = aws_api_gateway_rest_api.createFixedDeal.id
}

resource "aws_api_gateway_method" "createFixedDeal_api_gateway_method" {
  rest_api_id   = aws_api_gateway_rest_api.createFixedDeal.id
  resource_id   = aws_api_gateway_resource.createFixedDeal_api_gateway_resource.id
  http_method   = "POST"
  authorization = var.createFixedDeal_auth_type
  authorizer_id = aws_api_gateway_authorizer.createFixedDeal_auth.id
  request_parameters = {
    "method.request.header.Accept"       = false
    "method.request.header.Content-Type" = false
  }
}

resource "aws_api_gateway_authorizer" "createFixedDeal_auth" {
  name            = "CustomAuthoriser"
  rest_api_id     = aws_api_gateway_rest_api.createFixedDeal.id
  authorizer_uri  = var.salesforce_lambda_authorizer_arn
  identity_source = "method.request.header.Authorization"
  type            = "REQUEST"

}
resource "aws_api_gateway_integration" "createFixedDeal_api_gateway_integration" {
  rest_api_id             = aws_api_gateway_rest_api.createFixedDeal.id
  resource_id             = aws_api_gateway_resource.createFixedDeal_api_gateway_resource.id
  integration_http_method = aws_api_gateway_method.createFixedDeal_api_gateway_method.http_method
  type                    = var.createFixedDeal_integration_type
  http_method             = aws_api_gateway_method.createFixedDeal_api_gateway_method.http_method
  connection_type         = var.createFixedDeal_connection_type
  connection_id           = var.api_vpc_link_id
  uri                     = var.createFixedDeal_uri
  request_parameters = {
    "integration.request.header.Accept"       = "method.request.header.Accept"
    "integration.request.header.Content-Type" = "method.request.header.Content-Type"
  }
}

resource "aws_api_gateway_method_response" "createFixedDeal_responses" {
  rest_api_id = aws_api_gateway_rest_api.createFixedDeal.id
  resource_id = aws_api_gateway_resource.createFixedDeal_api_gateway_resource.id
  http_method = aws_api_gateway_method.createFixedDeal_api_gateway_method.http_method
  status_code = "200"
}

resource "aws_api_gateway_integration_response" "createFixedDeal_integration_response" {
  rest_api_id = aws_api_gateway_rest_api.createFixedDeal.id
  resource_id = aws_api_gateway_resource.createFixedDeal_api_gateway_resource.id
  http_method = var.createFixedDeal_api_method
  status_code = aws_api_gateway_method_response.createFixedDeal_responses.status_code
  depends_on = [
    aws_api_gateway_integration.createFixedDeal_api_gateway_integration
  ]
}
/******************************** promotional Deal******************/


resource "aws_api_gateway_resource" "promoDeal_api_gateway_resource" {
  path_part   = var.promoDeal_api_path_part
  parent_id   = aws_api_gateway_rest_api.createFixedDeal.root_resource_id
  rest_api_id = aws_api_gateway_rest_api.createFixedDeal.id
}

resource "aws_api_gateway_method" "promoDeal_api_gateway_method" {
  rest_api_id   = aws_api_gateway_rest_api.createFixedDeal.id
  resource_id   = aws_api_gateway_resource.promoDeal_api_gateway_resource.id
  http_method   = "POST"
  authorization = var.promoDeal_auth_type
  authorizer_id = aws_api_gateway_authorizer.createFixedDeal_auth.id
  request_parameters = {
    "method.request.header.Accept"       = false
    "method.request.header.Content-Type" = false
  }
}


resource "aws_api_gateway_integration" "promoDeal_api_gateway_integration" {
  rest_api_id             = aws_api_gateway_rest_api.createFixedDeal.id
  resource_id             = aws_api_gateway_resource.promoDeal_api_gateway_resource.id
  integration_http_method = aws_api_gateway_method.promoDeal_api_gateway_method.http_method
  type                    = var.promoDeal_integration_type
  http_method             = aws_api_gateway_method.promoDeal_api_gateway_method.http_method
  connection_type         = var.promoDeal_connection_type
  connection_id           = var.api_vpc_link_id
  uri                     = var.promoDeal_uri
  request_parameters = {
    "integration.request.header.Accept"       = "method.request.header.Accept"
    "integration.request.header.Content-Type" = "method.request.header.Content-Type"
  }
}

resource "aws_api_gateway_method_response" "promoDeal_responses" {
  rest_api_id = aws_api_gateway_rest_api.createFixedDeal.id
  resource_id = aws_api_gateway_resource.promoDeal_api_gateway_resource.id
  http_method = aws_api_gateway_method.promoDeal_api_gateway_method.http_method
  status_code = "200"
}

resource "aws_api_gateway_integration_response" "promoDeal_integration_response" {
  rest_api_id = aws_api_gateway_rest_api.createFixedDeal.id
  resource_id = aws_api_gateway_resource.promoDeal_api_gateway_resource.id
  http_method = var.promoDeal_api_method
  status_code = aws_api_gateway_method_response.promoDeal_responses.status_code
  depends_on = [
    aws_api_gateway_integration.promoDeal_api_gateway_integration
  ]
}
/********************** deployment *************************/
resource "aws_api_gateway_deployment" "createFixedDeal_api_gateway_deployment" {
  rest_api_id = aws_api_gateway_rest_api.createFixedDeal.id

  triggers = {
    redeployment = sha1(jsonencode([
      aws_api_gateway_resource.createFixedDeal_api_gateway_resource,
      aws_api_gateway_method.createFixedDeal_api_gateway_method,
      aws_api_gateway_integration.createFixedDeal_api_gateway_integration,
      aws_api_gateway_method.promoDeal_api_gateway_method,
      aws_api_gateway_integration.promoDeal_api_gateway_integration,
      aws_api_gateway_authorizer.createFixedDeal_auth,
      aws_api_gateway_gateway_response.Salesforce_api_gateway_respone,
      //aws_api_gateway_rest_api_policy.Salesforce_api_resource_policy.id,
      aws_cloudwatch_log_group.SalesForce_V01
    ]))
  }

  lifecycle {
    create_before_destroy = true
  }
}
resource "aws_cloudwatch_log_group" "SalesForce_V01" {
  name              = "Salesforce/${var.env}"
  retention_in_days = var.log_retention_days

}

resource "aws_api_gateway_stage" "createFixedDeal_api_stage" {
  deployment_id = aws_api_gateway_deployment.createFixedDeal_api_gateway_deployment.id
  rest_api_id   = aws_api_gateway_rest_api.createFixedDeal.id
  stage_name    = var.env
  variables = {

    server = "api.${var.env}.iprm.js-devops.co.uk"
    port   = "15100"
  }
  access_log_settings {
    destination_arn = aws_cloudwatch_log_group.SalesForce_V01.arn
    format          = jsonencode({ "requestId" : "$context.requestId", "ip" : "$context.identity.sourceIp", "caller" : "$context.identity.caller", "user" : "$context.identity.user", "requestTime" : "$context.requestTime", "httpMethod" : "$context.httpMethod", "resourcePath" : "$context.resourcePath", "status" : "$context.status", "protocol" : "$context.protocol", "responseLength" : "$context.responseLength" })
  }

}



resource "aws_lambda_permission" "createFixedDeal_LamdaPermissions" {
  statement_id_prefix = local.lambda_permission_statement_id
  action              = "lambda:InvokeFunction"
  function_name       = var.salesforce_lamda_function_name

  principal  = "apigateway.amazonaws.com"
  source_arn = "${aws_api_gateway_rest_api.createFixedDeal.execution_arn}/authorizers/${aws_api_gateway_authorizer.createFixedDeal_auth.id}"
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_api_gateway_base_path_mapping" "createFixedDeal_Basepath" {
  api_id      = aws_api_gateway_rest_api.createFixedDeal.id
  stage_name  = aws_api_gateway_stage.createFixedDeal_api_stage.stage_name
  domain_name = "api.${var.env}.iprm.js-devops.co.uk"
  base_path   = var.createFixedDeal_api_mapping_part
}


resource "aws_api_gateway_gateway_response" "Salesforce_api_gateway_respone" {
  rest_api_id   = aws_api_gateway_rest_api.createFixedDeal.id
  status_code   = "401"
  response_type = "UNAUTHORIZED"

  response_templates = {
    "application/json" = "{\"message\":Access Denied.Incorrect password or userid.Please check with Integration webMethods Team}"
  }

  response_parameters = {
    "gatewayresponse.header.Authorization" = "'Basic'"
  }
}

/* resource "aws_api_gateway_rest_api_policy" "Salesforce_api_resource_policy" {
  rest_api_id = aws_api_gateway_rest_api.createFixedDeal.id

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
          {
            "Effect": "Allow",
            "Principal": "*",
            "Action": "execute-api:Invoke",
            "Resource": "${aws_api_gateway_rest_api.createFixedDeal.execution_arn}/*"
        },        
        {
            "Effect": "Deny",
            "Principal": "*",
            "Action": "execute-api:Invoke",
            "Resource": "${aws_api_gateway_rest_api.createFixedDeal.execution_arn}/*",
            "Condition": {
                "NotIpAddress": {
                    "aws:SourceIp":  ${jsonencode(concat(var.salesforce_allowedipaddresses))}
                }
            }
        }
      
    ]
}
EOF

} */


resource "aws_api_gateway_method_settings" "Salesforce_settings" {
  rest_api_id = aws_api_gateway_rest_api.createFixedDeal.id
  stage_name  = var.env
  method_path = "*/*"

  depends_on = [
    aws_api_gateway_stage.createFixedDeal_api_stage
  ]

  settings {
    metrics_enabled    = var.salesforce_metrics_enabled_flag
    logging_level      = var.salesforce_logging_level
    data_trace_enabled = false

  }
} 