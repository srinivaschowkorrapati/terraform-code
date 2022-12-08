# tfvars file for development environment
environment = "prod"
env_vpc_id  = "vpc-020377b85960d26d1"
region      = "eu-west-1"

aws_role = "app-intg-platform-prod-lambda-iam-auth-role"

# Security Group and Subnet details
#env_security_group   = "sg-0d90aea2c037e54a0"
env_private_subnet_1    = "subnet-0071614aee6a6a46f"
env_private_subnet_2    = "subnet-0446a00fe81d4dc53"
env_private_subnet_3    = "subnet-00684c83109b94138"
env_private_ipaddress_1 = "10.15.37.12"
env_private_ipaddress_2 = "10.15.37.126"
env_private_ipaddress_3 = "10.15.37.136"

env_js_vpn_cidr_range        = ["172.16.0.0/12", "172.31.0.0/16", "192.168.0.0/16"]
env_js_app_cidr_range        = ["10.0.0.0/8"]
env_outbound_cidr_block_list = ["0.0.0.0/0"]
env_vpc_cidr_range           = ["10.15.37.0/24"]
#----------Temp to be removed ----------#
env_inbound_cidr_block_list = ["10.0.0.0/8", "172.16.0.0/12", "172.31.0.0/16", "192.168.0.0/16", "100.64.64.0/18", "100.64.128.0/18", "100.64.0.0/18"]

#Hosted Zone details
env_hosted_zone_id = "Z06840421E8M6OE9U1TZO"
env_hosted_zone    = "prod.iprm.js-devops.co.uk"

#Certificate Details
env_certificate_arn = "arn:aws:acm:eu-west-1:011518296717:certificate/a0c992df-ee08-41ee-b628-ca6c81276e68"

#Common Tags Variables
costcenter         = "pd7020"
dataRetention      = "1-year"
dataClassification = "confidential"
live               = "yes"


# ------------------------------------------------------------------------------- #
# AMQ Specific Vairables
amq_engine_type        = "ActiveMQ"
amq_engine_version     = "5.16.5"
env_host_instance_type = "mq.m5.large"

digital_host_instance_type = "mq.m5.large"
retail_host_instance_type  = "mq.m5.xlarge"
r10epos_host_instance_type = "mq.m5.xlarge"

# AMQ Provision Flag
digital_host_provision = true
retail_host_provision  = true
r10epos_host_provision = false

# Retail Corp AMQ URI
retail_corp_broker_1_uri = "ssl://b-1e015528-338b-499f-9719-6661be585177-1.mq.eu-west-1.amazonaws.com:61617"
retail_corp_broker_2_uri = "ssl://b-5365af03-b77d-4643-959d-ced6b45e0e12-1.mq.eu-west-1.amazonaws.com:61617"
retail_corp_broker_3_uri = "ssl://b-fbb99d1a-7262-41ab-96f2-78baa02fecfe-1.mq.eu-west-1.amazonaws.com:61617"

# ------------------------------------------------------------------------------- #

#API variables

listner_port_SIP     = "15003"
listner_port_912     = "15100"
env_sip_ip_address   = ["10.174.42.105", "10.174.42.106", "10.174.42.177", "10.174.42.178"]
env_TN_ip_address    = ["10.176.6.86", "10.176.6.84"]
env_vpc_endpoint_ids = ["vpce-044eaf9c3e5690f8d"]
log_retention_days   = 7

#----------------------#API interfaces Modules Variables----------------------------#

#JS PRICE API VARIABLES
jsprice_api_name              = "Js_Price_V01"
Js_Price_V01_api_path_part    = "Js_Price_VS_01"
Js_Price_V01_api_method       = "POST"
Js_Price_V01_integration_type = "HTTP_PROXY"
Js_Price_V01_connection_type  = "VPC_LINK"
Js_Price_V01_uri              = "https://$${stageVariables.username}:$${stageVariables.password}@$${stageVariables.server}:$${stageVariables.port}/rest/Js_Price_V01/"

