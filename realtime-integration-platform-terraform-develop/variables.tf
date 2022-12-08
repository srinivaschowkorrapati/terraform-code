#Environment Variable declaration
variable "environment" {
  type    = string
  default = ""

}

variable "env_vpc_id" {
  type    = string
  default = ""

}

variable "region" {
  type    = string
  default = ""

}

#Temp Variable

variable "aws_role" {
  type    = string
  default = ""

}

#Security Group and Subnet variables Declaration
variable "env_security_group" {
  type    = string
  default = ""
}

variable "env_inbound_cidr_block_list" {
  type    = list(string)
  default = [""]

}

variable "env_js_vpn_cidr_range" {
  type    = list(string)
  default = [""]

}

variable "env_vpc_cidr_range" {
  type    = list(string)
  default = [""]

}


variable "env_js_app_cidr_range" {
  type    = list(string)
  default = [""]

}

variable "env_outbound_cidr_block_list" {
  type    = list(string)
  default = [""]

}

variable "env_private_subnet_1" {
  type    = string
  default = ""
}

variable "env_private_subnet_2" {
  type    = string
  default = ""
}

variable "env_private_subnet_3" {
  type    = string
  default = ""
}
variable "env_private_ipaddress_1" {
  type    = string
  default = ""
}

variable "env_private_ipaddress_2" {
  type    = string
  default = ""
}

variable "env_private_ipaddress_3" {
  type    = string
  default = ""
}


#Hosted Zone variable declaration
variable "env_hosted_zone_id" {
  type    = string
  default = ""

}

variable "env_hosted_zone" {
  type    = string
  default = ""
}

#AMQ Variables declaration
variable "amq_engine_type" {
  type    = string
  default = ""

}

variable "amq_engine_version" {
  type    = string
  default = ""

}

variable "env_host_instance_type" {
  type    = string
  default = ""

}

variable "r10epos_host_instance_type" {
  type    = string
  default = ""

}

variable "retail_host_instance_type" {
  type    = string
  default = ""

}

variable "digital_host_instance_type" {
  type    = string
  default = ""
}

variable "digital_host_provision" {
  type    = bool
  default = true

}

variable "retail_host_provision" {
  type    = bool
  default = true

}

variable "r10epos_host_provision" {
  type    = bool
  default = true

}

#Common Tags Declaration
variable "costcenter" {
  description = "Cost Centre of the application"
  default     = ""
}

variable "email" {
  description = "Email address of the creator"
  default     = ""
}

variable "dataRetention" {
  description = "Data Retention period for the data stored in the resource"
  default     = ""
}

variable "dataClassification" {
  description = "Data Classification of the data stored in the resource"
  default     = ""
}

variable "live" {
  description = "Whether or not the application went live to Production"
  default     = "no"
}

variable "env_certificate_arn" {

  description = "Certificate details for Listener"
  type        = string
  default     = ""
}


#---------------------------------------------------------------------------------------------------#

#Reatil Corp MQ URI Variable Declaration

variable "retail_corp_broker_1_uri" {
  type    = string
  default = ""

}

variable "retail_corp_broker_2_uri" {
  type    = string
  default = ""

}

variable "retail_corp_broker_3_uri" {
  type    = string
  default = ""

}

#---------------------------------------------------------------------------------------------------#
#API Gateway infra variables

variable "log_retention_days" {
  type    = number
  default = 0

}

variable "listner_port_SIP" {
  type    = string
  default = ""
}



variable "listner_port_SIP_1011" {
  type    = string
  default = ""
}

variable "listner_port_912" {
  type    = string
  default = ""
}

variable "listner_port_TN_1011" {
  type    = string
  default = ""
}

variable "env_sip_ip_address" {
  type    = list(string)
  default = [""]

}

variable "env_sip_1011_ip_address" {
  type    = list(string)
  default = [""]

}
variable "env_TN_ip_address" {
  type    = list(string)
  default = [""]

}
variable "env_TN_1011_ip_address" {
  type    = list(string)
  default = [""]

}
variable "stage_name" {
  type    = string
  default = ""
}

variable "stage_description" {
  type    = string
  default = ""
}

variable "env_vpc_endpoint_ids" {
  type    = list(string)
  default = [""]

}
#----------------------#API interfaces variables-----------------------------------------------#
# JSPrice Interface

variable "jsprice_api_name" {
  type    = string
  default = ""

}

variable "Js_Price_V01_api_path_part" {
  type    = string
  default = ""
}

variable "Js_Price_V01_api_method" {
  type    = string
  default = ""
}

variable "Js_Price_V01_integration_type" {
  type    = string
  default = ""
}

