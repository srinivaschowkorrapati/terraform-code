# Configuring aws Provider
provider "aws" {
  region = "eu-west-1"

  default_tags {
    tags = {
      owner              = "Shaun.Barr"
      email              = "Shaun.Barr@sainsburys.co.uk"
      costcentre         = var.costcenter
      project            = "Application Integration Platform"
      live               = var.live
      Environment        = var.environment
      Terraform_Managed  = "Yes"
      dataClassification = var.dataClassification
    }
  }
}

# Configuring Backend S3 bucket
terraform {
  backend "s3" {
    key    = "app-intg-platform-tf-state/terraform.tfstate"
    region = "eu-west-1"
  }
}

# ---------------------------------------------------------------------------- #

/* 
Module Name     : Retail Corp MQ
Description     : Creating Retail Corp MQ Cluster (3 brokers) along with nlb and route 53 configuration
Created By      : Phaneendra Boyapati
Created Date    : 23/06/2021
Modified By     : Saran kumar
Modified Date   : 07/10/2021
*/

module "retail_corp_mq" {
  source = "./modules/amq/retail_corp_mq"
  count  = var.retail_host_provision ? 1 : 0


  env                       = var.environment
  retail_engine_type        = var.amq_engine_type
  retail_engine_version     = var.amq_engine_version
  retail_host_instance_type = var.retail_host_instance_type
  private_subnet_id_1       = var.env_private_subnet_1
  private_subnet_id_2       = var.env_private_subnet_2
  private_subnet_id_3       = var.env_private_subnet_3
  host_zone_id              = var.env_hosted_zone_id
  host_zone                 = var.env_hosted_zone
  vpc_id                    = var.env_vpc_id
  inbound_js_vnp_cidr_range = concat(var.env_js_vpn_cidr_range)
  inbound_js_app_cidr_range = concat(var.env_js_app_cidr_range)
  outbound_cidr_block_list  = concat(var.env_outbound_cidr_block_list)
  mq_live                   = var.live
  certificate_arn           = var.env_certificate_arn
  Enable_flag               = var.retail_host_provision



  #Broker URI
  broker_1_uri = var.retail_corp_broker_1_uri
  broker_2_uri = var.retail_corp_broker_2_uri
  broker_3_uri = var.retail_corp_broker_3_uri

}

# ---------------------------------------------------------------------------- #

# /* 
# Module Name     : Digital Online MQ
# Description     : Creating Digital Online MQ Active/Standup along with nlb and route 53 configuration
# Created By      : Phaneendra Boyapati
# Created Date    : 23/06/2021
# Modified By     : -
# Modified Date   : -
# */

module "digital_online_mq" {
  source = "./modules/amq/digital_online_mq"
  count  = var.digital_host_provision ? 1 : 0


  env                        = var.environment
  digital_engine_type        = var.amq_engine_type
  digital_engine_version     = var.amq_engine_version
  digital_host_instance_type = var.digital_host_instance_type
  private_subnet_id_1        = var.env_private_subnet_1
  private_subnet_id_2        = var.env_private_subnet_2
  private_subnet_id_3        = var.env_private_subnet_3
  host_zone_id               = var.env_hosted_zone_id
  host_zone                  = var.env_hosted_zone
  vpc_id                     = var.env_vpc_id
  inbound_js_vnp_cidr_range  = concat(var.env_js_vpn_cidr_range)
  inbound_js_app_cidr_range  = concat(var.env_js_app_cidr_range)
  outbound_cidr_block_list   = concat(var.env_outbound_cidr_block_list)
  mq_live                    = var.live
  certificate_arn            = var.env_certificate_arn
  env_vpc_cidr_range         = var.env_vpc_cidr_range
  Enable_flag                = var.digital_host_provision
}

# # ---------------------------------------------------------------------------- #

# # ---------------------------------------------------------------------------- #

# /* 
# Module Name     : r10 Epos MQ
# Description     : Creating r10 Epos MQ Stand Alone along with nlb and route 53 configuration
# Created By      : Phaneendra Boyapati
# Created Date    : 02/07/2021
# Modified By     : -
# Modified Date   : -
# */

module "r10_epos_mq" {
  source = "./modules/amq/r10_epos_mq"
  count  = var.r10epos_host_provision ? 1 : 0


  env                        = var.environment
  r10epos_engine_type        = var.amq_engine_type
  r10epos_engine_version     = var.amq_engine_version
  r10epos_host_instance_type = var.r10epos_host_instance_type
  private_subnet_id_1        = var.env_private_subnet_1
  private_subnet_id_2        = var.env_private_subnet_2
  private_subnet_id_3        = var.env_private_subnet_3
  private_ipaddress_1        = var.env_private_ipaddress_1
  private_ipaddress_2        = var.env_private_ipaddress_2
  private_ipaddress_3        = var.env_private_ipaddress_3
  host_zone_id               = var.env_hosted_zone_id
  host_zone                  = var.env_hosted_zone
  vpc_id                     = var.env_vpc_id
  inbound_js_vnp_cidr_range  = concat(var.env_js_vpn_cidr_range)
  inbound_js_app_cidr_range  = concat(var.env_js_app_cidr_range)
  outbound_cidr_block_list   = concat(var.env_outbound_cidr_block_list)
  mq_live                    = var.live
  certificate_arn            = var.env_certificate_arn
  Enable_flag                = var.r10epos_host_provision
}

