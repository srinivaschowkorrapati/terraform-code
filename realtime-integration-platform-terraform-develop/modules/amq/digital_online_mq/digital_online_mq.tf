# Secret Manager Data block
data "aws_secretsmanager_secret_version" "amq_secret_global" {
  secret_id = "ActiveMQ_Global"
}

#Local Variable Declaration
locals {
  broker_name             = "app-intg-platform-${var.env}-digital-online-broker"
  digital_storage_type    = "efs"
  digital_deployment_mode = "ACTIVE_STANDBY_MULTI_AZ"
  digital_username        = "Administrator"
  digital_password        = jsondecode(data.aws_secretsmanager_secret_version.amq_secret_global.secret_string)["DigitalActiveMQPassword"]
  apply_immediately       = false
  general                 = true
  audit                   = "true"
  day_of_week             = "SUNDAY"
  time_of_day             = "23:00"
  time_zone               = "GMT"
  apriss_username         = "apprissamquser"
  apirss_password         = jsondecode(data.aws_secretsmanager_secret_version.amq_secret_global.secret_string)["AprissActiveMQTestPassword"]
  dai_username            = "Misamquser"
  dai_password            = jsondecode(data.aws_secretsmanager_secret_version.amq_secret_global.secret_string)["DaiActiveMQPassword"]
}

# Creation of Broker
resource "aws_mq_broker" "digital_online_mq" {
  broker_name                = local.broker_name
  engine_type                = var.digital_engine_type
  engine_version             = var.digital_engine_version
  auto_minor_version_upgrade = true
  apply_immediately          = local.apply_immediately
  storage_type               = local.digital_storage_type
  host_instance_type         = var.digital_host_instance_type
  deployment_mode            = local.digital_deployment_mode
  security_groups            = [aws_security_group.digital_online_mq_sg.id]
  subnet_ids                 = [var.private_subnet_id_1, var.private_subnet_id_2]

  configuration {
    id       = aws_mq_configuration.digital_online_mq_configuration.id
    revision = aws_mq_configuration.digital_online_mq_configuration.latest_revision
  }

  user {
    username       = local.digital_username
    password       = local.digital_password
    console_access = true
  }

  user {
    username       = local.apriss_username
    password       = local.apirss_password
    console_access = false
  }

  user {
    username       = local.dai_username
    password       = local.dai_password
    console_access = false
  }
  maintenance_window_start_time {
    day_of_week = local.day_of_week
    time_of_day = local.time_of_day
    time_zone   = local.time_zone
  }

  logs {
    general = local.general
    audit   = local.audit
  }

  tags = {
    Name = local.broker_name
  }
}