variable "Js_Price_V01_connection_type" {
  type    = string
  default = ""
}

variable "JS_api_vpc_endpoint_ids" {
  type    = string
  default = ""
}

variable "Js_Price_V01_uri" {
  type    = string
  default = ""
}
#-----------------------------------------------------------
variable "pega_IP" {
  type    = list(string)
  default = [""]
}
variable "pega_GetCustomer_api_name" {
  type    = string
  default = ""
}

variable "pega_GetCustomer_api_path_part" {
  type    = string
  default = ""
}

variable "pega_GetCustomer_api_method" {
  type    = string
  default = ""
}


variable "pega_GetCustomer_integration_type" {
  type    = string
  default = ""
}

variable "pega_GetCustomer_connection_type" {
  type    = string
  default = ""
}
variable "pega_GetCustomer_api_mapping_path" {
  type    = string
  default = ""
}

variable "pega_GetCustomer_logging_level" {
  type    = string
  default = ""
}
variable "pega_GetCustomer_metrics_enabled_flag" {
  type    = string
  default = ""
}

variable "pega_GetCustomer_uri" {
  type    = string
  default = ""
}
#---------------------------------------------------

variable "pega_CreateCustomer_api_name" {
  type    = string
  default = ""

}

variable "pega_CreateCustomer_api_path_part" {
  type    = string
  default = ""
}

variable "pega_CreateCustomer_api_method" {
  type    = string
  default = ""
}


variable "pega_CreateCustomer_integration_type" {
  type    = string
  default = ""
}

variable "pega_CreateCustomer_connection_type" {
  type    = string
  default = ""
}
variable "pega_CreateCustomer_api_mapping_path" {
  type    = string
  default = ""
}
variable "pega_CreateCustomer_logging_level" {
  type    = string
  default = ""
}
variable "pega_CreateCustomer_metrics_enabled_flag" {
  type    = string
  default = ""
}


variable "pega_CreateCustomer_uri" {
  type    = string
  default = ""
}
#---------------------------------------------------
#Pega Create EVoucher variables

variable "pegaEVoucher_api_name" {
  type    = string
  default = ""
}

variable "pegaEVoucher_api_path_part" {
  type    = string
  default = ""
}

variable "pegaEVoucher_api_method" {
  type    = string
  default = ""
}

variable "pegaEVoucher_auth_type" {
  type    = string
  default = ""
}

variable "pegaEVoucher_integration_type" {
  type    = string
  default = ""
}

variable "pegaEVoucher_connection_type" {
  type    = string
  default = ""
}

/*variable "pegaEVoucher_uri" {
  type    = string
  default = ""
}*/

variable "pegaEVoucher_status_code" {
  type    = string
  default = ""
}

variable "pegaEVoucher_api_logging_level" {
  type    = string
  default = ""
}
variable "pegaEVoucher_api_metrics_enabled_flag" {
  type    = string
  default = ""
}

variable "pegaEVoucher_gatewayResponse" {
  type    = string
  default = ""
}

variable "pegaEVoucher_responseType" {
  type    = string
  default = ""
}

variable "pegaEVoucher_api_mapping_path_part" {
  type    = string
  default = ""
}

#---------------------------------------------------
#Pega Get Product Supplier variables
variable "pega_ProductSupplier_api_name" {
  type    = string
  default = ""
}
variable "pega_ProductSupplier_api_description" {
  type    = string
  default = ""
}
variable "pega_ProductSupplier_api_path_part" {
  type    = string
  default = ""
}
variable "pega_ProductSupplier_api_method" {
  type    = string
  default = ""
}
variable "pega_ProductSupplier_auth_type" {
  type    = string
  default = ""
}
variable "pega_ProductSupplier_logging_level" {
  type    = string
  default = ""
}
variable "pega_ProductSupplier_metrics_enabled_flag" {
  type    = string
  default = ""
}
variable "pega_ProductSupplier_integration_type" {
  type    = string
  default = ""
}
variable "pega_ProductSupplier_connection_type" {
  type    = string
  default = ""
}
variable "pega_ProductSupplier_uri" {
  type    = string
  default = ""
}

variable "pega_ProductSupplier_api_mapping_part" {
  type    = string
  default = ""
}

