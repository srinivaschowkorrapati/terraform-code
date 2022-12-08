locals {
  lamdarole                     = "lambda_auth_role_${var.env}"
  lambdapolicy                  = "lambda_iam_policy_${var.env}"
  pega_commonlambdafunctionname = "Pega_common_Lambda_Authorizer_${var.env}"
  telefonicalamdafunctionname   = "Telefonica_Lamda_Authoriser_${var.env}"

  Traceonelamdafunctionname = "Traceone_Lamda_Authoriser_${var.env}"

  C3Reservationslamdafunctionname = "C3Reservations_Lamda_Authoriser_${var.env}"
  salesforcelamdafunctionname     = "salesforce_Lamda_Authoriser_${var.env}"

  hybris_Stock_Mgmt_lambda_functionname = "hybris_Stock_Mgmt_Lambda_Authoriser_${var.env}"
  otg_common_lambda_functionname        = "otg_common_Lambda_Authoriser_${var.env}"

  RetailApps_lambda_functionname = "RetailApps_Lamda_Authoriser_${var.env}"
  FIS_lambda_functionname        = "FIS_Lamda_Authoriser_${var.env}"
}

data "aws_iam_role" "lambda_auth_role" {
  name = var.role
}
#-------------------------------------------------------------
#Pega_Common

data "archive_file" "pega_common_lambda_zip" {
  type        = "zip"
  source_file = "${path.module}/pega_commonindex.js"
  output_path = "${path.module}/pega_common_Lambda_Authorizer.zip"
}

resource "aws_lambda_function" "pega_common_Lambda_Authorizer" {

  function_name    = local.pega_commonlambdafunctionname
  role             = data.aws_iam_role.lambda_auth_role.arn
  filename         = "${path.module}/pega_common_Lambda_Authorizer.zip"
  source_code_hash = data.archive_file.pega_common_lambda_zip.output_base64sha256
  handler          = "pega_commonindex.handler"
  runtime          = "nodejs14.x"
  environment {
    variables = {
      SECRET_ID = "APIGateway_Global"
    }
  }
}

output "pega_common_lambda_authorizer_arn" {
  value       = aws_lambda_function.pega_common_Lambda_Authorizer.invoke_arn
  description = "pega_common Lambda Authorizer ARN"
}

output "pega_common_lambda_function_name" {
  value       = aws_lambda_function.pega_common_Lambda_Authorizer.function_name
  description = "pega_common Lambda Authoriser function name"

}


#-----------------------------------------------------------------------------------------
data "archive_file" "telefonica_lambda_zip" {
  type        = "zip"
  source_file = "${path.module}/telefonicaindex.js"
  output_path = "${path.module}/Telefonica_Lambda_Authorizer.zip"
}

resource "aws_lambda_function" "Telefonica_Lambda_Authorizer" {

  function_name    = local.telefonicalamdafunctionname
  role             = data.aws_iam_role.lambda_auth_role.arn
  filename         = "${path.module}/Telefonica_Lambda_Authorizer.zip"
  source_code_hash = data.archive_file.telefonica_lambda_zip.output_base64sha256
  handler          = "telefonicaindex.handler"
  runtime          = "nodejs14.x"
  environment {
    variables = {
      SECRET_ID = "APIGateway_Global"
    }
  }
}

output "telefonica_lambda_authorizer_arn" {
  value       = aws_lambda_function.Telefonica_Lambda_Authorizer.invoke_arn
  description = "Telefonica Lambda Authorizer ARN"
}

output "telefonica_lamda_function_name" {
  value       = aws_lambda_function.Telefonica_Lambda_Authorizer.function_name
  description = "Telefonica Lambda Authoriser function name"

}

##---------------------------------------------
#Traceone Authoriser

data "archive_file" "Traceone_lambda_zip" {
  type        = "zip"
  source_file = "${path.module}/Traceoneindex.js"
  output_path = "${path.module}/Traceone_Lambda_Authorizer.zip"
}

resource "aws_lambda_function" "Traceone_Lambda_Authorizer" {

  function_name    = local.Traceonelamdafunctionname
  role             = data.aws_iam_role.lambda_auth_role.arn
  filename         = "${path.module}/Traceone_Lambda_Authorizer.zip"
  source_code_hash = data.archive_file.Traceone_lambda_zip.output_base64sha256
  handler          = "Traceoneindex.handler"
  runtime          = "nodejs14.x"
  environment {
    variables = {
      SECRET_ID = "APIGateway_Global"
    }
  }
}