#-----------------------------------------------------------------------------------#
#PEGA GET CUSTOMER API VARIABLES
pega_GetCustomer_api_name             = "pega_GetCustomer"
pega_GetCustomer_api_path_part        = "GetCustomer"
pega_GetCustomer_api_method           = "POST"
pega_GetCustomer_integration_type     = "HTTP_PROXY"
pega_GetCustomer_connection_type      = "VPC_LINK"
pega_GetCustomer_logging_level        = "INFO"
pega_GetCustomer_metrics_enabled_flag = "true"
pega_GetCustomer_uri                  = "https://$${stageVariables.server}:$${stageVariables.port}/ws/Js_B2B_CustomerMgmt_Customer.provider:getCustomer/Js_B2B_CustomerMgmt_Customer_provider_getCustomer_Port"
pega_GetCustomer_api_mapping_path     = "pegaGetCustomerresource"
pega_IP                               = ["52.31.240.161/32", "34.246.10.74/32", "52.17.243.68/32", "54.246.144.8/32", "18.202.62.25/32", "54.229.122.229/32", "34.251.170.204/32", "34.253.79.151/32", "34.252.103.209/32", "18.202.151.37/32", "52.211.23.87/32", "34.253.144.116/32", "34.254.147.82/32", "18.200.157.116/32"]

#-----------------------------------------------------------------------------------#
#PEGA CREATE CUSTOMER API VARIABLES
pega_CreateCustomer_api_name             = "pega_CreateCustomer"
pega_CreateCustomer_api_path_part        = "pega_CreateCustomer"
pega_CreateCustomer_api_method           = "POST"
pega_CreateCustomer_integration_type     = "HTTP_PROXY"
pega_CreateCustomer_connection_type      = "VPC_LINK"
pega_CreateCustomer_uri                  = "https://$${stageVariables.server}:$${stageVariables.port}/ws/Js_B2B_CustomerMgmt_Customer.provider:createCustomer/Js_B2B_CustomerMgmt_Customer_provider_createCustomer_Port"
pega_CreateCustomer_api_mapping_path     = "pegaCreateCustomerresource"
pega_CreateCustomer_logging_level        = "INFO"
pega_CreateCustomer_metrics_enabled_flag = "true"
#-----------------------------------------------------------------------------------#

#-----------------------------------------------------------------------------------#
#PEGA CREATE EVOUCHER API VARIABLES
pegaEVoucher_api_name                 = "pega_createEVoucher"
pegaEVoucher_api_path_part            = "createEVoucher"
pegaEVoucher_api_method               = "POST"
pegaEVoucher_integration_type         = "HTTP_PROXY"
pegaEVoucher_connection_type          = "VPC_LINK"
pegaEVoucher_auth_type                = "CUSTOM"
pegaEVoucher_status_code              = "200"
pegaEVoucher_gatewayResponse          = "401"
pegaEVoucher_responseType             = "UNAUTHORIZED"
pegaEVoucher_api_mapping_path_part    = "PegaCreateEVoucher"
pegaEVoucher_api_logging_level        = "INFO"
pegaEVoucher_api_metrics_enabled_flag = "true"
#-----------------------------------------------------------------------------------#
#-----------------------------------------------------------------------------------#
#PEGA GET PRODUCT SUPPLIER API VARIABLES
pega_ProductSupplier_api_name             = "pega_getProductSupplier"
pega_ProductSupplier_api_description      = "API created for 9.12 Pega get Product Supplier Interface"
pega_ProductSupplier_api_path_part        = "getProductSupplier"
pega_ProductSupplier_api_method           = "POST"
pega_ProductSupplier_auth_type            = "CUSTOM"
pega_ProductSupplier_integration_type     = "HTTP_PROXY"
pega_ProductSupplier_connection_type      = "VPC_LINK"
pega_ProductSupplier_logging_level        = "INFO"
pega_ProductSupplier_metrics_enabled_flag = "true"
pega_ProductSupplier_uri                  = "https://$${stageVariables.server}:$${stageVariables.port}/ws/Js_B2B_CustomerMgmt_CIHA.provider:getProdSupplier/Js_B2B_CustomerMgmt_CIHA_provider_getProdSupplier_Port"
pega_ProductSupplier_api_mapping_part     = "PegaGetProductSupplier"
#-----------------------------------------------------------------------------------#


