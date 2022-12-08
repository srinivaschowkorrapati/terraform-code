#Local variables declaration
locals {
  lambda_permission_statement_id = "Allow_My_Post_Session_Invoke_Js_Financial_Calendar_V01_${var.env}"
}

# Create Rest API 
resource "aws_api_gateway_rest_api" "Js_Financial_Calendar_V01_rest_api" {
  name        = var.Js_Financial_Calendar_V01_api_name
  description = var.Js_Financial_Calendar_V01_api_description
  endpoint_configuration {

    types = ["REGIONAL"]

  }

}

resource "aws_api_gateway_resource" "Js_Financial_Calendar_V01_api_gateway_resource" {
  path_part   = var.Js_Financial_Calendar_V01_api_path_part
  parent_id   = aws_api_gateway_rest_api.Js_Financial_Calendar_V01_rest_api.root_resource_id
  rest_api_id = aws_api_gateway_rest_api.Js_Financial_Calendar_V01_rest_api.id
}

resource "aws_api_gateway_resource" "Js_Financial_Calendar_V01_api_gateway_resource_path" {
  path_part   = "{proxy+}"
  parent_id   = aws_api_gateway_resource.Js_Financial_Calendar_V01_api_gateway_resource.id
  rest_api_id = aws_api_gateway_rest_api.Js_Financial_Calendar_V01_rest_api.id
}

resource "aws_api_gateway_method" "Js_Financial_Calendar_V01_api_gateway_method" {
  rest_api_id   = aws_api_gateway_rest_api.Js_Financial_Calendar_V01_rest_api.id
  resource_id   = aws_api_gateway_resource.Js_Financial_Calendar_V01_api_gateway_resource.id
  http_method   = var.Js_Financial_Calendar_V01_api_method
  authorization = "CUSTOM"
  authorizer_id = aws_api_gateway_authorizer.apigatewaygenericscriptauth.id

}

resource "aws_api_gateway_method" "Js_Financial_Calendar_V01_api_gateway_method_path" {
  rest_api_id   = aws_api_gateway_rest_api.Js_Financial_Calendar_V01_rest_api.id
  resource_id   = aws_api_gateway_resource.Js_Financial_Calendar_V01_api_gateway_resource_path.id
  http_method   = var.Js_Financial_Calendar_V01_api_method
  authorization = "CUSTOM"
  authorizer_id = aws_api_gateway_authorizer.apigatewaygenericscriptauth.id
  request_parameters = {
    "method.request.path.proxy" = true
  }

}

resource "aws_api_gateway_authorizer" "apigatewaygenericscriptauth" {
  name            = "CustomAuthoriser"
  rest_api_id     = aws_api_gateway_rest_api.Js_Financial_Calendar_V01_rest_api.id
  authorizer_uri  = var.FinancialCalendar_lambda_authorizer_arn
  identity_source = "method.request.header.Authorization"
  type            = "REQUEST"

}

resource "aws_api_gateway_integration" "Js_Financial_Calendar_V01_api_gateway_integration" {
  rest_api_id             = aws_api_gateway_rest_api.Js_Financial_Calendar_V01_rest_api.id
  resource_id             = aws_api_gateway_resource.Js_Financial_Calendar_V01_api_gateway_resource.id
  integration_http_method = aws_api_gateway_method.Js_Financial_Calendar_V01_api_gateway_method.http_method
  type                    = var.Js_Financial_Calendar_V01_integration_type
  http_method             = aws_api_gateway_method.Js_Financial_Calendar_V01_api_gateway_method.http_method
  connection_type         = var.Js_Financial_Calendar_V01_connection_type
  connection_id           = var.api_vpc_link_id
  uri                     = var.Js_Financial_Calendar_V01_uri

}

resource "aws_api_gateway_integration" "Js_Financial_Calendar_V01_api_gateway_integration_path" {
  rest_api_id             = aws_api_gateway_rest_api.Js_Financial_Calendar_V01_rest_api.id
  resource_id             = aws_api_gateway_resource.Js_Financial_Calendar_V01_api_gateway_resource_path.id
  integration_http_method = aws_api_gateway_method.Js_Financial_Calendar_V01_api_gateway_method_path.http_method
  type                    = var.Js_Financial_Calendar_V01_integration_type
  http_method             = aws_api_gateway_method.Js_Financial_Calendar_V01_api_gateway_method_path.http_method
  connection_type         = var.Js_Financial_Calendar_V01_connection_type
  connection_id           = var.api_vpc_link_id
  uri                     = "${var.Js_Financial_Calendar_V01_uri}/{proxy}"
  request_parameters = {
    "integration.request.path.proxy" = "method.request.path.proxy"
  }

}

