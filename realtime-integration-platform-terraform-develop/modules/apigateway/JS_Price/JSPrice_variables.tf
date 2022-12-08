
variable "jsprice_api_name" {
  type    = string
  default = ""
}

variable "jsprice_api_description" {
  type    = string
  default = ""
}

variable "jsprice_api_path_part" {
  type    = string
  default = ""
}

variable "jsprice_api_method" {
  type    = string
  default = ""
}

variable "jsprice_integration_type" {
  type    = string
  default = ""
}

variable "jsprice_connection_type" {
  type    = string
  default = ""
}

variable "api_vpc_endpoint_ids" {
  type    = list(string)
  default = [""]
}

variable "api_vpc_link_id" {
  type    = string
  default = ""
}

variable "jsprice_uri" {
  type    = string
  default = ""
}

variable "env" {
  type    = string
  default = ""
}