output "Traceone_lambda_authorizer_arn" {
  value       = aws_lambda_function.Traceone_Lambda_Authorizer.invoke_arn
  description = "Traceone Lambda Authorizer ARN"
}

output "Traceone_lamda_function_name" {
  value       = aws_lambda_function.Traceone_Lambda_Authorizer.function_name
  description = "Traceone Lambda Authoriser function name"

}

##---------------------------------------------
#C3 Reservations Authoriser

data "archive_file" "C3Reservations_lambda_zip" {
  type        = "zip"
  source_file = "${path.module}/C3Reservationsindex.js"
  output_path = "${path.module}/C3Reservations_Lambda_Authorizer.zip"
}

resource "aws_lambda_function" "C3Reservations_Lambda_Authorizer" {

  function_name    = local.C3Reservationslamdafunctionname
  role             = data.aws_iam_role.lambda_auth_role.arn
  filename         = "${path.module}/C3Reservations_Lambda_Authorizer.zip"
  source_code_hash = data.archive_file.C3Reservations_lambda_zip.output_base64sha256
  handler          = "C3Reservationsindex.handler"
  runtime          = "nodejs14.x"
  environment {
    variables = {
      SECRET_ID = "APIGateway_Global"
    }
  }
}

output "C3Reservations_lambda_authorizer_arn" {
  value       = aws_lambda_function.C3Reservations_Lambda_Authorizer.invoke_arn
  description = "C3Reservations Lambda Authorizer ARN"
}

output "C3Reservations_lamda_function_name" {
  value       = aws_lambda_function.C3Reservations_Lambda_Authorizer.function_name
  description = "C3Reservations Lambda Authoriser function name"

}



##---------------------------------------------
#Sales Force Authoriser

data "archive_file" "salesforce_lambda_zip" {
  type        = "zip"
  source_file = "${path.module}/salesforceindex.js"
  output_path = "${path.module}/salesforce_Lambda_Authorizer.zip"
}

resource "aws_lambda_function" "salesforce_Lambda_Authorizer" {

  function_name    = local.salesforcelamdafunctionname
  role             = data.aws_iam_role.lambda_auth_role.arn
  filename         = "${path.module}/salesforce_Lambda_Authorizer.zip"
  source_code_hash = data.archive_file.salesforce_lambda_zip.output_base64sha256
  handler          = "salesforceindex.handler"
  runtime          = "nodejs14.x"
  environment {
    variables = {
      SECRET_ID = "APIGateway_Global"
    }
  }
}

output "salesforce_lambda_authorizer_arn" {
  value       = aws_lambda_function.salesforce_Lambda_Authorizer.invoke_arn
  description = "salesforce Lambda Authorizer ARN"
}

output "salesforce_lamda_function_name" {
  value       = aws_lambda_function.salesforce_Lambda_Authorizer.function_name
  description = "salesforce Lambda Authoriser function name"

}
#--------------------------------------------------------------------------------------
### Hybris Stock Mgmt
data "archive_file" "hybris_Stock_Mgmt_lambda_zip" {
  type        = "zip"
  source_file = "${path.module}/hybris_Stock_Mgmt_index.js"
  output_path = "${path.module}/hybris_Stock_Mgmt_Lambda_Authorizer.zip"
}

resource "aws_lambda_function" "hybris_Stock_Mgmt_Lambda_Authorizer" {

  function_name    = local.hybris_Stock_Mgmt_lambda_functionname
  role             = data.aws_iam_role.lambda_auth_role.arn
  filename         = "${path.module}/hybris_Stock_Mgmt_Lambda_Authorizer.zip"
  source_code_hash = data.archive_file.hybris_Stock_Mgmt_lambda_zip.output_base64sha256
  handler          = "hybris_Stock_Mgmt_index.handler"
  runtime          = "nodejs14.x"
  environment {
    variables = {
      SECRET_ID = "APIGateway_Global"
    }
  }
}

