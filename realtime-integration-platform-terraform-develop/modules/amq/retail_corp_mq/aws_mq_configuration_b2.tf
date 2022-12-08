# Local Variabl Declaration
locals {
  config_name_2 = "app-intg-platform-${var.env}-retail-corp-broker-2"
}

# Configuration file Broker  2
resource "aws_mq_configuration" "retail_corp_mq_configuration_2" {
  description    = "Configuration for retail corp MQ : AMQBroker 2"
  name           = local.config_name_2
  engine_type    = var.retail_engine_type
  engine_version = var.retail_engine_version
  data           = <<DATA
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<broker schedulePeriodForDestinationPurge="10000" xmlns="http://activemq.apache.org/schema/core">
  <!-- Destination Interceptors Configuration -->
  <destinationInterceptors>
    <virtualDestinationInterceptor>
      <virtualDestinations>
        <virtualTopic concurrentSend="true" name="&gt;" prefix="VirtualTopicConsumers.*." selectorAware="false"/>
      </virtualDestinations>
    </virtualDestinationInterceptor>
  </destinationInterceptors>
  <!-- Startup Destinations -->
  <destinations>
    <!-- Topics -->
    <topic physicalName="StoreOrder/V01/ProcessStoreOrder"/>
    <topic physicalName="StoreOrder/V01/ReprocessStoreOrder"/>
    <topic physicalName="sainsburys/logistics/transport_delivery/v1/planned"/>
    <topic physicalName="AdvanceShippingNotice/V01/DepotDelivery/advanceshippingnotice"/>
    <topic physicalName="AdvanceShippingNotice/V01/DirectDelivery/advanceshippingnotice"/>
    <topic physicalName="ColleaguePublisher/postColleague/ColleagueDataCDF/Absence"/>
    <topic physicalName="ColleaguePublisher/postColleague/ColleagueDataCDF/ArgosCustomerManagementCentres"/>
    <topic physicalName="ColleaguePublisher/postColleague/ColleagueDataCDF/ArgosDistribution"/>
    <topic physicalName="ColleaguePublisher/postColleague/ColleagueDataCDF/ArgosLocalFulfilmentCentres"/>
    <topic physicalName="ColleaguePublisher/postColleague/ColleagueDataCDF/ArgosRegionalFulfilmentCentres"/>
    <topic physicalName="ColleaguePublisher/postColleague/ColleagueDataCDF/ArgosRetail"/>
    <topic physicalName="ColleaguePublisher/postColleague/ColleagueDataCDF/ArgosROI"/>
    <topic physicalName="ColleaguePublisher/postColleague/ColleagueDataCDF/CorporateAffairs"/>
    <topic physicalName="ColleaguePublisher/postColleague/ColleagueDataCDF/CorporateServices"/>
    <topic physicalName="ColleaguePublisher/postColleague/ColleagueDataCDF/DigitalTechnology"/>
    <topic physicalName="ColleaguePublisher/postColleague/ColleagueDataCDF/Elements"/>
    <topic physicalName="ColleaguePublisher/postColleague/ColleagueDataCDF/Executives"/>
    <topic physicalName="ColleaguePublisher/postColleague/ColleagueDataCDF/FinanceBusinessDevelopment"/>
    <topic physicalName="ColleaguePublisher/postColleague/ColleagueDataCDF/FoodCommercial"/>
    <topic physicalName="ColleaguePublisher/postColleague/ColleagueDataCDF/GroupHR"/>
    <topic physicalName="ColleaguePublisher/postColleague/ColleagueDataCDF/Habitat"/>
    <topic physicalName="ColleaguePublisher/postColleague/ColleagueDataCDF/Logistics"/>
    <topic physicalName="ColleaguePublisher/postColleague/ColleagueDataCDF/Marketing"/>
    <topic physicalName="ColleaguePublisher/postColleague/ColleagueDataCDF/NectarLoyaltyHoldingLtd"/>
    <topic physicalName="ColleaguePublisher/postColleague/ColleagueDataCDF/NonFood"/>
    <topic physicalName="ColleaguePublisher/postColleague/ColleagueDataCDF/Online"/>
    <topic physicalName="ColleaguePublisher/postColleague/ColleagueDataCDF/Property"/>
    <topic physicalName="ColleaguePublisher/postColleague/ColleagueDataCDF/Retail"/>
    <topic physicalName="ColleaguePublisher/postColleague/ColleagueDataCDF/AuditDLQ"/>
    <topic physicalName="ColleaguePublisher/postColleague/ColleagueDataCDF/SainsburysArgos"/>
    <topic physicalName="ColleaguePublisher/postColleague/ColleagueDataCDF/SainsburysArgosAsia"/>
    <topic physicalName="ColleaguePublisher/postColleague/ColleagueDataCDF/SainsburysBank"/>
    <topic physicalName="ColleaguePublisher/postColleague/ColleagueDataCDF/VeteransandNonWorkers"/>
    <topic physicalName="ConsolidatedPerformanceMeasures"/>
    <topic physicalName="CustomerOrder/OrderNotification/NewCustomerOrders"/>
    <topic physicalName="CustomerOrder/OrderNotification/UpdatedCustomerOrder"/>
    <topic physicalName="CustomerOrder/PublishGOLOrders/GOLOrders"/>
    <topic physicalName="FinancePerformanceMeasures"/>
    <topic physicalName="PriceMgmt/Price"/>
    <topic physicalName="Product_5_JSON"/>
    <topic physicalName="Product_UDA"/>
    <topic physicalName="ProductTopic"/>
    <topic physicalName="Promotion"/>
    <topic physicalName="Promotions"/>
    <topic physicalName="Retail"/>
    <topic physicalName="sainsburys/channels/customer_profile/v3"/>
    <topic physicalName="Sales"/>
    <topic physicalName="Promotion/V03/PromotionNotification/Promotions"/>
    <topic physicalName="Promotion/V03/PublishPromotionNotification/PromotionNonFoodAdvertisementEvents"/>
    <topic physicalName="ProductHierarchy/ProductHierarchy"/>
    <topic physicalName="R10ReturnTransaction"/>
    <topic physicalName="Range/RangeNotification/RangeUpdated"/>
    <!-- Queues -->
    <queue physicalName="PriceMgmt/GetAllZoneProductPrice/PriceResponse"/>
    <queue physicalName="PriceMgmt/GetProductPriceDetails/PriceResponse"/>
    <queue physicalName="ProductHierarchy/getNode/getNodesResponse"/>
    <queue physicalName="ProductHierarchy/searchHorizontal/searchHorizontalNodesResponse"/>  
    <queue physicalName="ProductSpecification/GetProductSpecification/GetProductSpecificationResponse"/>  
    <queue physicalName="PriceMgmt/GetAllZoneProductPrice/PriceRequest"/>
    <queue physicalName="PriceMgmt/GetProductPriceDetails/PriceRequest"/>
    <queue physicalName="ProductHierarchy/getNode/getNodesRequest"/>
    <queue physicalName="ProductHierarchy/searchHorizontal/searchHorizontalNodesRequest"/>
    <queue physicalName="apps/kronos/kronos_request"/>
    <queue physicalName="Testq"/>
    <queue physicalName="TimeAttendance/ClockingRequest"/>
    <queue physicalName="ProductUDANotificationTrigger"/>
    <queue physicalName="ProductNotificationTrigger"/>
    <queue physicalName="PromotionNotification"/>
    <queue physicalName="CustomerProfile/Events/MDMNotification"/>
    <queue physicalName="Range/RangesByHierarchy"/>
    <queue physicalName="ProductSpecification/GetProductSpecification/GetProductSpecificationRequest"/>
    <queue physicalName="ProductSpecification/GetProductSpecification/GetProductSpecificationResponse"/>
    <queue physicalName="productHierarchy_Notification"/>
    <queue physicalName="private/my_time_reporting/generic_submissions"/>
    <queue physicalName="Range/Notification"/>
    <queue physicalName="PriceNotification"/>
  </destinations>
  <!-- Destination Policy Configuration -->

  <destinationPolicy>
    <policyMap>
      <policyEntries>
        <policyEntry topic="&gt;">
          <pendingMessageLimitStrategy>
            <constantPendingMessageLimitStrategy limit="1000"/>
          </pendingMessageLimitStrategy>
          <deadLetterStrategy>
            <sharedDeadLetterStrategy expiration="600000" processExpired="false"/>
          </deadLetterStrategy>
        </policyEntry>
        <policyEntry queue="&gt;">
          <deadLetterStrategy>
            <sharedDeadLetterStrategy expiration="600000" processExpired="false"/>
          </deadLetterStrategy>
          <networkBridgeFilterFactory>
              <conditionalNetworkBridgeFilterFactory replayWhenNoConsumers="true"/>
          </networkBridgeFilterFactory>
        </policyEntry>
      </policyEntries>
    </policyMap>
  </destinationPolicy>
  <!-- Plugins Configuration -->
  <plugins>
    <forcePersistencyModeBrokerPlugin persistenceFlag="true"/>
    <statisticsBrokerPlugin/>
    <timeStampingBrokerPlugin ttlCeiling="86400000" zeroExpirationOverride="86400000"/>
  </plugins>
  <!-- Network Connectors Configuration -->
  <networkConnectors>
    <networkConnector conduitSubscriptions="false" consumerTTL="1" messageTTL="-1" name="QueueConnectorConnectingToBroker1" uri="static:(${var.broker_1_uri})"  userName="Administrator">
      <excludedDestinations>
        <topic physicalName="&gt;"/>
      </excludedDestinations>
    </networkConnector>
    <networkConnector conduitSubscriptions="true" consumerTTL="1" messageTTL="-1" name="TopicConnectorConnectingToBroker1"  uri="static:(${var.broker_1_uri})" userName="Administrator">
      <excludedDestinations>
        <queue physicalName="&gt;"/>
      </excludedDestinations>
    </networkConnector>
    <networkConnector conduitSubscriptions="false" consumerTTL="1" messageTTL="-1" name="QueueConnectorConnectingToBroker3"  uri="static:(${var.broker_3_uri})" userName="Administrator">
      <excludedDestinations>
        <topic physicalName="&gt;"/>
      </excludedDestinations>
    </networkConnector>
    <networkConnector conduitSubscriptions="true" consumerTTL="1" messageTTL="-1" name="TopicConnectorConnectingToBroker3"  uri="static:(${var.broker_3_uri})" userName="Administrator">
      <excludedDestinations>
        <queue physicalName="&gt;"/>
      </excludedDestinations>
    </networkConnector>
  </networkConnectors>
</broker>
DATA
}