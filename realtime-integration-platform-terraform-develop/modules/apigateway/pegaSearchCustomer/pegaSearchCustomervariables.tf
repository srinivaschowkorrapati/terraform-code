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
variable "pega_searchCustomer_logging_level" {
  type    = string
  default = ""
}
variable "pega_searchCustomer_metrics_enabled_flag" {
  type    = string
  default = ""
}
variable "pega_IP" {
  type    = list(string)
  default = [""]

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
variable "pega_searchCustomer_uri" {
  type    = string
  default = ""
}

variable "api_vpc_link_id" {
  type    = string
  default = ""
}
variable "env" {
  type    = string
  default = ""
}

variable "pega_searchCustomer_api_mapping_part" {
  type    = string
  default = ""
}

variable "lambda_authorizer_arn" {
  type    = string
  default = ""
}

variable "lamda_function_name" {
  type    = string
  default = ""
}

variable "log_retention_days" {
  type    = number
  default = 0

}