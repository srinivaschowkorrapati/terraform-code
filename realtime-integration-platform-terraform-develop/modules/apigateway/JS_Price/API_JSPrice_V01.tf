resource "aws_api_gateway_rest_api" "Js_Price_VS_01_rest_api" {

  name        = var.jsprice_api_name
  description = var.jsprice_api_description
  endpoint_configuration {
    types = ["REGIONAL"]
  }
}

resource "aws_api_gateway_resource" "Js_Price_VS_01_resource" {
  path_part   = var.jsprice_api_path_part
  parent_id   = aws_api_gateway_rest_api.Js_Price_VS_01_rest_api.root_resource_id
  rest_api_id = aws_api_gateway_rest_api.Js_Price_VS_01_rest_api.id
}

resource "aws_api_gateway_rest_api_policy" "ResourcePolicy_JSPrice" {
  rest_api_id = aws_api_gateway_rest_api.Js_Price_VS_01_rest_api.id
  policy      = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "AWS": "*"
      },
      "Action": "execute-api:Invoke",
      "Resource": "${aws_api_gateway_rest_api.Js_Price_VS_01_rest_api.execution_arn}",
     "Condition": {
                "StringEquals": {
                    "aws:sourceVpce": "${var.api_vpc_endpoint_ids[0]}"
           }
       }
    }
  ]
}
EOF
}


resource "aws_api_gateway_model" "JSPrice_api_gateway_resource_model" {
  rest_api_id  = aws_api_gateway_rest_api.Js_Price_VS_01_rest_api.id
  name         = "StoredValueSchema"
  description  = "a JSON schema"
  content_type = "application/json"

  schema = <<EOF

  {
  "$schema": "http://json-schema.org/draft-04/schema#",
  "title" : "postCoupons",
  "type" : "object",
  "properties": {
      "requestor_name": { "type": "string" },
      "output_file_type": { "type": "string" },
      "dept_id": { "type": "integer" },
      "division_id": { "type": "integer" },
      "group_id": { "type": "integer" },
      "class_id": { "type": "integer" },
      "subclass_id": { "type": "integer" },
      "only_sku": { "type": "boolean" },
      "auto_retrieve": { "type": "boolean" }
      
}
}

EOF
}


resource "aws_api_gateway_method" "JS_Price_method" {
  rest_api_id   = aws_api_gateway_rest_api.Js_Price_VS_01_rest_api.id
  resource_id   = aws_api_gateway_resource.Js_Price_VS_01_resource.id
  http_method   = var.jsprice_api_method
  authorization = "NONE"
  request_parameters = {
    "method.request.querystring.requestor_name" = true
    "method.request.querystring.action"         = true
    "method.request.querystring.request_id"     = true
    "method.request.header.Accept"              = true
    "method.request.header.Content-Type"        = true
  }
  request_models = { "application/json" = aws_api_gateway_model.JSPrice_api_gateway_resource_model.name }

}



resource "aws_api_gateway_method_response" "JS_Price_method_response" {
  rest_api_id = aws_api_gateway_rest_api.Js_Price_VS_01_rest_api.id
  resource_id = aws_api_gateway_resource.Js_Price_VS_01_resource.id
  http_method = aws_api_gateway_method.JS_Price_method.http_method
  status_code = "200"
}


resource "aws_api_gateway_integration" "JSPrice_rest_api_integration" {
  rest_api_id             = aws_api_gateway_rest_api.Js_Price_VS_01_rest_api.id
  resource_id             = aws_api_gateway_resource.Js_Price_VS_01_resource.id
  http_method             = aws_api_gateway_method.JS_Price_method.http_method
  integration_http_method = aws_api_gateway_method.JS_Price_method.http_method
  type                    = var.jsprice_integration_type
  connection_type         = var.jsprice_connection_type
  connection_id           = var.api_vpc_link_id
  uri                     = var.jsprice_uri
  request_parameters = {
    "integration.request.querystring.requestor_name" = "method.request.querystring.requestor_name"
    "integration.request.querystring.action"         = "method.request.querystring.action"
    "integration.request.querystring.request_id"     = "method.request.querystring.request_id"
    "integration.request.header.Accept"              = "method.request.header.Accept"
    "integration.request.header.Content-Type"        = "method.request.header.Content-Type"
  }

}

resource "aws_api_gateway_integration_response" "JS_Price_integration_response" {
  rest_api_id = aws_api_gateway_rest_api.Js_Price_VS_01_rest_api.id
  resource_id = aws_api_gateway_resource.Js_Price_VS_01_resource.id
  http_method = aws_api_gateway_method.JS_Price_method.http_method
  status_code = aws_api_gateway_method_response.JS_Price_method_response.status_code
  depends_on = [aws_api_gateway_integration.JSPrice_rest_api_integration

  ]
}

resource "aws_api_gateway_deployment" "JS_Price_gateway_deployment" {
  rest_api_id = aws_api_gateway_rest_api.Js_Price_VS_01_rest_api.id


  depends_on = [aws_api_gateway_method.JS_Price_method, aws_api_gateway_integration.JSPrice_rest_api_integration]
  lifecycle {
    create_before_destroy = true
  }
}


resource "aws_api_gateway_stage" "stored_value_gateway_stage" {

  deployment_id = aws_api_gateway_deployment.JS_Price_gateway_deployment.id
  rest_api_id   = aws_api_gateway_rest_api.Js_Price_VS_01_rest_api.id
  stage_name    = var.env
  variables = {
    server = "api.${var.env}.iprm.js-devops.co.uk"
    port   = "15003"
  }
}
