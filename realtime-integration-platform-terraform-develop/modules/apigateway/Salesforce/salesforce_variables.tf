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

variable "api_vpc_link_id" {
  type    = string
  default = ""
}
variable "env" {
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
variable "salesforce_allowedipaddresses" {
  type    = list(string)
  default = [""]
}

variable "log_retention_days" {
  type    = number
  default = 0

}