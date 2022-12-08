variable "Traceone_api_name" {
  type    = string
  default = ""
}
variable "Traceone_api_description" {
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
variable "endpoint_type" {
  type    = list(string)
  default = [""]

}

variable "Traceone_api_path_part" {
  type    = string
  default = ""
}

variable "Traceone_api_method" {
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

variable "api_vpc_link_id" {
  type    = string
  default = ""
}

variable "Traceone_uri" {
  type    = string
  default = ""
}
variable "env" {
  type    = string
  default = ""
}

variable "Traceone_IP" {
  type    = list(string)
  default = [""]
}


variable "Traceone_api_mapping_path" {
  type    = string
  default = ""
}

variable "Traceone_lambda_authorizer_arn" {
  type    = string
  default = ""
}

variable "Traceone_lamda_function_name" {
  type    = string
  default = ""
}

variable "log_retention_days" {
  type    = number
  default = 0

}