/* moved {
  from = module.r10_epos_mq
  to   = module.r10_epos_mq[0]
} */


# # ---------------------------------------------------------------------------- #

# /* 
# Module Name     : Log Publishing Policy
# Description     : Creating Log Publishing Policy for AMQ
# Created By      : Phaneendra Boyapati
# Created Date    : 12/11/2021
# Modified By     : -
# Modified Date   : -
# */

module "amq_log_publishing_policy" {
  source = "./modules/amq/log_publishing_policy"
  env    = var.environment
}

# # ---------------------------------------------------------------------------- #

# # ---------------------------------------------------------------------------- #

# /* 
# Module Name     : API Gateway ALB
# Description     : Creating Network Load Balancer For API Gateway
# Created By      : Phaneendra Boyapati
# Created Date    : 20/07/2021
# Modified By     : -
# Modified Date   : -
# */

module "api_gateway_alb" {
  source = "./modules/apigateway/alb"

  env                       = var.environment
  private_subnet_id_1       = var.env_private_subnet_1
  private_subnet_id_2       = var.env_private_subnet_2
  private_subnet_id_3       = var.env_private_subnet_3
  listner_port_SIP          = var.listner_port_SIP
  listner_port_912          = var.listner_port_912
  listner_port_SIP_1011     = var.listner_port_SIP_1011
  listner_port_TN_1011      = var.listner_port_TN_1011
  vpc_id                    = var.env_vpc_id
  certificate_arn           = var.env_certificate_arn
  sip_ip_address            = var.env_sip_ip_address
  TN_ip_address             = var.env_TN_ip_address
  TN_1011_ip_address        = var.env_TN_1011_ip_address
  sip_1011_ip_address       = var.env_sip_1011_ip_address
  zone_id                   = var.env_hosted_zone_id
  inbound_js_app_cidr_range = concat(var.env_js_app_cidr_range)
  outbound_cidr_block_list  = concat(var.env_outbound_cidr_block_list)
}
# # ---------------------------------------------------------------------------- #

# # ---------------------------------------------------------------------------- #

# /* 
# Module Name     : Lamba Auth
# Description     : Creating Authentication for API Gateway Using Lamba Authentication
# Created By      : Amrit Wafa
# Created Date    : 20/08/2021
# Modified By     : -
# Modified Date   : -
# */

module "lambda_auth" {
  source = "./modules/apigateway/lambda"

  env  = var.environment
  role = var.aws_role
}

# # ---------------------------------------------------------------------------- #

# # ---------------------------------------------------------------------------- #

# /* 
# Module Name     : JS_Price_V01
# Description     : API for JSPrice Interface
# Created By      : Phaneendra Boyapati
# Created Date    : 20/07/2021
# Modified By     : -
# Modified Date   : -
# */

/* module "Js_Price_V01" {
  source = "./modules/apigateway/JS_Price"


  #jsprice_api_name         = "Js_Price_V01"
  jsprice_api_name         = var.jsprice_api_name
  jsprice_api_description  = "for Js_Price_V01"
  jsprice_api_path_part    = var.Js_Price_V01_api_path_part
  jsprice_api_method       = var.Js_Price_V01_api_method
  jsprice_integration_type = var.Js_Price_V01_integration_type
  jsprice_connection_type  = var.Js_Price_V01_connection_type
  api_vpc_endpoint_ids     = var.env_vpc_endpoint_ids
  api_vpc_link_id          = module.api_gateway_alb.api_vpc_link_id
  jsprice_uri              = var.Js_Price_V01_uri
  env                      = var.environment
} */

# #---------------------------------------------------------------------------------------#
# /* 
# Module Name     : pegaGetCustomer
# Description     : API for Pega Get Customer Interface
# Created By      : SaranKumar Kannan
# Created Date    : 26/07/2021
# Modified By     : -
# Modified Date   : -
# */

module "pega_GetCustomer" {
  source = "./modules/apigateway/PegaGetCustomer"