#----------------------------------------------------------------------#
# pega search customer api variables----------------------------#
pega_searchCustomer_api_name             = "pega_searchCustomer"
pega_searchCustomer_api_description      = "API created for 9.12 Pega to sereach the customer details"
pega_searchCustomer_api_path_part        = "searchCustomer"
pega_searchCustomer_api_method           = "POST"
pega_searchCustomer_auth_type            = "CUSTOM"
pega_searchCustomer_integration_type     = "HTTP_PROXY"
pega_searchCustomer_connection_type      = "VPC_LINK"
pega_searchCustomer_logging_level        = "INFO"
pega_searchCustomer_metrics_enabled_flag = "true"
pega_searchCustomer_uri                  = "https://$${stageVariables.server}:$${stageVariables.port}/ws/Js_B2B_CustomerMgmt_Customer.provider:searchCustomer/Js_B2B_CustomerMgmt_Customer_provider_searchCustomer_Port"
pega_searchCustomer_api_mapping_part     = "PegaSearchCustomer"

#---------------------------------------------------------------------#



#----------------------------------------------------------------------#
# pega update customer api variables----------------------------#
pega_updateCustomer_api_name             = "pega_updateCustomer"
pega_updateCustomer_api_description      = "API created for 9.12 Pega to update the customer details"
pega_updateCustomer_api_path_part        = "updateCustomer"
pega_updateCustomer_api_method           = "POST"
pega_updateCustomer_auth_type            = "CUSTOM"
pega_updateCustomer_integration_type     = "HTTP_PROXY"
pega_updateCustomer_connection_type      = "VPC_LINK"
pega_updateCustomer_logging_level        = "INFO"
pega_updateCustomer_metrics_enabled_flag = "true"
pega_updateCustomer_uri                  = "https://$${stageVariables.server}:$${stageVariables.port}/ws/Js_B2B_CustomerMgmt_Customer.provider:updateCustomer/Js_B2B_CustomerMgmt_Customer_provider_updateCustomer_Port"
pega_updateCustomer_api_mapping_part     = "PegaUpdateCustomer"

#---------------------------------------------------------------------#