#--------------------------------------------------------#
### pega search customer variables
variable "pega_searchCustomer_api_name" {
  type    = string
  default = ""
}
variable "pega_searchCustomer_api_description" {
  type    = string
  default = ""
}
variable "pega_searchCustomer_api_path_part" {
  type    = string
  default = ""
}
variable "pega_searchCustomer_api_method" {
  type    = string
  default = ""
}
variable "pega_searchCustomer_auth_type" {
  type    = string
  default = ""
}
variable "pega_searchCustomer_integration_type" {
  type    = string
  default = ""
}
variable "pega_searchCustomer_connection_type" {
  type    = string
  default = ""
}
variable "pega_searchCustomer_logging_level" {
  type    = string
  default = ""
}
variable "pega_searchCustomer_metrics_enabled_flag" {
  type    = string
  default = ""
}
variable "pega_searchCustomer_uri" {
  type    = string
  default = ""
}


variable "pega_searchCustomer_api_mapping_part" {
  type    = string
  default = ""
}




#--------------------------------------------------------#
### pega update customer variables
variable "pega_updateCustomer_api_name" {
  type    = string
  default = ""
}
variable "pega_updateCustomer_api_description" {
  type    = string
  default = ""
}
variable "pega_updateCustomer_api_path_part" {
  type    = string
  default = ""
}
variable "pega_updateCustomer_api_method" {
  type    = string
  default = ""
}
variable "pega_updateCustomer_auth_type" {
  type    = string
  default = ""
}
variable "pega_updateCustomer_integration_type" {
  type    = string
  default = ""
}
variable "pega_updateCustomer_connection_type" {
  type    = string
  default = ""
}
variable "pega_updateCustomer_uri" {
  type    = string
  default = ""
}

variable "pega_updateCustomer_logging_level" {
  type    = string
  default = ""
}
variable "pega_updateCustomer_metrics_enabled_flag" {
  type    = string
  default = ""
}

variable "pega_updateCustomer_api_mapping_part" {
  type    = string
  default = ""
}


#--------------------------------------------------------#
### pega get Address variables
variable "pega_getAddress_api_name" {
  type    = string
  default = ""
}
variable "pega_getAddress_api_description" {
  type    = string
  default = ""
}
variable "pega_getAddress_api_path_part" {
  type    = string
  default = ""
}
variable "pega_getAddress_api_method" {
  type    = string
  default = ""
}
variable "pega_getAddress_auth_type" {
  type    = string
  default = ""
}
variable "pega_getAddress_integration_type" {
  type    = string
  default = ""
}
variable "pega_getAddress_connection_type" {
  type    = string
  default = ""
}
variable "pega_getAddress_logging_level" {
  type    = string
  default = ""
}
variable "pega_getAddress_metrics_enabled_flag" {
  type    = string
  default = ""
}
variable "pega_getAddress_uri" {
  type    = string
  default = ""
}


variable "pega_getAddress_api_mapping_part" {
  type    = string
  default = ""
}

##----------------------------------------------------#
#C3 Reservations
variable "C3_Reservations_api_name" {
  type    = string
  default = ""
}

variable "C3_Reservations_api_path_part" {
  type    = string
  default = ""
}

variable "C3_Reservations_api_method" {
  type    = string
  default = ""
}


variable "C3_Reservations_integration_type" {
  type    = string
  default = ""
}

variable "C3_Reservations_connection_type" {
  type    = string
  default = ""
}
variable "C3_Reservations_api_mapping_path" {
  type    = string
  default = ""
}

variable "C3_Reservations_uri" {
  type    = string
  default = ""
}
variable "C3_Reservations_IP" {
  type    = list(string)
  default = [""]

}
variable "C3_Reservations_logging_level" {
  type    = string
  default = ""
}

variable "C3_Reservations_metrics_enable_flag" {
  type    = string
  default = ""
}
###------------------------------------------------------------------
#Traceone Reservations
variable "Traceone_api_name" {
  type    = string
  default = ""
}

variable "Traceone_api_path_part" {
  type    = string
  default = ""
}

variable "Traceone_api_method" {
  type    = string
  default = ""
}

variable "Traceone_logging_level" {
  type    = string
  default = ""
}
variable "Traceone_metrics_enabled_flag" {
  type    = string
  default = ""
}

variable "Traceone_integration_type" {
  type    = string
  default = ""
}

variable "Traceone_connection_type" {
  type    = string
  default = ""
}
variable "Traceone_api_mapping_path" {
  type    = string
  default = ""
}

variable "Traceone_uri" {
  type    = string
  default = ""
}
variable "Traceone_IP" {
  type    = list(string)
  default = [""]
}
##------------------------------------------------------------------------
##Incident Management from Telephonica to Service now##

variable "telephonica_allowedipaddresses" {
  type    = list(string)
  default = [""]
}