  #pega_GetCustomer_api_name         = "pega_GetCustomer"
  pega_GetCustomer_api_name             = var.pega_GetCustomer_api_name
  pega_GetCustomer_api_description      = "This API is used for Get Customer services for Pega"
  pega_GetCustomer_api_path_part        = var.pega_GetCustomer_api_path_part
  pega_GetCustomer_api_method           = var.pega_GetCustomer_api_method
  pega_GetCustomer_integration_type     = var.pega_GetCustomer_integration_type
  pega_GetCustomer_connection_type      = var.pega_GetCustomer_connection_type
  pega_GetCustomer_logging_level        = var.pega_GetCustomer_logging_level
  pega_GetCustomer_metrics_enabled_flag = var.pega_GetCustomer_metrics_enabled_flag
  api_vpc_link_id                       = module.api_gateway_alb.api_vpc_link_id
  pega_GetCustomer_uri                  = var.pega_GetCustomer_uri
  env                                   = var.environment
  pega_GetCustomer_api_mapping_path     = var.pega_GetCustomer_api_mapping_path
  lambda_authorizer_arn                 = module.lambda_auth.pega_common_lambda_authorizer_arn
  lamda_function_name                   = module.lambda_auth.pega_common_lambda_function_name
  pega_IP                               = concat(var.pega_IP)
  log_retention_days                    = var.log_retention_days
}


# #---------------------------------------------------------------------------------------#
# /* 
# Module Name     : pegaCreateCustomer
# Description     : API for Pega Get Customer Interface
# Created By      : VKV
# Created Date    : 27/07/2021
# Modified By     : -
# Modified Date   : -
# */
module "pega_CreateCustomer" {
  source = "./modules/apigateway/PegaCreateCustomer"


  #pega_CreateCustomer_api_name         = "pega_CreateCustomer"
  pega_CreateCustomer_api_name             = var.pega_CreateCustomer_api_name
  pega_CreateCustomer_api_description      = "This API is used for Create Customer services for Pega"
  pega_CreateCustomer_api_path_part        = var.pega_CreateCustomer_api_path_part
  pega_CreateCustomer_api_method           = var.pega_CreateCustomer_api_method
  pega_CreateCustomer_integration_type     = var.pega_CreateCustomer_integration_type
  pega_CreateCustomer_connection_type      = var.pega_CreateCustomer_connection_type
  api_vpc_link_id                          = module.api_gateway_alb.api_vpc_link_id
  pega_CreateCustomer_uri                  = var.pega_CreateCustomer_uri
  pega_CreateCustomer_logging_level        = var.pega_CreateCustomer_logging_level
  pega_CreateCustomer_metrics_enabled_flag = var.pega_CreateCustomer_metrics_enabled_flag
  env                                      = var.environment
  pega_CreateCustomer_api_mapping_path     = var.pega_CreateCustomer_api_mapping_path
  lambda_authorizer_arn                    = module.lambda_auth.pega_common_lambda_authorizer_arn
  lamda_function_name                      = module.lambda_auth.pega_common_lambda_function_name
  pega_IP                                  = concat(var.pega_IP)
  log_retention_days                       = var.log_retention_days
}

# #---------------------------------------------------------------------------------------#
# /* 
# Module Name     : pegaCreateEVoucher
# Description     : API for Pega Create EVoucher Interface
# Created By      : Ramalakshmi R
# Created Date    : 30/07/2021
# Modified By     : -
# Modified Date   : -
# */

module "pega_CreateEVoucher" {
  source = "./modules/apigateway/PegaCreateEVoucher"


  pegaEVoucher_api_name                 = var.pegaEVoucher_api_name
  pegaEVoucher_api_path_part            = var.pegaEVoucher_api_path_part
  pegaEVoucher_api_method               = var.pegaEVoucher_api_method
  pegaEVoucher_auth_type                = var.pegaEVoucher_auth_type
  pegaEVoucher_integration_type         = var.pegaEVoucher_integration_type
  pegaEVoucher_connection_type          = var.pegaEVoucher_connection_type
  api_vpc_link_id                       = module.api_gateway_alb.api_vpc_link_id
  pegaEVoucher_status_code              = var.pegaEVoucher_status_code
  pegaEVoucher_gatewayResponse          = var.pegaEVoucher_gatewayResponse
  pegaEVoucher_responseType             = var.pegaEVoucher_responseType
  pegaEVoucher_api_logging_level        = var.pegaEVoucher_api_logging_level
  pegaEVoucher_api_metrics_enabled_flag = var.pegaEVoucher_api_metrics_enabled_flag
  env                                   = var.environment
  pegaEVoucher_api_mapping_path_part    = var.pegaEVoucher_api_mapping_path_part
  lambda_authorizer_arn                 = module.lambda_auth.pega_common_lambda_authorizer_arn
  lamda_function_name                   = module.lambda_auth.pega_common_lambda_function_name
  pega_IP                               = concat(var.pega_IP)
  log_retention_days                    = var.log_retention_days
}

# #---------------------------------------------------------------------------------------#
# /* 
# Module Name     : pegaGetProductSupplier
# Description     : API for Pega Get Product Supplier Interface functionality
# Created By      : Ramalakshmi R
# Created Date    : 30/07/2021
# Modified By     : -
# Modified Date   : -
# */

module "pegaGetProductSupplier" {
  source = "./modules/apigateway/pegaGetProductSupplier"


