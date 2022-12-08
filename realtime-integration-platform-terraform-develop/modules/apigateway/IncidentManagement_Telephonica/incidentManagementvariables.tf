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
variable "api_vpc_link_id" {
  type    = string
  default = ""
}

variable "telephonica_api_mapping_part" {
  type    = string
  default = ""
}
variable "incidentMgmt_Telephonica_status_code" {
  type    = string
  default = ""
}
variable "env" {
  type    = string
  default = ""
}

variable "telefonica_lambda_authorizer_arn" {
  type    = string
  default = ""
}

variable "telefonica_lamda_function_name" {
  type    = string
  default = ""
}

variable "telephonica_allowedipaddresses" {
  type    = list(string)
  default = [""]
}

variable "log_retention_days" {
  type    = number
  default = 0

}