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
variable "endpoint_type" {
  type    = list(string)
  default = [""]

}
variable "otg_IP" {
  type    = list(string)
  default = [""]
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

variable "api_vpc_link_id" {
  type    = string
  default = ""
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
variable "env" {
  type    = string
  default = ""
}

variable "otg_common_IP" {
  type    = list(string)
  default = [""]
}


variable "otg_common_api_mapping_path" {
  type    = string
  default = ""
}

variable "otg_common_lambda_authorizer_arn" {
  type    = string
  default = ""
}

variable "otg_common_lambda_function_name" {
  type    = string
  default = ""
}

variable "log_retention_days" {
  type    = number
  default = 0

}