  pega_ProductSupplier_api_name             = var.pega_ProductSupplier_api_name
  pega_ProductSupplier_api_description      = var.pega_ProductSupplier_api_description
  pega_ProductSupplier_api_path_part        = var.pega_ProductSupplier_api_path_part
  pega_ProductSupplier_api_method           = var.pega_ProductSupplier_api_method
  pega_ProductSupplier_auth_type            = var.pega_ProductSupplier_auth_type
  pega_ProductSupplier_integration_type     = var.pega_ProductSupplier_integration_type
  pega_ProductSupplier_connection_type      = var.pega_ProductSupplier_connection_type
  pega_ProductSupplier_logging_level        = var.pega_ProductSupplier_logging_level
  pega_ProductSupplier_metrics_enabled_flag = var.pega_ProductSupplier_metrics_enabled_flag
  pega_ProductSupplier_uri                  = var.pega_ProductSupplier_uri
  api_vpc_link_id                           = module.api_gateway_alb.api_vpc_link_id
  env                                       = var.environment
  pega_ProductSupplier_api_mapping_part     = var.pega_ProductSupplier_api_mapping_part
  lambda_authorizer_arn                     = module.lambda_auth.pega_common_lambda_authorizer_arn
  lamda_function_name                       = module.lambda_auth.pega_common_lambda_function_name
  pega_IP                                   = concat(var.pega_IP)
  log_retention_days                        = var.log_retention_days

}


# ###---------------------------------------------------------------------------------#
# /* 
# Module Name     : pegaSearchCustomer
# Description     : API for Pega search Customer Interface functionality
# Created By      : Nawaz Ali Shaik
# Created Date    : 11/08/2021
# Modified By     :  Nawaz Ali Shaik
# Modified Date   : 11/08/2021
# */

module "pegaSearchCustomer" {
  source = "./modules/apigateway/pegaSearchCustomer"


  pega_searchCustomer_api_name             = var.pega_searchCustomer_api_name
  pega_searchCustomer_api_description      = var.pega_searchCustomer_api_description
  pega_searchCustomer_api_path_part        = var.pega_searchCustomer_api_path_part
  pega_searchCustomer_api_method           = var.pega_searchCustomer_api_method
  pega_searchCustomer_auth_type            = var.pega_searchCustomer_auth_type
  pega_searchCustomer_integration_type     = var.pega_searchCustomer_integration_type
  pega_searchCustomer_connection_type      = var.pega_searchCustomer_connection_type
  pega_searchCustomer_logging_level        = var.pega_searchCustomer_logging_level
  pega_searchCustomer_metrics_enabled_flag = var.pega_searchCustomer_metrics_enabled_flag
  pega_searchCustomer_uri                  = var.pega_searchCustomer_uri
  api_vpc_link_id                          = module.api_gateway_alb.api_vpc_link_id
  env                                      = var.environment
  pega_searchCustomer_api_mapping_part     = var.pega_searchCustomer_api_mapping_part
  lambda_authorizer_arn                    = module.lambda_auth.pega_common_lambda_authorizer_arn
  lamda_function_name                      = module.lambda_auth.pega_common_lambda_function_name
  pega_IP                                  = concat(var.pega_IP)
  log_retention_days                       = var.log_retention_days
}


# ###---------------------------------------------------------------------------------#
# /* 
# Module Name     : pegaUpdateCustomer
# Description     : API for Pega update Customer Interface functionality
# Created By      : Nawaz Ali Shaik
# Created Date    : 11/08/2021
# Modified By     :  Nawaz Ali Shaik
# Modified Date   : 11/08/2021
# */

module "pegaUpdateCustomer" {
  source = "./modules/apigateway/PegaUpdateCustomer"


  pega_updateCustomer_api_name             = var.pega_updateCustomer_api_name
  pega_updateCustomer_api_description      = var.pega_updateCustomer_api_description
  pega_updateCustomer_api_path_part        = var.pega_updateCustomer_api_path_part
  pega_updateCustomer_api_method           = var.pega_updateCustomer_api_method
  pega_updateCustomer_auth_type            = var.pega_updateCustomer_auth_type
  pega_updateCustomer_integration_type     = var.pega_updateCustomer_integration_type
  pega_updateCustomer_connection_type      = var.pega_updateCustomer_connection_type
  pega_updateCustomer_uri                  = var.pega_updateCustomer_uri
  pega_updateCustomer_logging_level        = var.pega_updateCustomer_logging_level
  pega_updateCustomer_metrics_enabled_flag = var.pega_updateCustomer_metrics_enabled_flag
  api_vpc_link_id                          = module.api_gateway_alb.api_vpc_link_id
  env                                      = var.environment
  pega_updateCustomer_api_mapping_part     = var.pega_updateCustomer_api_mapping_part
  lambda_authorizer_arn                    = module.lambda_auth.pega_common_lambda_authorizer_arn
  lamda_function_name                      = module.lambda_auth.pega_common_lambda_function_name
  pega_IP                                  = concat(var.pega_IP)
  log_retention_days                       = var.log_retention_days
}


