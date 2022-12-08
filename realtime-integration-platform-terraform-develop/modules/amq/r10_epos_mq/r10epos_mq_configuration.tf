# Local Variabl Declaration
locals {
  config_name = "app-intg-platform-${var.env}-r10-epos-broker"
}


resource "aws_mq_configuration" "r10_epos_mq_configuration" {
  description    = "Configuration for r10 epos mq"
  name           = local.config_name
  engine_type    = var.r10epos_engine_type
  engine_version = var.r10epos_engine_version

  data = <<DATA
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<broker schedulePeriodForDestinationPurge="10000" xmlns="http://activemq.apache.org/schema/core">
  <!-- Destination Interceptors  -->
  <destinationInterceptors>
    <virtualDestinationInterceptor>
      <virtualDestinations>
        <virtualTopic concurrentSend="true" name="&gt;" prefix="VirtualTopicConsumers.*." selectorAware="false"/>
         </virtualDestinations>
    </virtualDestinationInterceptor>
  </destinationInterceptors>
  <!-- Destination Policy  -->
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
  <destinationPolicy>
    <policyMap>
      <policyEntries>
        <policyEntry expireMessagesPeriod="0" prioritizedMessages="true" producerFlowControl="false" topic="&gt;" useCache="false">
          <pendingSubscriberPolicy>
            <vmCursor/>
          </pendingSubscriberPolicy>
          <pendingDurableSubscriberPolicy>
            <vmDurableCursor/>
          </pendingDurableSubscriberPolicy>
          <deadLetterStrategy>
            <sharedDeadLetterStrategy expiration="900000" processExpired="false"/>
          </deadLetterStrategy>
        </policyEntry>
        <policyEntry expireMessagesPeriod="0" prioritizedMessages="true" producerFlowControl="false" queue="&gt;" useCache="false">
          <pendingQueuePolicy>
            <storeCursor/>
          </pendingQueuePolicy>
          <deadLetterStrategy>
            <sharedDeadLetterStrategy expiration="900000" processExpired="false"/>
          </deadLetterStrategy>
        </policyEntry>
      </policyEntries>
    </policyMap>
  </destinationPolicy>

  <!-- Destinations  -->
  <destinations>
    <topic physicalName="Forecourt"/>

    <!-- RTI Queues -->
    <queue physicalName="EagleEyeCRDM"/>
    <queue physicalName="RejectedControl"/>
    <queue physicalName="RejectedRetail"/>
    <queue physicalName="TriggerRejectedSaleTxnDoc"/>
    <queue physicalName="RejectedWetstock"/>
  </destinations>
  <!--
  < Plugins >
  <plugins/>
  -->
  <!-- Network Connectors  -->
  <!--
  <networkConnectors>
  </networkConnectors>
  -->
</broker>
DATA
}