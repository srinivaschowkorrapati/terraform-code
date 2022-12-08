# tfvars file for development environment
environment = "vnp"
env_vpc_id  = "vpc-0c994beee6762769e"
region      = "eu-west-1"

#Temp Variable

aws_role = "app-intg-platform-vnp-lambda-iam-auth-role"

# Security Group and Subnet details
#env_security_group   = "sg-0d90aea2c037e54a0"
env_private_subnet_1         = "subnet-0913b062450492de7"
env_private_subnet_2         = "subnet-0c8d92a25421b3b0d"
env_private_subnet_3         = "subnet-00133536dedcbc5ea"
env_private_ipaddress_1      = "10.14.157.33"
env_private_ipaddress_2      = "10.14.157.94"
env_private_ipaddress_3      = "10.14.157.150"
env_js_vpn_cidr_range        = ["172.16.0.0/12", "172.31.0.0/16", "192.168.0.0/16"]
env_js_app_cidr_range        = ["10.0.0.0/8"]
env_outbound_cidr_block_list = ["0.0.0.0/0"]
env_vpc_cidr_range           = ["10.14.157.0/24"]
#----------Temp to be removed ----------#
env_inbound_cidr_block_list = ["10.0.0.0/8", "172.16.0.0/12", "172.31.0.0/16", "192.168.0.0/16", "100.64.64.0/18", "100.64.128.0/18", "100.64.0.0/18"]

#Hosted Zone details
env_hosted_zone_id = "Z00691861YKNSKDNXJ7RM"
env_hosted_zone    = "vnp.iprm.js-devops.co.uk"

#Certificate Details
env_certificate_arn = "arn:aws:acm:eu-west-1:283989899963:certificate/bf173b83-ec1e-4e12-8279-8e9416c8f370"

#Common Tags Variables
costcenter         = "pd7020"
dataRetention      = "1-year"
dataClassification = "confidential"
live               = "no"


# ------------------------------------------------------------------------------- #
# AMQ Specific Vairables
amq_engine_type        = "ActiveMQ"
amq_engine_version     = "5.16.5"
env_host_instance_type = "mq.m5.large"

digital_host_instance_type = "mq.m5.large"
retail_host_instance_type  = "mq.m5.2xlarge"
r10epos_host_instance_type = "mq.m5.xlarge"

# AMQ Provision Flag
digital_host_provision = true
retail_host_provision  = true
r10epos_host_provision = true

# Retail Corp AMQ URI
retail_corp_broker_1_uri = "ssl://b-bb28499f-a60f-495f-8484-09bf22ddf104-1.mq.eu-west-1.amazonaws.com:61617"
retail_corp_broker_2_uri = "ssl://b-bfea5e44-cafa-473d-be1f-d3d4602551aa-1.mq.eu-west-1.amazonaws.com:61617"
retail_corp_broker_3_uri = "ssl://b-48daf978-9937-4aee-88ee-fab0f57f3e20-1.mq.eu-west-1.amazonaws.com:61617"

# ------------------------------------------------------------------------------- #

#API variables

listner_port_SIP        = "15003"
listner_port_912        = "15100"
listner_port_SIP_1011   = "17003"
listner_port_TN_1011    = "17100"
env_sip_ip_address      = ["10.146.45.178", "10.146.45.179", "10.146.44.133", "10.146.44.134"]
env_TN_ip_address       = ["10.177.5.231", "10.177.5.232"]
env_TN_1011_ip_address  = ["10.177.6.7", "10.177.6.8"]
env_sip_1011_ip_address = ["10.146.45.123", "10.146.45.124", "10.146.45.28", "10.146.45.29"]
env_vpc_endpoint_ids    = ["vpce-0356ce16a7c657763"]
log_retention_days      = 7

#----------------------#API interfaces Modules Variables----------------------------#
#JS PRICE API VARIABLES
jsprice_api_name              = "Js_Price_V01"
Js_Price_V01_api_path_part    = "Js_Price_VS_01"
Js_Price_V01_api_method       = "POST"
Js_Price_V01_integration_type = "HTTP_PROXY"
Js_Price_V01_connection_type  = "VPC_LINK"
#JS_api_vpc_endpoint_ids         = "vpce-0356ce16a7c657763"
Js_Price_V01_uri = "https://$${stageVariables.username}:$${stageVariables.password}@$${stageVariables.server}:$${stageVariables.port}/rest/Js_Price_V01/"