# ###---------------------------------------------------------------------------------#
# /* 
# Module Name     : pegaGetAddress
# Description     : API for Pega getting the address from GBG 
# Created By      : Nawaz Ali Shaik
# Created Date    : 12/08/2021
# Modified By     :  Nawaz Ali Shaik
# Modified Date   : 12/08/2021
# */

module "pegaGetAddress" {
  source = "./modules/apigateway/pegaGetAddress"


  pega_getAddress_api_name             = var.pega_getAddress_api_name
  pega_getAddress_api_description      = var.pega_getAddress_api_description
  pega_getAddress_api_path_part        = var.pega_getAddress_api_path_part
  pega_getAddress_api_method           = var.pega_getAddress_api_method
  pega_getAddress_auth_type            = var.pega_getAddress_auth_type
  pega_getAddress_integration_type     = var.pega_getAddress_integration_type
  pega_getAddress_connection_type      = var.pega_getAddress_connection_type
  pega_getAddress_uri                  = var.pega_getAddress_uri
  api_vpc_link_id                      = module.api_gateway_alb.api_vpc_link_id
  env                                  = var.environment
  pega_getAddress_api_mapping_part     = var.pega_getAddress_api_mapping_part
  lambda_authorizer_arn                = module.lambda_auth.pega_common_lambda_authorizer_arn
  lamda_function_name                  = module.lambda_auth.pega_common_lambda_function_name
  pega_IP                              = concat(var.pega_IP)
  pega_getAddress_logging_level        = var.pega_getAddress_logging_level
  pega_getAddress_metrics_enabled_flag = var.pega_getAddress_metrics_enabled_flag
  log_retention_days                   = var.log_retention_days
}
# ###----------------------------------------------------------------------#
# /* 
# Module Name     : C3_Reservations
# Description     : API for C3 Reservations Interface
# Created By      : SaranKumar Kannan
# Created Date    : 17/08/2021
# Modified By     : -
# Modified Date   : -
# */
module "C3_Reservations" {
  source = "./modules/apigateway/C3_Reservations"


  C3_Reservations_api_name              = var.C3_Reservations_api_name
  C3_Reservations_api_description       = "This API is used for C3 bookings "
  C3_Reservations_api_path_part         = var.C3_Reservations_api_path_part
  C3_Reservations_api_method            = var.C3_Reservations_api_method
  C3_Reservations_integration_type      = var.C3_Reservations_integration_type
  C3_Reservations_connection_type       = var.C3_Reservations_connection_type
  api_vpc_link_id                       = module.api_gateway_alb.api_vpc_link_id
  C3_Reservations_logging_level         = var.C3_Reservations_logging_level
  C3_Reservations_metrics_enable_flag   = var.C3_Reservations_metrics_enable_flag
  C3_Reservations_uri                   = var.C3_Reservations_uri
  env                                   = var.environment
  C3_Reservations_api_mapping_path      = var.C3_Reservations_api_mapping_path
  C3_Reservations_lambda_authorizer_arn = module.lambda_auth.C3Reservations_lambda_authorizer_arn
  C3_Reservations_lamda_function_name   = module.lambda_auth.C3Reservations_lamda_function_name
  C3_Reservations_IP                    = concat(var.C3_Reservations_IP)
  log_retention_days                    = var.log_retention_days
}
# ###-----------------------------------------------####
# ###----------------------------------------------------------------------#
# /* 
# Module Name     : Traceone
# Description     : API for Deal and terms Traceone services
# Created By      : SaranKumar Kannan
# Created Date    : 23/08/2021
# Modified By     : -
# Modified Date   : -
# */
module "Traceone" {
  source = "./modules/apigateway/Traceone"


  Traceone_api_name              = var.Traceone_api_name
  Traceone_api_description       = "This API is used for  Deal and terms Traceone services "
  Traceone_api_path_part         = var.Traceone_api_path_part
  Traceone_api_method            = var.Traceone_api_method
  Traceone_integration_type      = var.Traceone_integration_type
  Traceone_connection_type       = var.Traceone_connection_type
  Traceone_logging_level         = var.Traceone_logging_level
  Traceone_metrics_enabled_flag  = var.Traceone_metrics_enabled_flag
  api_vpc_link_id                = module.api_gateway_alb.api_vpc_link_id
  Traceone_uri                   = var.Traceone_uri
  Traceone_IP                    = concat(var.Traceone_IP)
  env                            = var.environment
  Traceone_api_mapping_path      = var.Traceone_api_mapping_path
  Traceone_lambda_authorizer_arn = module.lambda_auth.Traceone_lambda_authorizer_arn
  Traceone_lamda_function_name   = module.lambda_auth.Traceone_lamda_function_name
  log_retention_days             = var.log_retention_days

}
# ###-----------------------------------------------####
# /* 
# Module Name     : incidentManagement
# Description     : API for Incident management from Telephonica to Servicenow Interface functionality
# Created By      : Ramalakshmi R
# Created Date    : 25/08/2021
# Modified By     :  Ramalakshmi R
# Modified Date   : 17/11/2021
# */