variable "incidentMgmt_Telephonica_api_name" {
  type    = string
  default = ""
}
variable "incidentMgmt_Telephonica_api_description" {
  type    = string
  default = ""
}
variable "incidentMgmt_Telephonica_logging_level" {
  type    = string
  default = ""
}
variable "incidentMgmt_Telephonica_metrics_enabled_flag" {
  type    = string
  default = ""
}
variable "incidentMgmt_Telephonica_api_path_part" {
  type    = string
  default = ""
}

variable "telephonica_api_mapping_part" {
  type    = string
  default = ""
}
variable "incidentMgmt_Telephonica_api_method1" {
  type    = string
  default = ""
}
variable "incidentMgmt_Telephonica_api_method2" {
  type    = string
  default = ""
}
variable "incidentMgmt_Telephonica_integration_type" {
  type    = string
  default = ""
}
variable "incidentMgmt_Telephonica_connection_type" {
  type    = string
  default = ""
}
variable "incidentMgmt_Telephonica_POST_uri" {
  type    = string
  default = ""
}
variable "incidentMgmt_Telephonica_PUT_uri" {
  type    = string
  default = ""
}
variable "incidentMgmt_Telephonica_status_code" {
  type    = string
  default = ""
}

variable "newrelic_role_flag" {
  type    = string
  default = ""
}
######-------------------------------------------------
##############sales force variables #############
variable "salesforce_allowedipaddresses" {
  type    = list(string)
  default = [""]
}
variable "salesforce_api_name" {
  type    = string
  default = ""
}

variable "salesforce_api_description" {
  type    = string
  default = ""
}
variable "salesforce_logging_level" {
  type    = string
  default = ""
}
variable "salesforce_metrics_enabled_flag" {
  type    = string
  default = ""
}
variable "createFixedDeal_api_path_part" {
  type    = string
  default = ""
}

variable "createFixedDeal_api_method" {
  type    = string
  default = ""
}

variable "createFixedDeal_auth_type" {
  type    = string
  default = ""
}

variable "createFixedDeal_integration_type" {
  type    = string
  default = ""
}


variable "createFixedDeal_connection_type" {
  type    = string
  default = ""
}

variable "createFixedDeal_uri" {
  type    = string
  default = ""
}

variable "createFixedDeal_api_mapping_part" {
  type    = string
  default = ""
}

variable "salesforce_lambda_authorizer_arn" {
  type    = string
  default = ""
}

variable "salesforce_lamda_function_name" {
  type    = string
  default = ""
}

variable "promoDeal_api_path_part" {
  type    = string
  default = ""
}

variable "promoDeal_api_method" {
  type    = string
  default = ""
}

variable "promoDeal_auth_type" {
  type    = string
  default = ""
}

variable "promoDeal_integration_type" {
  type    = string
  default = ""
}

variable "promoDeal_connection_type" {
  type    = string
  default = ""
}

variable "promoDeal_uri" {
  type    = string
  default = ""
}

variable "promoDeal_api_mapping_part" {
  type    = string
  default = ""
}
#------------------------------------------------------------------------------------------
#Hybris Stock Mgmt variables
variable "hybris_Stock_Mgmt_api_name" {
  type    = string
  default = ""
}
variable "hybris_Stock_Mgmt_api_description" {
  type    = string
  default = ""
}

variable "hybris_Stock_Mgmt_api_path_part" {
  type    = string
  default = ""
}

variable "hybris_Stock_Mgmt_api_method" {
  type    = string
  default = ""
}


variable "hybris_Stock_Mgmt_integration_type" {
  type    = string
  default = ""
}

variable "hybris_Stock_Mgmt_connection_type" {
  type    = string
  default = ""
}

variable "hybris_Stock_Mgmt_uri" {
  type    = string
  default = ""
}

variable "hybris_Stock_Mgmt_api_mapping_path" {
  type    = string
  default = ""
}

variable "hybris_Stock_Mgmt_IP" {
  type    = list(string)
  default = [""]

}

variable "hybris_Stock_Mgmt_logging_level" {
  type    = string
  default = ""
}

variable "hybris_Stock_Mgmt_metrics_enabled_flag" {
  type    = string
  default = ""
}
#---------------------------------------------------------------------------------------
#OTG Common variables
variable "otg_common_api_name" {
  type    = string
  default = ""
}
variable "otg_common_api_description" {
  type    = string
  default = ""
}
variable "otg_common_logging_level" {
  type    = string
  default = ""
}
variable "otg_common_metrics_enabled_flag" {
  type    = string
  default = ""
}