#----------------------------------------------------------------------#
# pega get address from gbg api variables----------------------------#
pega_getAddress_api_name             = "pega_getAddress"
pega_getAddress_api_description      = "API created for 9.12 Pega to get the address from gbg"
pega_getAddress_api_path_part        = "getAddress"
pega_getAddress_api_method           = "POST"
pega_getAddress_auth_type            = "CUSTOM"
pega_getAddress_integration_type     = "HTTP_PROXY"
pega_getAddress_connection_type      = "VPC_LINK"
pega_getAddress_uri                  = "https://$${stageVariables.server}:$${stageVariables.port}/ws/Js_Cmr_PEGA_CustomerMgmt.customerAddress.services.webservices.provider:GetAddress_WSD/Js_Cmr_PEGA_CustomerMgmt_customerAddress_services_webservice_provider_GetAddress_WSD_Port"
pega_getAddress_api_mapping_part     = "PegaGetAddress"
pega_getAddress_logging_level        = "INFO"
pega_getAddress_metrics_enabled_flag = "true"
#---------------------------------------------------------------------#
C3_Reservations_api_name            = "C3_Reservations"
C3_Reservations_api_path_part       = "send_C3Bookings"
C3_Reservations_api_method          = "POST"
C3_Reservations_integration_type    = "HTTP_PROXY"
C3_Reservations_connection_type     = "VPC_LINK"
C3_Reservations_logging_level       = "INFO"
C3_Reservations_metrics_enable_flag = "true"
C3_Reservations_uri                 = "https://$${stageVariables.server}:$${stageVariables.port}/ws/Js_B2B_InventoryPurchaseOrderMgmt_C3.provider:C3ReservationUpdate/ReservationUpdateWebServicePort"
C3_Reservations_api_mapping_path    = "C3_Reservations_Management"
C3_Reservations_IP                  = ["209.226.83.2/31", "209.226.83.4/30", "209.226.83.8/29", "209.226.83.16/28", "209.226.228.226/31", "209.226.228.228/30", "209.226.228.232/29", "209.226.228.240/29", "209.226.228.248/30", "209.226.228.252/31", "209.226.228.254/32"]
#------------------------------------------------------------------------#
# Traceone API variables
Traceone_api_name             = "Traceone"
Traceone_api_path_part        = "TraceoneDealsandTerms"
Traceone_api_method           = "POST"
Traceone_integration_type     = "HTTP_PROXY"
Traceone_connection_type      = "VPC_LINK"
Traceone_logging_level        = "INFO"
Traceone_metrics_enabled_flag = "true"
Traceone_uri                  = "https://$${stageVariables.server}:$${stageVariables.port}/ws/Js_B2B_PricePromoMgmt_TraceOne.wsd.provider:createFixedDealClaim/Js_B2B_PricePromoMgmt_TraceOne_wsd_provider_createFixedDealClaim_Port"
Traceone_api_mapping_path     = "Traceoneresource"
Traceone_IP                   = ["162.217.244.130/32"]
###------------------------------------------------------


###------------------------------------------------------
# Incident Management from Telephonica to Service now
incidentMgmt_Telephonica_api_name             = "incidentMgmt_Telephonica"
incidentMgmt_Telephonica_api_description      = "API created for implementing incident management functionality from Telephonica to Service now in wM 9.7"
incidentMgmt_Telephonica_api_path_part        = "telefonicaIncidentMgmt"
incidentMgmt_Telephonica_api_method1          = "POST"
incidentMgmt_Telephonica_api_method2          = "PUT"
incidentMgmt_Telephonica_integration_type     = "HTTP_PROXY"
incidentMgmt_Telephonica_connection_type      = "VPC_LINK"
incidentMgmt_Telephonica_logging_level        = "INFO"
incidentMgmt_Telephonica_metrics_enabled_flag = "true"
incidentMgmt_Telephonica_POST_uri             = "https://$${stageVariables.server}:$${stageVariables.port}/rest/Js_Cmr_Generic_IncidentManagement/incidentMgmt/V01/restful/receiveIncident"
incidentMgmt_Telephonica_PUT_uri              = "https://$${stageVariables.server}:$${stageVariables.port}/rest/Js_Cmr_Generic_IncidentManagement/incidentMgmt/V01/restful/receiveIncident"
incidentMgmt_Telephonica_status_code          = "200"
telephonica_allowedipaddresses                = ["148.139.2.8/29", "148.139.3.8/29"]
telephonica_api_mapping_part                  = "incidentManagement"
###--------------------------------------------------------------

# New Relic Variables
newrelic_role_flag = 0

