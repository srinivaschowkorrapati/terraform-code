#Variable Declaration
variable "Js_Financial_Calendar_V01_api_name" {
  type    = string
  default = " "
}
variable "Js_Financial_Calendar_V01_api_description" {
  type    = string
  default = ""
}
variable "Js_Financial_Calendar_V01_logging_level" {
  type    = string
  default = ""
}
variable "Js_Financial_Calendar_V01_metrics_enabled_flag" {
  type    = string
  default = ""
}


variable "endpoint_type" {
  type    = list(string)
  default = [""]

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

variable "api_vpc_link_id" {
  type    = string
  default = ""
}

variable "Js_Financial_Calendar_V01_uri" {
  type    = string
  default = ""
}
variable "env" {
  type    = string
  default = ""
}
variable "Js_Financial_Calendar_V01_api_mapping_path" {
  type    = string
  default = ""
}

variable "FinancialCalendar_lambda_authorizer_arn" {
  type    = string
  default = ""
}

variable "FinancialCalendar_lamda_function_name" {
  type    = string
  default = ""
}

variable "retailapps_allowedipaddresses" {
  type    = list(string)
  default = [""]
}

variable "log_retention_days" {
  type    = number
  default = 0

}