#-----------------------------------------------------------------------------------#
#PEGA GET CUSTOMER API VARIABLES
pega_GetCustomer_api_name             = "pega_GetCustomer"
pega_GetCustomer_api_path_part        = "GetCustomer"
pega_GetCustomer_api_method           = "POST"
pega_GetCustomer_integration_type     = "HTTP_PROXY"
pega_GetCustomer_connection_type      = "VPC_LINK"
pega_GetCustomer_logging_level        = "ERROR"
pega_GetCustomer_metrics_enabled_flag = "true"
pega_GetCustomer_uri                  = "https://$${stageVariables.server}:$${stageVariables.port}/ws/Js_B2B_CustomerMgmt_Customer.provider:getCustomer/Js_B2B_CustomerMgmt_Customer_provider_getCustomer_Port"
pega_GetCustomer_api_mapping_path     = "pegaGetCustomerresource"
pega_IP                               = ["34.255.203.174/32", "34.255.203.159/32", "34.255.203.192/32", "34.255.203.39/32", "34.255.203.121/32", "34.255.203.72/32", "34.255.203.53/32", "34.255.203.152/32", "34.255.203.120/32", "34.255.203.170/32", "34.255.203.141/32", "34.255.203.110/32", "34.254.143.205/32", "34.249.105.213/32", "54.73.66.218/32", "52.213.85.122/32", "63.34.208.151/32", "3.248.72.197/32", "52.208.80.216/32", "99.81.224.28/32", "63.33.119.208/32", "52.16.27.142/32", "54.195.169.177/32", "34.254.18.1/32", "3.248.0.242/32", "34.247.63.183/32", "34.248.81.54/32", "52.30.127.71/32", "52.49.24.42/32", "54.76.219.137/32", "54.246.203.34/32", "52.48.178.56/32", "34.248.155.95/32", "52.16.90.93/32", "54.77.52.113/32", "52.213.106.105/32", "63.34.68.180/32", "54.76.99.88/32", "52.51.155.147/32", "34.253.155.81/32", "3.248.77.141/32", "3.248.119.67/32", "54.171.68.225/32", "34.252.108.41/32", "52.209.254.20/32", "34.248.178.82/32", "99.81.113.202/32", "18.202.200.109/32", "52.16.183.233/32", "63.33.232.112/32", "18.202.103.178/32", "99.80.76.4/32", "52.210.26.174/32", "52.50.32.242/32", "63.34.212.123/32", "108.128.164.59/32", "18.200.159.163/32", "34.246.119.127/32", "34.243.155.133/32", "52.31.95.150/32", "52.213.54.81/32", "54.76.92.21/32", "52.50.70.1/32", "34.250.70.99/32", "34.245.255.10/32", "52.18.133.217/32", "54.229.46.43/32", "18.202.110.150/32", "34.251.224.173/32", "52.51.150.86/32", "52.208.157.172/32", "3.251.42.4/32", "3.248.13.0/32"]
#-----------------------------------------------------------------------------------#
#PEGA CREATE CUSTOMER API VARIABLES
pega_CreateCustomer_api_name             = "pega_CreateCustomer"
pega_CreateCustomer_api_path_part        = "pega_CreateCustomer"
pega_CreateCustomer_api_method           = "POST"
pega_CreateCustomer_integration_type     = "HTTP_PROXY"
pega_CreateCustomer_connection_type      = "VPC_LINK"
pega_CreateCustomer_uri                  = "https://$${stageVariables.server}:$${stageVariables.port}/ws/Js_B2B_CustomerMgmt_Customer.provider:createCustomer/Js_B2B_CustomerMgmt_Customer_provider_createCustomer_Port"
pega_CreateCustomer_api_mapping_path     = "pegaCreateCustomerresource"
pega_CreateCustomer_logging_level        = "ERROR"
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
pega_ProductSupplier_logging_level        = "ERROR"
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
pega_searchCustomer_logging_level        = "ERROR"
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
pega_updateCustomer_logging_level        = "ERROR"
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
pega_getAddress_logging_level        = "ERROR"
pega_getAddress_metrics_enabled_flag = "true"
#---------------------------------------------------------------------#
C3_Reservations_api_name            = "C3_Reservations"
C3_Reservations_api_path_part       = "send_C3Bookings"
C3_Reservations_api_method          = "POST"
C3_Reservations_integration_type    = "HTTP_PROXY"
C3_Reservations_connection_type     = "VPC_LINK"
C3_Reservations_logging_level       = "ERROR"
C3_Reservations_metrics_enable_flag = "true"
C3_Reservations_uri                 = "https://$${stageVariables.server}:$${stageVariables.port}/ws/Js_B2B_InventoryPurchaseOrderMgmt_C3.provider:C3ReservationUpdate/ReservationUpdateWebServicePort"
C3_Reservations_api_mapping_path    = "C3_Reservations_Management"
C3_Reservations_IP                  = ["209.226.83.2/31", "209.226.83.4/30", "209.226.83.8/29", "209.226.83.16/28", "209.226.228.226/31", "209.226.228.228/30", "209.226.228.232/29", "209.226.228.240/29", "209.226.228.248/30", "209.226.228.252/31", "209.226.228.254/32", "3.251.42.4/32", "52.208.157.172/32", "3.251.42.4/32", "3.248.13.0/32"]
#------------------------------------------------------------------------#
# Traceone API variables
Traceone_api_name             = "Traceone"
Traceone_api_path_part        = "TraceoneDealsandTerms"
Traceone_api_method           = "POST"
Traceone_integration_type     = "HTTP_PROXY"
Traceone_connection_type      = "VPC_LINK"
Traceone_logging_level        = "ERROR"
Traceone_metrics_enabled_flag = "true"
Traceone_uri                  = "https://$${stageVariables.server}:$${stageVariables.port}/ws/Js_B2B_PricePromoMgmt_TraceOne.wsd.provider:createFixedDealClaim/Js_B2B_PricePromoMgmt_TraceOne_wsd_provider_createFixedDealClaim_Port"
Traceone_api_mapping_path     = "Traceoneresource"
Traceone_IP                   = ["162.217.244.131/32", "162.217.244.133/32", "52.208.157.172/32", "3.251.42.4/32", "3.248.13.0/32"]
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
incidentMgmt_Telephonica_logging_level        = "ERROR"
incidentMgmt_Telephonica_metrics_enabled_flag = "true"
incidentMgmt_Telephonica_POST_uri             = "https://$${stageVariables.server}:$${stageVariables.port}/rest/Js_Cmr_Generic_IncidentManagement/incidentMgmt/V01/restful/receiveIncident"
incidentMgmt_Telephonica_PUT_uri              = "https://$${stageVariables.server}:$${stageVariables.port}/rest/Js_Cmr_Generic_IncidentManagement/incidentMgmt/V01/restful/receiveIncident"
incidentMgmt_Telephonica_status_code          = "200"
telephonica_allowedipaddresses                = ["148.139.2.8/29", "148.139.3.8/29", "52.208.157.172/32", "3.251.42.4/32", "3.248.13.0/32", "148.139.2.212/32", "148.139.2.214/32", "148.139.18.3/32", "148.139.14.3/32"]
telephonica_api_mapping_part                  = "incidentManagement"
###--------------------------------------------------------------