resource "aws_api_gateway_method_response" "Js_Financial_Calendar_V01_responses" {
  rest_api_id = aws_api_gateway_rest_api.Js_Financial_Calendar_V01_rest_api.id
  resource_id = aws_api_gateway_resource.Js_Financial_Calendar_V01_api_gateway_resource.id
  http_method = aws_api_gateway_method.Js_Financial_Calendar_V01_api_gateway_method.http_method
  status_code = "200"
}

resource "aws_api_gateway_method_response" "Js_Financial_Calendar_V01_responses_path" {
  rest_api_id = aws_api_gateway_rest_api.Js_Financial_Calendar_V01_rest_api.id
  resource_id = aws_api_gateway_resource.Js_Financial_Calendar_V01_api_gateway_resource_path.id
  http_method = aws_api_gateway_method.Js_Financial_Calendar_V01_api_gateway_method_path.http_method
  status_code = "200"
}

resource "aws_api_gateway_integration_response" "Js_Financial_Calendar_V01_integration_response" {
  rest_api_id = aws_api_gateway_rest_api.Js_Financial_Calendar_V01_rest_api.id
  resource_id = aws_api_gateway_resource.Js_Financial_Calendar_V01_api_gateway_resource.id
  http_method = var.Js_Financial_Calendar_V01_api_method
  status_code = aws_api_gateway_method_response.Js_Financial_Calendar_V01_responses.status_code
  depends_on = [
    aws_api_gateway_integration.Js_Financial_Calendar_V01_api_gateway_integration
  ]
}

resource "aws_api_gateway_integration_response" "Js_Financial_Calendar_V01_integration_response_path" {
  rest_api_id = aws_api_gateway_rest_api.Js_Financial_Calendar_V01_rest_api.id
  resource_id = aws_api_gateway_resource.Js_Financial_Calendar_V01_api_gateway_resource_path.id
  http_method = var.Js_Financial_Calendar_V01_api_method
  status_code = aws_api_gateway_method_response.Js_Financial_Calendar_V01_responses_path.status_code
  depends_on = [
    aws_api_gateway_integration.Js_Financial_Calendar_V01_api_gateway_integration_path
  ]
}


resource "aws_cloudwatch_log_group" "Js_Financial_Calendar_V01" {
  name              = "FinancialCalendar/${var.env}"
  retention_in_days = var.log_retention_days

}

resource "aws_api_gateway_stage" "Js_Financial_Calendar_V01_api_stage" {
  deployment_id = aws_api_gateway_deployment.Js_Financial_Calendar_V01_api_gateway_deployment.id
  rest_api_id   = aws_api_gateway_rest_api.Js_Financial_Calendar_V01_rest_api.id
  stage_name    = var.env
  variables = {
    server = "api.${var.env}.iprm.js-devops.co.uk"
    port   = "17003"
  }

  access_log_settings {
    destination_arn = aws_cloudwatch_log_group.Js_Financial_Calendar_V01.arn
    format          = jsonencode({ "requestId" : "$context.requestId", "ip" : "$context.identity.sourceIp", "caller" : "$context.identity.caller", "user" : "$context.identity.user", "requestTime" : "$context.requestTime", "httpMethod" : "$context.httpMethod", "resourcePath" : "$context.resourcePath", "status" : "$context.status", "protocol" : "$context.protocol", "responseLength" : "$context.responseLength" })
  }
  depends_on = [
    aws_api_gateway_deployment.Js_Financial_Calendar_V01_api_gateway_deployment
  ]
}
resource "aws_api_gateway_deployment" "Js_Financial_Calendar_V01_api_gateway_deployment" {
  rest_api_id = aws_api_gateway_rest_api.Js_Financial_Calendar_V01_rest_api.id

  triggers = {
    redeployment = sha1(jsonencode([
      aws_api_gateway_resource.Js_Financial_Calendar_V01_api_gateway_resource,
      aws_api_gateway_method.Js_Financial_Calendar_V01_api_gateway_method,
      aws_api_gateway_integration.Js_Financial_Calendar_V01_api_gateway_integration,
      aws_api_gateway_authorizer.apigatewaygenericscriptauth,
      aws_api_gateway_gateway_response.Js_Financial_Calendar_V01_api_gateway_respone,
      /* aws_api_gateway_rest_api_policy.Js_Financial_Calendar_V01_api_resource_policy.id */
      aws_api_gateway_resource.Js_Financial_Calendar_V01_api_gateway_resource_path,
      aws_api_gateway_method.Js_Financial_Calendar_V01_api_gateway_method_path,
      aws_api_gateway_integration.Js_Financial_Calendar_V01_api_gateway_integration_path,
      aws_cloudwatch_log_group.Js_Financial_Calendar_V01
    ]))
  }

  lifecycle {
    create_before_destroy = true
  }
}




