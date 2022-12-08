variable "C3_Reservations_api_name" {
  type    = string
  default = ""
}
variable "C3_Reservations_api_description" {
  type    = string
  default = ""
}

variable "endpoint_type" {
  type    = list(string)
  default = [""]

}

variable "C3_Reservations_IP" {
  type    = list(string)
  default = [""]

}


variable "C3_Reservations_api_path_part" {
  type    = string
  default = ""
}

variable "C3_Reservations_api_method" {
  type    = string
  default = ""
}

variable "C3_Reservations_logging_level" {
  type    = string
  default = ""
}

variable "C3_Reservations_metrics_enable_flag" {
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

variable "api_vpc_link_id" {
  type    = string
  default = ""
}

variable "C3_Reservations_uri" {
  type    = string
  default = ""
}
variable "env" {
  type    = string
  default = ""
}

variable "C3_Reservations_api_mapping_path" {
  type    = string
  default = ""
}

variable "C3_Reservations_lambda_authorizer_arn" {
  type    = string
  default = ""
}

variable "C3_Reservations_lamda_function_name" {
  type    = string
  default = ""
}

variable "log_retention_days" {
  type    = number
  default = 0

}