module "incidentMgmt_Telephonica" {
  source = "./modules/apigateway/IncidentManagement_Telephonica"


  incidentMgmt_Telephonica_api_name             = var.incidentMgmt_Telephonica_api_name
  incidentMgmt_Telephonica_api_description      = var.incidentMgmt_Telephonica_api_description
  incidentMgmt_Telephonica_api_path_part        = var.incidentMgmt_Telephonica_api_path_part
  incidentMgmt_Telephonica_api_method1          = var.incidentMgmt_Telephonica_api_method1
  incidentMgmt_Telephonica_api_method2          = var.incidentMgmt_Telephonica_api_method2
  incidentMgmt_Telephonica_integration_type     = var.incidentMgmt_Telephonica_integration_type
  incidentMgmt_Telephonica_connection_type      = var.incidentMgmt_Telephonica_connection_type
  incidentMgmt_Telephonica_POST_uri             = var.incidentMgmt_Telephonica_POST_uri
  incidentMgmt_Telephonica_PUT_uri              = var.incidentMgmt_Telephonica_PUT_uri
  incidentMgmt_Telephonica_logging_level        = var.incidentMgmt_Telephonica_logging_level
  incidentMgmt_Telephonica_metrics_enabled_flag = var.incidentMgmt_Telephonica_metrics_enabled_flag
  incidentMgmt_Telephonica_status_code          = var.incidentMgmt_Telephonica_status_code
  api_vpc_link_id                               = module.api_gateway_alb.api_vpc_link_id
  env                                           = var.environment
  telefonica_lambda_authorizer_arn              = module.lambda_auth.telefonica_lambda_authorizer_arn
  telefonica_lamda_function_name                = module.lambda_auth.telefonica_lamda_function_name
  telephonica_allowedipaddresses                = concat(var.telephonica_allowedipaddresses)
  telephonica_api_mapping_part                  = var.telephonica_api_mapping_part
  log_retention_days                            = var.log_retention_days
}


# ###-----------------------------------------------####
# /* 
# Module Name     : SalesForce
# Description     : API for Incident management from Sales Force to RMSV9 Interface functionality
# Created By      : Nawaz Ali Shaik
# Created Date    : 04/09/2021
# Modified By     :  Nawaz Ali Shaik
# Modified Date   : 04/09/2021
# */

module "Salesforce" {
  source = "./modules/apigateway/Salesforce"


  salesforce_api_name              = var.salesforce_api_name
  salesforce_api_description       = var.salesforce_api_description
  salesforce_logging_level         = var.salesforce_logging_level
  salesforce_metrics_enabled_flag  = var.salesforce_metrics_enabled_flag
  createFixedDeal_api_path_part    = var.createFixedDeal_api_path_part
  createFixedDeal_api_method       = var.createFixedDeal_api_method
  createFixedDeal_auth_type        = var.createFixedDeal_auth_type
  createFixedDeal_integration_type = var.createFixedDeal_integration_type
  createFixedDeal_connection_type  = var.createFixedDeal_connection_type
  createFixedDeal_uri              = var.createFixedDeal_uri
  api_vpc_link_id                  = module.api_gateway_alb.api_vpc_link_id
  env                              = var.environment
  createFixedDeal_api_mapping_part = var.createFixedDeal_api_mapping_part

  salesforce_lambda_authorizer_arn = module.lambda_auth.salesforce_lambda_authorizer_arn
  salesforce_lamda_function_name   = module.lambda_auth.salesforce_lamda_function_name
  promoDeal_api_path_part          = var.promoDeal_api_path_part
  promoDeal_api_method             = var.promoDeal_api_method
  promoDeal_auth_type              = var.promoDeal_auth_type
  promoDeal_integration_type       = var.promoDeal_integration_type
  promoDeal_connection_type        = var.promoDeal_connection_type
  promoDeal_uri                    = var.promoDeal_uri
  salesforce_allowedipaddresses    = concat(var.salesforce_allowedipaddresses)
  log_retention_days               = var.log_retention_days
}
#---------------------------------------------------------------------------------------
# /* 
# Module Name     : hybris_Stock_Mgmt
# Description     : This API is used for hybris stocks inventory adjustments in RSS
# Created By      : SaranKumar Kannan
# Created Date    : 01/10/2021
# Modified By     : -
# Modified Date   : -
# */
module "hybris_Stock_Mgmt" {
  source = "./modules/apigateway/Hybris_Stock_Mgmt"


