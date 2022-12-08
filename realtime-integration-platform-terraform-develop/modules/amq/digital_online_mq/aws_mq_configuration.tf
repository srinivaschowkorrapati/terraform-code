# Local Variabl Declaration
locals {
  config_name = "app-intg-platform-${var.env}-digital-online-broker"
}

resource "aws_mq_configuration" "digital_online_mq_configuration" {
  description    = "Configuration for digital_online_mq_configuration"
  name           = local.config_name
  engine_type    = var.digital_engine_type
  engine_version = var.digital_engine_version

  data = <<DATA
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<broker schedulePeriodForDestinationPurge="10000" xmlns="http://activemq.apache.org/schema/core">
  <!-- Destination Interceptors Configuration -->
  <destinationInterceptors>
    <virtualDestinationInterceptor>
      <virtualDestinations>
        <virtualTopic name="&gt;" prefix="VirtualTopicConsumers.*." selectorAware="false"/>
      </virtualDestinations>
    </virtualDestinationInterceptor>
  </destinationInterceptors>
  <!-- Startup Destinations -->
  <destinations>
    <!-- Topics -->
    <topic physicalName="ProductHierarchy/ProductHierarchy"/>
    <topic physicalName="ProductHierarchyOutbound"/>
    <topic physicalName="Product_DAI"/>
    <topic physicalName="OrderStatusT"/>
    <topic physicalName="OrderFulfilmentT"/>
    
    <!-- Queues -->
    <queue physicalName="sainsburys/customer/stored_value/v1/issue_coupon/issue_coupon_request"/>
    <queue physicalName="XDBInbound"/>
    <queue physicalName="XTLInbound"/>
    <queue physicalName="OrderFulfilmentQ"/>


  </destinations>
  <!-- Destination Policy Configuration -->
  <!--
<destinationPolicy>
    <policyMap>
      <policyEntries>
        <policyEntry gcInactiveDestinations="true" inactiveTimoutBeforeGC="600000" topic="&gt;">
          <pendingMessageLimitStrategy>
            <constantPendingMessageLimitStrategy limit="1000"/>
          </pendingMessageLimitStrategy>
        </policyEntry>
        <policyEntry gcInactiveDestinations="true" inactiveTimoutBeforeGC="600000" queue="&gt;"/>
      </policyEntries>
    </policyMap>
  </destinationPolicy>
  -->
  <!-- Plugins Configuration -->
  <plugins>
    <forcePersistencyModeBrokerPlugin persistenceFlag="true"/>
    <statisticsBrokerPlugin/>
    <timeStampingBrokerPlugin ttlCeiling="86400000" zeroExpirationOverride="86400000"/>
  </plugins>
</broker>
DATA
}