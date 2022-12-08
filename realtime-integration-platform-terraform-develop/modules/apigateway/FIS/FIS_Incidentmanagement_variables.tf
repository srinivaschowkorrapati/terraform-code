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
variable "api_vpc_link_id" {
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
variable "env" {
  type    = string
  default = ""
}

variable "FIS_lambda_authorizer_arn" {
  type    = string
  default = ""
}

variable "FIS_lambda_function_name" {
  type    = string
  default = ""
}

variable "FIS_allowedipaddresses" {
  type    = list(string)
  default = [""]
}

variable "log_retention_days" {
  type    = number
  default = 0

}