# New Relic Variables

newrelic_role_flag = 1


#----------------------------------------------------------------------#
# Sales force fixed deal api variables----------------------------#
salesforce_api_name              = "SalesForceDeal"
salesforce_api_description       = "API created for 9.12 sales force fixed deals"
salesforce_logging_level         = "ERROR"
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
salesforce_allowedipaddresses = ["161.71.0.0/17", "109.94.138.128/32", "109.94.138.129/32", "109.94.138.130/32", "109.94.137.128/32", "109.94.137.129/32", "109.94.137.130/32", "52.208.157.172/32", "3.251.42.4/32", "3.248.13.0/32"]
#---------------------------------------------------------------------#
#Hybris Stock Mgmgt VARIABLES
hybris_Stock_Mgmt_api_name         = "hybris_Stock_Mgmt"
hybris_Stock_Mgmt_api_path_part    = "shelf_returns"
hybris_Stock_Mgmt_api_method       = "POST"
hybris_Stock_Mgmt_integration_type = "HTTP_PROXY"
hybris_Stock_Mgmt_connection_type  = "VPC_LINK"
hybris_Stock_Mgmt_uri              = "https://$${stageVariables.server}:$${stageVariables.port}/rest/Js_Cmr_Hybris_StockMgmt_V01/stockmgmt/restful/shelf_returns"
hybris_Stock_Mgmt_api_mapping_path = "StockMgmt"
hybris_Stock_Mgmt_IP               = ["52.208.72.21/32", "52.208.157.172/32", "3.251.42.4/32", "3.248.13.0/32"]
#New Hybris Stock Mgmgt VARIABLES
hybris_Stock_Mgmt_logging_level        = "ERROR"
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
otg_common_logging_level        = "ERROR"
otg_common_metrics_enabled_flag = "true"
otg_sales_uri                   = "https://$${stageVariables.server}:$${stageVariables.port}/rest/Js_Cmr_SalesTxnMgt_V01/salesTxnMgt/restful/SalesTransaction"
otg_Heartbeat_uri               = "https://$${stageVariables.server}:$${stageVariables.port}/rest/Js_Cmr_SalesTxnMgt_V01/salesTxnMgt/restful/Heartbeat"
otg_EODKeys_uri                 = "https://$${stageVariables.server}:$${stageVariables.port}/rest/Js_Cmr_SalesTxnMgt_V01/salesTxnMgt/restful/EODKeys"
otg_EODTotals_uri               = "https://$${stageVariables.server}:$${stageVariables.port}/rest/Js_Cmr_SalesTxnMgt_V01/salesTxnMgt/restful/EODTotals"
otg_common_api_mapping_path     = "SalesTransaction_Mgmt"
otg_IP                          = ["20.71.75.100/32", "20.71.75.133/32", "20.71.75.198/32", "20.71.75.237/32", "20.71.76.1/32", "20.71.76.23/32", "20.71.76.57/32", "20.71.76.171/32", "20.71.76.196/32", "20.71.77.10/32", "20.71.77.83/32", "20.71.77.134/32", "20.71.77.205/32", "20.71.78.20/32", "20.71.78.208/32", "20.71.78.243/32", "20.71.79.77/32", "20.71.79.165/32", "20.71.79.228/32", "20.73.232.14/32", "20.73.232.51/32", "20.73.232.121/32", "20.73.232.130/32", "20.73.232.163/32", "20.73.232.186/32", "20.73.232.217/32", "20.73.232.241/32", "20.73.132.133/32", "20.73.132.167/32", "20.73.133.173/32", "20.50.2.26/32", "3.251.42.4/32", "52.208.157.172/32", "3.251.42.4/32", "3.248.13.0/32"]