#----------------------------------------------------------------------#
# Sales force fixed deal api variables----------------------------#
salesforce_api_name              = "SalesForceDeal"
salesforce_api_description       = "API created for 9.12 sales force fixed deals"
salesforce_logging_level         = "INFO"
salesforce_metrics_enabled_flag  = "true"
createFixedDeal_api_path_part    = "createFixedDeal"
createFixedDeal_api_method       = "POST"
createFixedDeal_auth_type        = "CUSTOM"
createFixedDeal_integration_type = "HTTP_PROXY"
createFixedDeal_connection_type  = "VPC_LINK"
createFixedDeal_uri              = "https://$${stageVariables.server}:$${stageVariables.port}/ws/Js_B2B_PricePromoMgmt_SalesForce.wsd.provider:createFixedDeal/createFixedDeal_Port"
createFixedDeal_api_mapping_part = "salesforceDeal"
# Sales force promo deal api variables----------------------------#
promoDeal_api_path_part       = "createPromoDeal"
promoDeal_api_method          = "POST"
promoDeal_auth_type           = "CUSTOM"
promoDeal_integration_type    = "HTTP_PROXY"
promoDeal_connection_type     = "VPC_LINK"
promoDeal_uri                 = "https://$${stageVariables.server}:$${stageVariables.port}/ws/Js_B2B_PricePromoMgmt_SalesForce.wsd.provider:createPromoDeal/createPromoDeal_Port"
promoDeal_api_mapping_part    = "salesforceDeal"
salesforce_allowedipaddresses = ["161.71.0.0/17", "161.71.14.8/32", "109.94.138.128/32", "109.94.138.129/32", "109.94.138.130/32", "109.94.137.128/32", "109.94.137.129/32", "109.94.137.130/32"]
#---------------------------------------------------------------------#
#---------------------------------------------------------------------#
#Hybris Stock Mgmgt VARIABLES
hybris_Stock_Mgmt_api_name             = "hybris_Stock_Mgmt"
hybris_Stock_Mgmt_api_path_part        = "shelf_returns"
hybris_Stock_Mgmt_api_method           = "POST"
hybris_Stock_Mgmt_integration_type     = "HTTP_PROXY"
hybris_Stock_Mgmt_connection_type      = "VPC_LINK"
hybris_Stock_Mgmt_uri                  = "https://$${stageVariables.server}:$${stageVariables.port}/rest/Js_Cmr_Hybris_StockMgmt_V01/stockmgmt/restful/shelf_returns"
hybris_Stock_Mgmt_api_mapping_path     = "StockMgmt"
hybris_Stock_Mgmt_logging_level        = "INFO"
hybris_Stock_Mgmt_IP                   = ["52.208.72.21/32"]
hybris_Stock_Mgmt_metrics_enabled_flag = "true"
#-------------------------------------------------------------------------
#---------------------------------------------------------------------#
#OTG SALES VARIABLES
otg_common_api_name             = "otg"
otg_sales_api_path_part         = "SalesTransaction"
otg_Heartbeat_api_path_part     = "Heartbeat"
otg_EODKeys_api_path_part       = "EODKeys"
otg_EODTotals_api_path_part     = "EODTotals"
otg_common_api_method           = "POST"
otg_common_integration_type     = "HTTP_PROXY"
otg_common_connection_type      = "VPC_LINK"
otg_common_logging_level        = "INFO"
otg_common_metrics_enabled_flag = "true"
otg_sales_uri                   = "https://$${stageVariables.server}:$${stageVariables.port}/rest/Js_Cmr_SalesTxnMgt_V01/salesTxnMgt/restful/SalesTransaction"
otg_Heartbeat_uri               = "https://$${stageVariables.server}:$${stageVariables.port}/rest/Js_Cmr_SalesTxnMgt_V01/salesTxnMgt/restful/Heartbeat"
otg_EODKeys_uri                 = "https://$${stageVariables.server}:$${stageVariables.port}/rest/Js_Cmr_SalesTxnMgt_V01/salesTxnMgt/restful/EODKeys"
otg_EODTotals_uri               = "https://$${stageVariables.server}:$${stageVariables.port}/rest/Js_Cmr_SalesTxnMgt_V01/salesTxnMgt/restful/EODTotals"
otg_common_api_mapping_path     = "SalesTransaction_Mgmt"
otg_IP                          = ["52.174.181.178/32", "52.174.36.1/32", "52.174.20.18/32", "52.174.199.92/32", "52.174.37.89/32", "52.136.249.82/32", "52.136.254.200/32"]
#------------------------------------------------------------------------------
#PEGA GET Order History API VARIABLES
pega_GetOrderHistory_api_name             = "pega_GetOrderHistory"
pega_GetOrderHistory_api_path_part        = "getOrderHistory"
pega_GetOrderHistory_api_method           = "POST"
pega_GetOrderHistory_integration_type     = "HTTP_PROXY"
pega_GetOrderHistory_connection_type      = "VPC_LINK"
pega_GetOrderHistory_logging_level        = "INFO"
pega_GetOrderHistory_metrics_enabled_flag = "true"
pega_GetOrderHistory_uri                  = "https://$${stageVariables.server}:$${stageVariables.port}/ws/Js_B2B_CustomerMgmt_OHA.provider:getOrderHistory/Js_B2B_CustomerMgmt_OHA_provider_getOrderHistory_Port"
pega_GetOrderHistory_api_mapping_path     = "pegaGetOrderHistory"
#---------------------------------------------------------------------------------------