  hybris_Stock_Mgmt_api_name              = var.hybris_Stock_Mgmt_api_name
  hybris_Stock_Mgmt_api_description       = "This API is used for hybris stocks inventory adjustments in RSS"
  hybris_Stock_Mgmt_api_path_part         = var.hybris_Stock_Mgmt_api_path_part
  hybris_Stock_Mgmt_api_method            = var.hybris_Stock_Mgmt_api_method
  hybris_Stock_Mgmt_integration_type      = var.hybris_Stock_Mgmt_integration_type
  hybris_Stock_Mgmt_connection_type       = var.hybris_Stock_Mgmt_connection_type
  api_vpc_link_id                         = module.api_gateway_alb.api_vpc_link_id
  hybris_Stock_Mgmt_uri                   = var.hybris_Stock_Mgmt_uri
  env                                     = var.environment
  hybris_Stock_Mgmt_api_mapping_path      = var.hybris_Stock_Mgmt_api_mapping_path
  hybris_Stock_Mgmt_lambda_authorizer_arn = module.lambda_auth.hybris_Stock_Mgmt_lambda_authorizer_arn
  hybris_Stock_Mgmt_lambda_function_name  = module.lambda_auth.hybris_Stock_Mgmt_lambda_function_name
  hybris_Stock_Mgmt_IP                    = concat(var.hybris_Stock_Mgmt_IP)
  hybris_Stock_Mgmt_logging_level         = var.hybris_Stock_Mgmt_logging_level
  hybris_Stock_Mgmt_metrics_enabled_flag  = var.hybris_Stock_Mgmt_metrics_enabled_flag
  log_retention_days                      = var.log_retention_days

}
#----------------------------------------------------------------------------------------------------------------------------
#--------------------------------------------------------------------------------
# /* 
# Module Name     : otg
# Description     : API for sending OTG flows to SA2
# Created By      : Saran kumar and Amrit Wafa
# Created Date    : 05/10/2021
# Modified By     : -
# Modified Date   : -
# */
module "otg_common" {
  source = "./modules/apigateway/OTG"

  otg_common_api_name              = var.otg_common_api_name
  otg_common_api_description       = "This API is used for  sending OTG Sales to SA2"
  otg_sales_api_path_part          = var.otg_sales_api_path_part
  otg_Heartbeat_api_path_part      = var.otg_Heartbeat_api_path_part
  otg_EODKeys_api_path_part        = var.otg_EODKeys_api_path_part
  otg_EODTotals_api_path_part      = var.otg_EODTotals_api_path_part
  otg_common_api_method            = var.otg_common_api_method
  otg_common_integration_type      = var.otg_common_integration_type
  otg_common_connection_type       = var.otg_common_connection_type
  api_vpc_link_id                  = module.api_gateway_alb.api_vpc_link_id
  otg_common_logging_level         = var.otg_common_logging_level
  otg_common_metrics_enabled_flag  = var.otg_common_metrics_enabled_flag
  otg_sales_uri                    = var.otg_sales_uri
  otg_IP                           = concat(var.otg_IP)
  otg_Heartbeat_uri                = var.otg_Heartbeat_uri
  otg_EODKeys_uri                  = var.otg_EODKeys_uri
  otg_EODTotals_uri                = var.otg_EODTotals_uri
  env                              = var.environment
  otg_common_api_mapping_path      = var.otg_common_api_mapping_path
  otg_common_lambda_authorizer_arn = module.lambda_auth.otg_common_lambda_authorizer_arn
  otg_common_lambda_function_name  = module.lambda_auth.otg_common_lambda_function_name
  log_retention_days               = var.log_retention_days

}


#---------------------------------------------------------------------------------------#
/* 
Module Name     : Financial Calendar
Description     : API for Js Financial Calendar Interface
Created By      : Sreelekha Pusarapu
Created Date    : 19/10/2021
Modified By     : Sarankumar Kannan
Modified Date   : 17-01-2021
Comments        : Modified the resource for Financial Calender
*/
module "Js_Financial_Calendar_V01" {
  source = "./modules/apigateway/FinancialCalendar"


