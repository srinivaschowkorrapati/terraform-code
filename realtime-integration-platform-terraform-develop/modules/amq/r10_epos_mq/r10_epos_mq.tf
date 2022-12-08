# Local Variabl Declaration
data "aws_secretsmanager_secret_version" "amq_secret_global" {
  secret_id = "ActiveMQ_Global"
}

locals {
  broker_name_1           = "app-intg-platform-${var.env}-r10-epos-broker-1"
  broker_name_2           = "app-intg-platform-${var.env}-r10-epos-broker-2"
  broker_name_3           = "app-intg-platform-${var.env}-r10-epos-broker-3"
  r10epos_storage_type    = "efs"
  r10epos_deployment_mode = "SINGLE_INSTANCE"
  r10epos_username        = "Administrator"
  r10epos_password        = jsondecode(data.aws_secretsmanager_secret_version.amq_secret_global.secret_string)["EPOSActiveMQPassword"]
  apply_immediately       = false
  general                 = true
  audit                   = "true"
  day_of_week             = "SUNDAY"
  time_of_day             = "23:00"
  time_zone               = "GMT"
  apriss_username         = "Apprissamquser"
  apirss_password         = jsondecode(data.aws_secretsmanager_secret_version.amq_secret_global.secret_string)["AprissActiveMQTestPassword"]
}

# Creation of Broker 1
resource "aws_mq_broker" "r10_epos_mq_1" {
  broker_name                = local.broker_name_1
  engine_type                = var.r10epos_engine_type
  engine_version             = var.r10epos_engine_version
  auto_minor_version_upgrade = true
  apply_immediately          = local.apply_immediately
  storage_type               = local.r10epos_storage_type
  host_instance_type         = var.r10epos_host_instance_type
  deployment_mode            = local.r10epos_deployment_mode
  security_groups            = [aws_security_group.r10_epos_mq_sg.id]
  subnet_ids                 = [var.private_subnet_id_1]

  configuration {
    id       = aws_mq_configuration.r10_epos_mq_configuration.id
    revision = aws_mq_configuration.r10_epos_mq_configuration.latest_revision
  }

  user {
    username       = local.r10epos_username
    password       = local.r10epos_password
    console_access = true
  }

  user {
    username       = local.apriss_username
    password       = local.apirss_password
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
    Name = local.broker_name_1
  }
  depends_on = [
    aws_lb.r10_epos_alb
  ]
}

# Creation of Broker 2
resource "aws_mq_broker" "r10_epos_mq_2" {
  broker_name                = local.broker_name_2
  engine_type                = var.r10epos_engine_type
  engine_version             = var.r10epos_engine_version
  auto_minor_version_upgrade = true
  apply_immediately          = local.apply_immediately
  storage_type               = local.r10epos_storage_type
  host_instance_type         = var.r10epos_host_instance_type
  deployment_mode            = local.r10epos_deployment_mode
  security_groups            = [aws_security_group.r10_epos_mq_sg.id]
  subnet_ids                 = [var.private_subnet_id_2]

  configuration {
    id       = aws_mq_configuration.r10_epos_mq_configuration.id
    revision = aws_mq_configuration.r10_epos_mq_configuration.latest_revision
  }

  user {
    username       = local.r10epos_username
    password       = local.r10epos_password
    console_access = true
  }

  user {
    username       = local.apriss_username
    password       = local.apirss_password
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
    Name = local.broker_name_2
  }
  depends_on = [
    aws_lb.r10_epos_alb
  ]
}

# Creation of Broker 3
resource "aws_mq_broker" "r10_epos_mq_3" {
  broker_name                = local.broker_name_3
  engine_type                = var.r10epos_engine_type
  engine_version             = var.r10epos_engine_version
  auto_minor_version_upgrade = true
  apply_immediately          = local.apply_immediately
  storage_type               = local.r10epos_storage_type
  host_instance_type         = var.r10epos_host_instance_type
  deployment_mode            = local.r10epos_deployment_mode
  security_groups            = [aws_security_group.r10_epos_mq_sg.id]
  subnet_ids                 = [var.private_subnet_id_3]

  configuration {
    id       = aws_mq_configuration.r10_epos_mq_configuration.id
    revision = aws_mq_configuration.r10_epos_mq_configuration.latest_revision
  }

  user {
    username       = local.r10epos_username
    password       = local.r10epos_password
    console_access = true
  }

  user {
    username       = local.apriss_username
    password       = local.apirss_password
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
    Name = local.broker_name_3
  }
  depends_on = [
    aws_lb.r10_epos_alb
  ]
}