#---------------------------------------------------------------------#
#Js Financial Calendar API VARIABLES
Js_Financial_Calendar_V01_api_name             = "Js_Financial_Calendar_V01"
Js_Financial_Calendar_V01_api_description      = "Fincail calendar service for getting the periodic dates"
Js_Financial_Calendar_V01_api_path_part        = "Js_Financial_Calendar_V01"
Js_Financial_Calendar_V01_api_method           = "GET"
Js_Financial_Calendar_V01_integration_type     = "HTTP_PROXY"
Js_Financial_Calendar_V01_connection_type      = "VPC_LINK"
Js_Financial_Calendar_V01_logging_level        = "INFO"
Js_Financial_Calendar_V01_metrics_enabled_flag = "true"
Js_Financial_Calendar_V01_uri                  = "https://$${stageVariables.server}:$${stageVariables.port}/rest/Js_Cmr_FinancialCalendar/financialCalendar/V01/restful/financial_calendars"
Js_Financial_Calendar_V01_api_mapping_path     = "FinancialCalendarresource"
retailapps_allowedipaddresses                  = ["20.191.57.46/32", "109.94.138.128/32", "109.94.138.129/32", "109.94.138.130/32", "109.94.137.128/32", "109.94.137.129/32", "109.94.137.130/32"]

###------------------------------------------------------
# Incident Management from FIS to Service now
FIS_incidentmanagement_api_name             = "incidentMgmt_FIS"
FIS_incidentmanagement_api_description      = "API created for implementing incident management functionality from FIS to Service now in wM 9.12"
FIS_incidentmanagement_api_path_part_save   = "submitWorkflow"
FIS_incidentmanagement_api_path_part_submit = "submitIncident"
FIS_incidentmanagement_api_path_part_update = "updateIncident"
FIS_incidentmanagement_api_method           = "POST"
FIS_incidentmanagement_integration_type     = "HTTP_PROXY"
FIS_incidentmanagement_connection_type      = "VPC_LINK"
FIS_incidentmanagement_logging_level        = "INFO"
FIS_incidentmanagement_metrics_enabled_flag = "true"
FIS_incidentmanagement_save_uri             = "https://$${stageVariables.server}:$${stageVariables.port}/ws/Js_ITSMOutbound_FIS.wsd.providers:submitWorkInfo/Js_ITSMOutbound_FIS_wsd_providers_submitWorkInfo_Port"
FIS_incidentmanagement_submit_uri           = "https://$${stageVariables.server}:$${stageVariables.port}/ws/Js_ITSMOutbound_FIS.wsd.providers:submitIncident/Js_ITSMOutbound_FIS_wsd_providers_submitIncident_Port"
FIS_incidentmanagement_update_uri           = "https://$${stageVariables.server}:$${stageVariables.port}/ws/Js_ITSMOutbound_FIS.wsd.providers:updateIncident/Js_ITSMOutbound_FIS_wsd_providers_updateIncident_Port"
FIS_incidentmanagement_status_code          = "200"
FIS_allowedipaddresses                      = ["199.91.136.8/29", "199.91.140.8/29", "109.94.138.128", "109.94.138.129", "109.94.138.130", "109.94.137.128", "109.94.137.129", "109.94.137.130"]
FIS_api_mapping_part                        = "FIS"
###--------------------------------------------------------------