  Js_Financial_Calendar_V01_api_name             = var.Js_Financial_Calendar_V01_api_name
  Js_Financial_Calendar_V01_api_description      = "This API is used to provide financial calendar periodic wise to consumers"
  Js_Financial_Calendar_V01_api_path_part        = var.Js_Financial_Calendar_V01_api_path_part
  Js_Financial_Calendar_V01_api_method           = var.Js_Financial_Calendar_V01_api_method
  Js_Financial_Calendar_V01_integration_type     = var.Js_Financial_Calendar_V01_integration_type
  Js_Financial_Calendar_V01_connection_type      = var.Js_Financial_Calendar_V01_connection_type
  api_vpc_link_id                                = module.api_gateway_alb.api_vpc_link_id
  Js_Financial_Calendar_V01_uri                  = var.Js_Financial_Calendar_V01_uri
  Js_Financial_Calendar_V01_logging_level        = var.Js_Financial_Calendar_V01_logging_level
  Js_Financial_Calendar_V01_metrics_enabled_flag = var.Js_Financial_Calendar_V01_metrics_enabled_flag
  env                                            = var.environment
  Js_Financial_Calendar_V01_api_mapping_path     = var.Js_Financial_Calendar_V01_api_mapping_path
  FinancialCalendar_lambda_authorizer_arn        = module.lambda_auth.RetailApps_lambda_authorizer_arn
  FinancialCalendar_lamda_function_name          = module.lambda_auth.RetailApps_lambda_function_name
  retailapps_allowedipaddresses                  = concat(var.retailapps_allowedipaddresses)
  log_retention_days                             = var.log_retention_days
}
#--------------------------------------------------------------------------------------------
# /* 
# Module Name     : pegaGetOrderHistory
# Description     : API for Pega GetOrder History Interface
# Created By      : Swetha Manikandan
# Created Date    : 25/10/2021
# Modified By     : -
# Modified Date   : -
# */

module "pega_GetOrderHistory" {
  source = "./modules/apigateway/pegaGetOrderHistory"



  pega_GetOrderHistory_api_name             = var.pega_GetOrderHistory_api_name
  pega_GetOrderHistory_api_description      = "This API is used for Get Order history services for Pega"
  pega_GetOrderHistory_api_path_part        = var.pega_GetOrderHistory_api_path_part
  pega_GetOrderHistory_api_method           = var.pega_GetOrderHistory_api_method
  pega_GetOrderHistory_integration_type     = var.pega_GetOrderHistory_integration_type
  pega_GetOrderHistory_connection_type      = var.pega_GetOrderHistory_connection_type
  pega_GetOrderHistory_logging_level        = var.pega_GetOrderHistory_logging_level
  pega_GetOrderHistory_metrics_enabled_flag = var.pega_GetOrderHistory_metrics_enabled_flag
  api_vpc_link_id                           = module.api_gateway_alb.api_vpc_link_id
  pega_GetOrderHistory_uri                  = var.pega_GetOrderHistory_uri
  env                                       = var.environment
  pega_GetOrderHistory_api_mapping_path     = var.pega_GetOrderHistory_api_mapping_path
  lambda_authorizer_arn                     = module.lambda_auth.pega_common_lambda_authorizer_arn
  lamda_function_name                       = module.lambda_auth.pega_common_lambda_function_name
  pega_IP                                   = concat(var.pega_IP)
  log_retention_days                        = var.log_retention_days
}
#-----------------------------------------------------------------------------------------------

# ###-----------------------------------------------####
# /* 
# Module Name     : incidentManagement
# Description     : API for Incident management from FIS to Servicenow Interface functionality
# Created By      : NawazAli Shaik
# Created Date    : 15/03/2022
# Modified By     :  NawazAli Shaik
# Modified Date   : 15/03/2022
# */

module "FIS_incidentmanagement" {
  source = "./modules/apigateway/FIS"


  FIS_incidentmanagement_api_name             = var.FIS_incidentmanagement_api_name
  FIS_incidentmanagement_api_description      = var.FIS_incidentmanagement_api_description
  FIS_incidentmanagement_api_path_part_save   = var.FIS_incidentmanagement_api_path_part_save
  FIS_incidentmanagement_api_path_part_submit = var.FIS_incidentmanagement_api_path_part_submit
  FIS_incidentmanagement_api_path_part_update = var.FIS_incidentmanagement_api_path_part_update
  FIS_incidentmanagement_api_method           = var.FIS_incidentmanagement_api_method
  FIS_incidentmanagement_integration_type     = var.FIS_incidentmanagement_integration_type
  FIS_incidentmanagement_connection_type      = var.FIS_incidentmanagement_connection_type
  FIS_incidentmanagement_save_uri             = var.FIS_incidentmanagement_save_uri
  FIS_incidentmanagement_submit_uri           = var.FIS_incidentmanagement_submit_uri
  FIS_incidentmanagement_update_uri           = var.FIS_incidentmanagement_update_uri
  FIS_incidentmanagement_logging_level        = var.FIS_incidentmanagement_logging_level
  FIS_incidentmanagement_metrics_enabled_flag = var.FIS_incidentmanagement_metrics_enabled_flag
  FIS_incidentmanagement_status_code          = var.FIS_incidentmanagement_status_code
  api_vpc_link_id                             = module.api_gateway_alb.api_vpc_link_id
  env                                         = var.environment
  FIS_lambda_authorizer_arn                   = module.lambda_auth.FIS_lambda_authorizer_arn
  FIS_lambda_function_name                    = module.lambda_auth.FIS_lambda_function_name
  FIS_allowedipaddresses                      = concat(var.FIS_allowedipaddresses)
  FIS_api_mapping_part                        = var.FIS_api_mapping_part
  log_retention_days                          = var.log_retention_days
}
