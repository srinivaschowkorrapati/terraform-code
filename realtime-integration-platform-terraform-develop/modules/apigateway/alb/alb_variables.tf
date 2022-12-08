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


variable "vpc_id" {
  type    = string
  default = ""

}

variable "listner_port_SIP" {
  type    = string
  default = ""

}

variable "listner_port_912" {
  type    = string
  default = ""

}

variable "listner_port_SIP_1011" {
  type    = string
  default = ""
}

variable "listner_port_TN_1011" {
  type    = string
  default = ""

}

variable "certificate_arn" {
  type    = string
  default = ""

}

variable "sip_ip_address" {
  type    = list(string)
  default = [""]

}


variable "sip_1011_ip_address" {
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


variable "TN_ip_address" {
  type    = list(string)
  default = [""]

}

variable "TN_1011_ip_address" {
  type    = list(string)
  default = [""]

}
variable "api_vpc_link_id" {
  type    = string
  default = ""
}

variable "zone_id" {
  type    = string
  default = ""
}