resource "aws_lambda_permission" "Js_Financial_Calendar_V01LamdaPermissions" {
  statement_id_prefix = local.lambda_permission_statement_id
  action              = "lambda:InvokeFunction"
  function_name       = var.FinancialCalendar_lamda_function_name
  principal           = "apigateway.amazonaws.com"
  source_arn          = "${aws_api_gateway_rest_api.Js_Financial_Calendar_V01_rest_api.execution_arn}/authorizers/${aws_api_gateway_authorizer.apigatewaygenericscriptauth.id}"

  lifecycle {
    create_before_destroy = true
  }

}

resource "aws_api_gateway_base_path_mapping" "apigatewaygenericscriptBasepath" {
  api_id      = aws_api_gateway_rest_api.Js_Financial_Calendar_V01_rest_api.id
  stage_name  = aws_api_gateway_stage.Js_Financial_Calendar_V01_api_stage.stage_name
  domain_name = "api.${var.env}.iprm.js-devops.co.uk"
  base_path   = var.Js_Financial_Calendar_V01_api_mapping_path
}

resource "aws_api_gateway_gateway_response" "Js_Financial_Calendar_V01_api_gateway_respone" {
  rest_api_id   = aws_api_gateway_rest_api.Js_Financial_Calendar_V01_rest_api.id
  status_code   = "401"
  response_type = "UNAUTHORIZED"

  response_templates = {
    "application/json" = "{\"message\":Access Denied.Incorrect password or userid.Please check with Integration webMethods Team}"
  }

  response_parameters = {
    "gatewayresponse.header.Authorization" = "'Basic'"
  }
}

#Replaced by AWS WAF ACL
/*
resource "aws_api_gateway_rest_api_policy" "Js_Financial_Calendar_V01_api_resource_policy" {
  rest_api_id = aws_api_gateway_rest_api.Js_Financial_Calendar_V01_rest_api.id

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": "*",
            "Action": "execute-api:Invoke",
            "Resource": [ 
               "${aws_api_gateway_rest_api.Js_Financial_Calendar_V01_rest_api.execution_arn}/*"
        ],
        {
            "Effect": "Deny",
            "Principal": "*",
                "AWS": "*"
            "Action": "execute-api:Invoke",
            "Resource": [
              "${aws_api_gateway_rest_api.Js_Financial_Calendar_V01_rest_api.execution_arn}/*",
              ],
            "Condition": {
                "NotIpAddress": {
                    "aws:SourceIp":  ${jsonencode(concat(var.retailapps_allowedipaddresses))}
                }
            }
        }
        
    ]
}
EOF

} */


resource "aws_api_gateway_method_settings" "Js_Financial_Calendar_V01_settings" {
  rest_api_id = aws_api_gateway_rest_api.Js_Financial_Calendar_V01_rest_api.id
  stage_name  = var.env
  method_path = "*/*"

  depends_on = [
    aws_api_gateway_stage.Js_Financial_Calendar_V01_api_stage
  ]
  settings {
    metrics_enabled    = var.Js_Financial_Calendar_V01_metrics_enabled_flag
    logging_level      = var.Js_Financial_Calendar_V01_logging_level
    data_trace_enabled = false

  }
}

data "aws_lambda_function" "ingestion_function" {
  function_name = "newrelic-log-ingestion"
}

resource "aws_cloudwatch_log_subscription_filter" "cw_log_filter_Fin_Calendar_API" {
  name            = "Fin_Calendar_API/${var.env}"
  log_group_name  = "API-Gateway-Execution-Logs_${aws_api_gateway_rest_api.Js_Financial_Calendar_V01_rest_api.id}/${var.env}"
  filter_pattern  = ""
  destination_arn = data.aws_lambda_function.ingestion_function.arn
  distribution    = "ByLogStream"
}