####----------------------------------------#
######### JS Financial Clendar Service to be consumed by retail apps-------#

#---------------------------------------------------------------------#
#Js Financial Calendar API VARIABLES
Js_Financial_Calendar_V01_api_name             = "Js_Financial_Calendar_V01"
Js_Financial_Calendar_V01_api_description      = "Fincail calendar service for getting the periodic dates"
Js_Financial_Calendar_V01_api_path_part        = "Js_Financial_Calendar_V01"
Js_Financial_Calendar_V01_api_method           = "GET"
Js_Financial_Calendar_V01_integration_type     = "HTTP_PROXY"
Js_Financial_Calendar_V01_connection_type      = "VPC_LINK"
Js_Financial_Calendar_V01_logging_level        = "ERROR"
Js_Financial_Calendar_V01_metrics_enabled_flag = "true"
Js_Financial_Calendar_V01_uri                  = "https://$${stageVariables.server}:$${stageVariables.port}/rest/Js_Cmr_FinancialCalendar/financialCalendar/V01/restful/financial_calendars"
Js_Financial_Calendar_V01_api_mapping_path     = "FinancialCalendarresource"
retailapps_allowedipaddresses                  = ["40.127.250.49/32", "20.191.58.165/32", "109.94.138.128/32", "109.94.138.129/32", "109.94.138.130/32", "109.94.137.128/32", "109.94.137.129/32", "109.94.137.130/32", "3.251.42.4/32", "52.208.157.172/32", "3.251.42.4/32", "3.248.13.0/32"]
#-----------------------------------------------------------------------------------#
#PEGA GET Order History API VARIABLES
pega_GetOrderHistory_api_name             = "pega_GetOrderHistory"
pega_GetOrderHistory_api_path_part        = "getOrderHistory"
pega_GetOrderHistory_api_method           = "POST"
pega_GetOrderHistory_integration_type     = "HTTP_PROXY"
pega_GetOrderHistory_connection_type      = "VPC_LINK"
pega_GetOrderHistory_logging_level        = "ERROR"
pega_GetOrderHistory_metrics_enabled_flag = "true"
pega_GetOrderHistory_uri                  = "https://$${stageVariables.server}:$${stageVariables.port}/ws/Js_B2B_CustomerMgmt_OHA.provider:getOrderHistory/Js_B2B_CustomerMgmt_OHA_provider_getOrderHistory_Port"
pega_GetOrderHistory_api_mapping_path     = "pegaGetOrderHistory"
#---------------------------------------------------------------------------------------

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
FIS_allowedipaddresses                      = ["199.91.140.8/29", "109.94.138.128/32", "109.94.138.129/32", "109.94.138.130/32", "109.94.137.128/32", "109.94.137.129/32", "109.94.137.130/32", "3.251.42.4/32", "52.208.157.172/32", "3.251.42.4/32", "3.248.13.0/32", "148.139.2.212/32", "148.139.2.8/29", "148.139.2.214/32", "148.139.18.3/32", "148.139.14.3/32"]
FIS_api_mapping_part                        = "FIS"
###--------------------------------------------------------------