output "hybris_Stock_Mgmt_lambda_authorizer_arn" {
  value       = aws_lambda_function.hybris_Stock_Mgmt_Lambda_Authorizer.invoke_arn
  description = "hybris_Stock_Mgmt Lambda Authorizer ARN"
}

output "hybris_Stock_Mgmt_lambda_function_name" {
  value       = aws_lambda_function.hybris_Stock_Mgmt_Lambda_Authorizer.function_name
  description = "hybris_Stock_Mgmt Lambda Authoriser function name"

}
#------------------------------------------------------------------------------------------------
##---------------------------------------------
#otg_common Authoriser

data "archive_file" "otg_common_lambda_zip" {
  type        = "zip"
  source_file = "${path.module}/otg_commonindex.js"
  output_path = "${path.module}/otg_common_Lambda_Authorizer.zip"
}

resource "aws_lambda_function" "otg_common_Lambda_Authorizer" {

  function_name    = local.otg_common_lambda_functionname
  role             = data.aws_iam_role.lambda_auth_role.arn
  filename         = "${path.module}/otg_common_Lambda_Authorizer.zip"
  source_code_hash = data.archive_file.otg_common_lambda_zip.output_base64sha256
  handler          = "otg_commonindex.handler"
  runtime          = "nodejs14.x"
  environment {
    variables = {
      SECRET_ID = "APIGateway_Global"
    }
  }
}

output "otg_common_lambda_authorizer_arn" {
  value       = aws_lambda_function.otg_common_Lambda_Authorizer.invoke_arn
  description = "otg_common Lambda Authorizer ARN"
}

output "otg_common_lambda_function_name" {
  value       = aws_lambda_function.otg_common_Lambda_Authorizer.function_name
  description = "otg_common Lambda Authoriser function name"

}
#-------------------------------------------------------------------------------------
#####Retail APPs authoriser-----------------###

data "archive_file" "RetailApps_lambda_zip" {
  type        = "zip"
  source_file = "${path.module}/financialCalendar_index.js"
  output_path = "${path.module}/financialCalendar_Lambda_Authorizer.zip"
}

resource "aws_lambda_function" "RetailApps_Lambda_Authorizer" {

  function_name    = local.RetailApps_lambda_functionname
  role             = data.aws_iam_role.lambda_auth_role.arn
  filename         = "${path.module}/financialCalendar_Lambda_Authorizer.zip"
  source_code_hash = data.archive_file.RetailApps_lambda_zip.output_base64sha256
  handler          = "financialCalendar_index.handler"
  runtime          = "nodejs14.x"
  environment {
    variables = {
      SECRET_ID = "APIGateway_Global"
    }
  }
}

output "RetailApps_lambda_authorizer_arn" {
  value       = aws_lambda_function.RetailApps_Lambda_Authorizer.invoke_arn
  description = "Retail Apps Lambda Authorizer ARN"
}

output "RetailApps_lambda_function_name" {
  value       = aws_lambda_function.RetailApps_Lambda_Authorizer.function_name
  description = "Retail APPs Lambda Authoriser function name"

}

#-------------------------------------------------------------------------------------
#####FIS authoriser-----------------###

data "archive_file" "FIS_lambda_zip" {
  type        = "zip"
  source_file = "${path.module}/FIS_index.js"
  output_path = "${path.module}/FIS_Lambda_Authorizer.zip"
}

resource "aws_lambda_function" "FIS_Lambda_Authorizer" {

  function_name    = local.FIS_lambda_functionname
  role             = data.aws_iam_role.lambda_auth_role.arn
  filename         = "${path.module}/FIS_Lambda_Authorizer.zip"
  source_code_hash = data.archive_file.FIS_lambda_zip.output_base64sha256
  handler          = "FIS_index.handler"
  runtime          = "nodejs14.x"
  environment {
    variables = {
      SECRET_ID = "APIGateway_Global"
    }
  }
}

output "FIS_lambda_authorizer_arn" {
  value       = aws_lambda_function.FIS_Lambda_Authorizer.invoke_arn
  description = "FIS Lambda Authorizer ARN"
}

output "FIS_lambda_function_name" {
  value       = aws_lambda_function.FIS_Lambda_Authorizer.function_name
  description = "FIS Lambda Authoriser function name"

}