variable "otg_sales_api_path_part" {
  type    = string
  default = ""
}
variable "otg_Heartbeat_api_path_part" {
  type    = string
  default = ""
}
variable "otg_EODKeys_api_path_part" {
  type    = string
  default = ""
}
variable "otg_EODTotals_api_path_part" {
  type    = string
  default = ""
}

variable "otg_common_api_method" {
  type    = string
  default = ""
}


variable "otg_common_integration_type" {
  type    = string
  default = ""
}

variable "otg_common_connection_type" {
  type    = string
  default = ""
}

variable "otg_IP" {
  type    = list(string)
  default = [""]
}

variable "otg_sales_uri" {
  type    = string
  default = ""
}
variable "otg_Heartbeat_uri" {
  type    = string
  default = ""
}
variable "otg_EODKeys_uri" {
  type    = string
  default = ""
}
variable "otg_EODTotals_uri" {
  type    = string
  default = ""
}

variable "otg_common_api_mapping_path" {
  type    = string
  default = ""
}

#---------------------------------------------------------------------------------------

####----------------------------#
####### Financial Clendar variables ------#
variable "Js_Financial_Calendar_V01_api_name" {
  type    = string
  default = ""
}
variable "Js_Financial_Calendar_V01_api_description" {
  type    = string
  default = ""
}


variable "Js_Financial_Calendar_V01_api_path_part" {
  type    = string
  default = ""
}

variable "Js_Financial_Calendar_V01_api_method" {
  type    = string
  default = ""
}

variable "Js_Financial_Calendar_V01_integration_type" {
  type    = string
  default = ""
}

variable "Js_Financial_Calendar_V01_connection_type" {
  type    = string
  default = ""
}


variable "Js_Financial_Calendar_V01_uri" {
  type    = string
  default = ""
}

variable "Js_Financial_Calendar_V01_api_mapping_path" {
  type    = string
  default = ""
}

variable "retailapps_allowedipaddresses" {
  type    = list(string)
  default = [""]
}

variable "Js_Financial_Calendar_V01_logging_level" {
  type    = string
  default = ""
}
variable "Js_Financial_Calendar_V01_metrics_enabled_flag" {
  type    = string
  default = ""
}
#------------------------------------------------------------------------------------------------
######## Pega Get order History Variables
variable "pega_GetOrderHistory_api_name" {
  type    = string
  default = ""
}
variable "pega_GetOrderHistory_api_description" {
  type    = string
  default = ""
}

variable "pega_GetOrderHistory_api_path_part" {
  type    = string
  default = ""
}

variable "pega_GetOrderHistory_api_method" {
  type    = string
  default = ""
}

variable "pega_GetOrderHistory_logging_level" {
  type    = string
  default = ""
}
variable "pega_GetOrderHistory_metrics_enabled_flag" {
  type    = string
  default = ""
}

variable "pega_GetOrderHistory_integration_type" {
  type    = string
  default = ""
}

variable "pega_GetOrderHistory_connection_type" {
  type    = string
  default = ""
}


variable "pega_GetOrderHistory_uri" {
  type    = string
  default = ""
}

variable "pega_GetOrderHistory_api_mapping_path" {
  type    = string
  default = ""
}
#---------------------------------------------------------------------------------------------------------

########### FIS incident managment variables############################
variable "FIS_incidentmanagement_api_name" {
  type    = string
  default = ""
}
variable "FIS_incidentmanagement_api_description" {
  type    = string
  default = ""
}
variable "FIS_incidentmanagement_logging_level" {
  type    = string
  default = ""
}
variable "FIS_incidentmanagement_metrics_enabled_flag" {
  type    = string
  default = ""
}
variable "FIS_incidentmanagement_api_path_part_save" {
  type    = string
  default = ""
}
variable "FIS_incidentmanagement_api_path_part_submit" {
  type    = string
  default = ""
}
variable "FIS_incidentmanagement_api_path_part_update" {
  type    = string
  default = ""
}
variable "FIS_incidentmanagement_api_method" {
  type    = string
  default = ""
}

variable "FIS_incidentmanagement_integration_type" {
  type    = string
  default = ""
}
variable "FIS_incidentmanagement_connection_type" {
  type    = string
  default = ""
}
variable "FIS_incidentmanagement_save_uri" {
  type    = string
  default = ""
}
variable "FIS_incidentmanagement_submit_uri" {
  type    = string
  default = ""
}
variable "FIS_incidentmanagement_update_uri" {
  type    = string
  default = ""
}

variable "FIS_api_mapping_part" {
  type    = string
  default = ""
}
variable "FIS_incidentmanagement_status_code" {
  type    = string
  default = ""
}

variable "FIS_allowedipaddresses" {
  type    = list(string)
  default = [""]
}