# Secret Manager Data block
data "aws_secretsmanager_secret_version" "amq_secret_global" {
  secret_id = "ActiveMQ_Global"
}

# Local Variabl Declaration
locals {
  broker_name_1          = "app-intg-platform-${var.env}-retail-corp-broker-1"
  broker_name_2          = "app-intg-platform-${var.env}-retail-corp-broker-2"
  broker_name_3          = "app-intg-platform-${var.env}-retail-corp-broker-3"
  retail_storage_type    = "efs"
  retail_deployment_mode = "SINGLE_INSTANCE"
  retail_username        = "Administrator"
  retail_password        = jsondecode(data.aws_secretsmanager_secret_version.amq_secret_global.secret_string)["RetailCorpActiveMQPassword"]
  apply_immediately      = false
  general                = true
  audit                  = "true"
  day_of_week            = "SUNDAY"
  time_of_day_1          = "23:00"
  time_of_day_2          = "23:00"
  time_of_day_3          = "23:00"
  time_zone              = "GMT"
  mdm_username           = "mdmamquser"
  mdm_password           = jsondecode(data.aws_secretsmanager_secret_version.amq_secret_global.secret_string)["mdmActiveMQPassword"]

  golf_username = "golfamquser"
  golf_password = jsondecode(data.aws_secretsmanager_secret_version.amq_secret_global.secret_string)["golfActiveMQPassword"]

  ANR_username      = "anramquser"
  ANR_password      = jsondecode(data.aws_secretsmanager_secret_version.amq_secret_global.secret_string)["ANRActiveMQPassword"]
  Planit_username   = "planitamquser"
  Planit_pasword    = jsondecode(data.aws_secretsmanager_secret_version.amq_secret_global.secret_string)["PLANITActiveMQPassword"]
  StockApp_username = "stockappuser"
  StockApp_pasword  = jsondecode(data.aws_secretsmanager_secret_version.amq_secret_global.secret_string)["StockAppAMQPassword"]
}

# Creation of Broker 1
resource "aws_mq_broker" "retail_corp_mq_1" {
  broker_name                = local.broker_name_1
  engine_type                = var.retail_engine_type
  engine_version             = var.retail_engine_version
  auto_minor_version_upgrade = true
  apply_immediately          = local.apply_immediately
  storage_type               = local.retail_storage_type
  host_instance_type         = var.retail_host_instance_type
  deployment_mode            = local.retail_deployment_mode
  security_groups            = [aws_security_group.reatail_corp_mq_sg.id]
  subnet_ids                 = [var.private_subnet_id_1]

  configuration {
    id       = aws_mq_configuration.retail_corp_mq_configuration_1.id
    revision = aws_mq_configuration.retail_corp_mq_configuration_1.latest_revision
  }

  user {
    username       = local.retail_username
    password       = local.retail_password
    console_access = true
  }

  user {
    username       = local.mdm_username
    password       = local.mdm_password
    console_access = false
  }
  user {
    username       = local.golf_username
    password       = local.golf_password
    console_access = false
  }
  user {
    username       = local.ANR_username
    password       = local.ANR_password
    console_access = false
  }
  user {
    username       = local.Planit_username
    password       = local.Planit_pasword
    console_access = false
  }
  user {
    username       = local.StockApp_username
    password       = local.StockApp_pasword
    console_access = false
  }
  maintenance_window_start_time {
    day_of_week = local.day_of_week
    time_of_day = local.time_of_day_1
    time_zone   = local.time_zone
  }

  logs {
    general = local.general
    audit   = local.audit
  }

  tags = {
    Name = local.broker_name_1
  }
}

# Creation of Broker 2
resource "aws_mq_broker" "retail_corp_mq_2" {
  broker_name                = local.broker_name_2
  engine_type                = var.retail_engine_type
  engine_version             = var.retail_engine_version
  auto_minor_version_upgrade = true
  apply_immediately          = local.apply_immediately
  storage_type               = local.retail_storage_type
  host_instance_type         = var.retail_host_instance_type
  deployment_mode            = local.retail_deployment_mode
  security_groups            = [aws_security_group.reatail_corp_mq_sg.id]
  subnet_ids                 = [var.private_subnet_id_2]

  configuration {
    id       = aws_mq_configuration.retail_corp_mq_configuration_2.id
    revision = aws_mq_configuration.retail_corp_mq_configuration_2.latest_revision
  }

  user {
    username       = local.retail_username
    password       = local.retail_password
    console_access = true
  }
  user {
    username       = local.mdm_username
    password       = local.mdm_password
    console_access = false
  }
  user {
    username       = local.golf_username
    password       = local.golf_password
    console_access = false
  }
  user {
    username       = local.ANR_username
    password       = local.ANR_password
    console_access = false
  }
  user {
    username       = local.Planit_username
    password       = local.Planit_pasword
    console_access = false
  }

  user {
    username       = local.StockApp_username
    password       = local.StockApp_pasword
    console_access = false
  }

  maintenance_window_start_time {
    day_of_week = local.day_of_week
    time_of_day = local.time_of_day_2
    time_zone   = local.time_zone
  }

  logs {
    general = local.general
    audit   = local.audit
  }

  tags = {
    Name = local.broker_name_2
  }
}

# Creation of Broker 3
resource "aws_mq_broker" "retail_corp_mq_3" {
  broker_name                = local.broker_name_3
  engine_type                = var.retail_engine_type
  engine_version             = var.retail_engine_version
  auto_minor_version_upgrade = true
  apply_immediately          = local.apply_immediately
  storage_type               = local.retail_storage_type
  host_instance_type         = var.retail_host_instance_type
  deployment_mode            = local.retail_deployment_mode
  security_groups            = [aws_security_group.reatail_corp_mq_sg.id]
  subnet_ids                 = [var.private_subnet_id_3]

  configuration {
    id       = aws_mq_configuration.retail_corp_mq_configuration_3.id
    revision = aws_mq_configuration.retail_corp_mq_configuration_3.latest_revision
  }

  user {
    username       = local.retail_username
    password       = local.retail_password
    console_access = true
  }
  user {
    username       = local.mdm_username
    password       = local.mdm_password
    console_access = false
  }
  user {
    username       = local.golf_username
    password       = local.golf_password
    console_access = false
  }
  user {
    username       = local.ANR_username
    password       = local.ANR_password
    console_access = false
  }
  user {
    username       = local.Planit_username
    password       = local.Planit_pasword
    console_access = false
  }

  user {
    username       = local.StockApp_username
    password       = local.StockApp_pasword
    console_access = false
  }

  maintenance_window_start_time {
    day_of_week = local.day_of_week
    time_of_day = local.time_of_day_3
    time_zone   = local.time_zone
  }

  logs {
    general = local.general
    audit   = local.audit
  }

  tags = {
    Name = local.broker_name_3
  }
}