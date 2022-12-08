variable "security_group" {
  type    = string
  default = ""
}

variable "private_subnet_id_1" {
  type    = string
  default = ""

}

variable "private_subnet_id_2" {
  type    = string
  default = ""

}

variable "private_subnet_id_3" {
  type    = string
  default = ""

}

variable "env" {
  type    = string
  default = ""
}

variable "retail_engine_type" {
  type    = string
  default = ""
}

variable "retail_engine_version" {
  type    = string
  default = ""
}

variable "host_zone_id" {
  type    = string
  default = ""

}

variable "host_zone" {
  type    = string
  default = ""

}

variable "vpc_id" {
  type    = string
  default = ""

}

variable "inbound_js_vnp_cidr_range" {
  type    = list(string)
  default = [""]

}

variable "inbound_js_app_cidr_range" {
  type    = list(string)
  default = [""]

}

variable "outbound_cidr_block_list" {
  type    = list(string)
  default = [""]

}

variable "mq_live" {
  description = "Whether or not the application went live to Production"
  default     = "no"
}

variable "broker_1_uri" {
  type    = string
  default = ""

}

variable "broker_2_uri" {
  type    = string
  default = ""

}

variable "broker_3_uri" {
  type    = string
  default = ""

}

variable "certificate_arn" {

  description = "Certificate details for Listener"
  type        = string
  default     = ""
}

variable "retail_host_instance_type" {
  type    = string
  default = ""

}

variable "Enable_flag" {
  type    = bool
  default = true

}