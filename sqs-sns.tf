  variable "CustomerCode" {
    #Default="Must Select One"
   description="Enter a unique, *lower-case* two-letter ID to identify customer resources; should match the DynamoDB table.Select 'ovc' for internal use.For OneView Cloud this will be auto-populated as the AWS Region for platform resources"
  }

 variable "EnvironmentType" {
   #type="String"
   description="Select which environment stage you are creating.  This will determine the names of the created resources.Hosting environments - sandbox, preprod, prod.Internal dev use - internal-dev and internal-qa.  Sales use - four sales environment types."
  }

  variable "DelaySeconds" {
   #default="0"
   #type= "Number"
   description="The time in seconds that the delivery of all messages in the queue is delayed. Default is 0 seconds."
   #ConstraintDescription="You can specify an integer value of 0 to 900 (15 minutes)."
  }

  variable "MessageRetentionPeriod" {
    description="The number of seconds that Amazon SQS retains a message.Default for standard queues is 345600 seconds (4 days)."
    #default="345600"
    #type="Number"
    #ConstraintDescription="You can specify an integer value from 60 seconds (1 minute) to 1209600 seconds (14 days).  Default is 345600 seconds (4 days)'"
   }

 variable "VisibilityTimeout" {
   description="The length of time during which a message will be unavailable after a message is delivered from the queue. This blocks other components from receiving the same message and gives the initial component time to process and delete the message from the queue.  Default is 30 seconds."
   #default="30"
   #type="Number"
   #ConstraintDescription="Values must be from 0 to 43200 seconds (12 hours). Default is 30 seconds"
  }

 variable "DLQDelaySeconds" {
   description="The time in seconds that the delivery of all messages in the queue is delayed.Default is 0 seconds."
   #default"0"
   #type="Number"
  }

 variable "DLQMessageRetentionPeriod" {
   description="The number of seconds that Amazon SQS retains a message. .  Default for standard queues is 1209600 seconds (14 days)"  
   #Type="Number"
   #default="1209600"
   #ConstraintDescription="You can specify an integer value from 60 seconds (1 minute) to 1209600 seconds (14 days).Default is 14 days'"
 }

 variable "DLQVisibilityTimeout" {
   description="The length of time during which a message will be unavailable after a message is delivered from the queue. This blocks other components from receiving the same message and gives the initial component time to process and delete the message from the queue. Default is 30 seconds"
   #Type="Number"
   #Default="30"
   #ConstraintDescription="Values must be from 0 to 43200 seconds (12 hours).  Default is 30 seconds"
  }

variable "DLQMaxReceiveCount" {
   description="The number of times a message is delivered to the source queue before being moved to the dead-letter queue.Default is 20 times"
   #Default="20"
   #Type="Number"
 }




#resource group
resource "azurerm_resource_group" "test" {
  name="${var.CustomerCode}-${var.EnvironmentType}-service_bus"
  location = "eastUS"

  tags = {
     environment = "Production"
  }
}


    

#create Namespace

resource "azurerm_servicebus_namespace" "test1"{
   name = "${var.CustomerCode}-namespace"
   location = "${azurerm_resource_group.test.location}" 
   resource_group_name ="${azurerm_resource_group.test.name}"
   sku="Standard"
}


#adding queue
 resource "azurerm_servicebus_queue" "ImAdjustExportQueue" {
   name ="ImAdjustExportQueue"
   resource_group_name = "${azurerm_resource_group.test.name}"
   namespace_name = "${azurerm_servicebus_namespace.test1.name}"
   enable_partitioning = true
 }


 resource "azurerm_servicebus_queue" "ImAdjustExportQueue-dlq" {
   name ="ImAdjustExportQueue-dlq"
   resource_group_name = "${azurerm_resource_group.test.name}"
   namespace_name = "${azurerm_servicebus_namespace.test1.name}"
   enable_partitioning = true
 }

 resource "azurerm_servicebus_queue" "ImCountExportQueue" {
   name ="ImCountExportQueue"
   resource_group_name = "${azurerm_resource_group.test.name}"
   namespace_name = "${azurerm_servicebus_namespace.test1.name}"
   enable_partitioning = true
 }

 resource "azurerm_servicebus_queue" "ImCountExportQueue-dlq" {
   name ="ImCountExportQueue-dlq"
   resource_group_name = "${azurerm_resource_group.test.name}"
   namespace_name = "${azurerm_servicebus_namespace.test1.name}"
   enable_partitioning = true
 }

 resource "azurerm_servicebus_queue" "ImInventoryBalanceExportQueue" {
   name ="ImInventoryBalanceExportQueue"
   resource_group_name = "${azurerm_resource_group.test.name}"
   namespace_name = "${azurerm_servicebus_namespace.test1.name}"
   enable_partitioning = true
 }

 resource "azurerm_servicebus_queue" "ImInventoryBalanceExportQueueDlq" {
   name ="ImInventoryBalanceExportQueueDlq"
   resource_group_name = "${azurerm_resource_group.test.name}"
   namespace_name = "${azurerm_servicebus_namespace.test1.name}"
   enable_partitioning = true
 }

 resource "azurerm_servicebus_queue" "ImPoAsnQueue" {
   name ="ImPoAsnQueue"
   resource_group_name = "${azurerm_resource_group.test.name}"
   namespace_name = "${azurerm_servicebus_namespace.test1.name}"
   enable_partitioning = true
 }

 resource "azurerm_servicebus_queue" "ImPoAsnQueue-dlq" {
   name ="ImPoAsnQueue-dlq"
   resource_group_name = "${azurerm_resource_group.test.name}"
   namespace_name = "${azurerm_servicebus_namespace.test1.name}"
   enable_partitioning = true
 }

 resource "azurerm_servicebus_queue" "ImPoConfirmedQueue" {
   name ="ImPoConfirmedQueue"
   resource_group_name = "${azurerm_resource_group.test.name}"
   namespace_name = "${azurerm_servicebus_namespace.test1.name}"
   enable_partitioning = true
 }

 resource "azurerm_servicebus_queue" "ImPoConfirmedQueue-dlq" {
   name ="ImPoConfirmedQueue-dlq"
   resource_group_name = "${azurerm_resource_group.test.name}"
   namespace_name = "${azurerm_servicebus_namespace.test1.name}"
   enable_partitioning = true
 }
 resource "azurerm_servicebus_queue" "ImPoSubmitQueue" {
   name ="ImPoSubmitQueue"
   resource_group_name = "${azurerm_resource_group.test.name}"
   namespace_name = "${azurerm_servicebus_namespace.test1.name}"
   enable_partitioning = true
 }
 resource "azurerm_servicebus_queue" "ImPoSubmitQueue-dlq" {
   name ="ImPoSubmitQueue-dlq"
   resource_group_name = "${azurerm_resource_group.test.name}"
   namespace_name = "${azurerm_servicebus_namespace.test1.name}"
   enable_partitioning = true
 }

 resource "azurerm_servicebus_queue" "ImReturnToWarehouseQueue" {
   name ="ImReturnToWarehouseQueue"
   resource_group_name = "${azurerm_resource_group.test.name}"
   namespace_name = "${azurerm_servicebus_namespace.test1.name}"
   enable_partitioning = true
 }

 resource "azurerm_servicebus_queue" "ImReturnToWarehouseQueue-dlq" {
   name ="ImReturnToWarehouseQueue-dlq"
   resource_group_name = "${azurerm_resource_group.test.name}"
   namespace_name = "${azurerm_servicebus_namespace.test1.name}"
   enable_partitioning = true
 }

 resource "azurerm_servicebus_queue" "ImStockExportQueue" {
   name ="ImStockExportQueue"
   resource_group_name = "${azurerm_resource_group.test.name}"
   namespace_name = "${azurerm_servicebus_namespace.test1.name}"
   enable_partitioning = true
 }

 resource "azurerm_servicebus_queue" "ImStockExportQueue-dlq" {
   name ="ImStockExportQueue-dlq"
   resource_group_name = "${azurerm_resource_group.test.name}"
   namespace_name = "${azurerm_servicebus_namespace.test1.name}"
   enable_partitioning = true
 }

 resource "azurerm_servicebus_queue" "ImPosTlogQueue" {
   name ="ImPosTlogQueue"
   resource_group_name = "${azurerm_resource_group.test.name}"
   namespace_name = "${azurerm_servicebus_namespace.test1.name}"
   enable_partitioning = true
 }

 resource "azurerm_servicebus_queue" "ImPosTlogQueue-dlq" {
   name ="ImPosTlogQueue-dlq"
   resource_group_name = "${azurerm_resource_group.test.name}"
   namespace_name = "${azurerm_servicebus_namespace.test1.name}"
   enable_partitioning = true
 }

#topics
 resource "azurerm_servicebus_topic" "AdjustExportTopic" {
   name= "AdjustExportTopic"
   resource_group_name = "${azurerm_resource_group.test.name}"
   namespace_name      = "${azurerm_servicebus_namespace.test1.name}"

   enable_partitioning = true
 }

 resource "azurerm_servicebus_topic" "ImCountExportTopic" {
   name= "ImCountExportTopic"
   resource_group_name = "${azurerm_resource_group.test.name}"
   namespace_name      = "${azurerm_servicebus_namespace.test1.name}"

   enable_partitioning = true
 }

 resource "azurerm_servicebus_topic" "ImInventoryBalanceExportTopic" {
   name= "ImInventoryBalanceExportTopic"
   resource_group_name = "${azurerm_resource_group.test.name}"
   namespace_name      = "${azurerm_servicebus_namespace.test1.name}"

   enable_partitioning = true
 }

 resource "azurerm_servicebus_topic" "ImPoAsnTopic" {
   name= "ImPoAsnTopic"
   resource_group_name = "${azurerm_resource_group.test.name}"
   namespace_name      = "${azurerm_servicebus_namespace.test1.name}"

   enable_partitioning = true
 }

resource "azurerm_servicebus_topic" "ImPoConfirmedTopic" {
   name= "ImPoConfirmedTopic"
   resource_group_name = "${azurerm_resource_group.test.name}"
   namespace_name      = "${azurerm_servicebus_namespace.test1.name}"

   enable_partitioning = true
 }

 resource "azurerm_servicebus_topic" "ImPoSubmitTopic" {
   name= "ImPoSubmitTopic"
   resource_group_name = "${azurerm_resource_group.test.name}"
   namespace_name      = "${azurerm_servicebus_namespace.test1.name}"

   enable_partitioning = true
 }

 resource "azurerm_servicebus_topic" "ImReturnToWarehouseTopic" {
   name= "ImReturnToWarehouseTopic"
   resource_group_name = "${azurerm_resource_group.test.name}"
   namespace_name      = "${azurerm_servicebus_namespace.test1.name}"

   enable_partitioning = true
 }

 resource "azurerm_servicebus_topic" "ImStockExportTopic" {
   name= "ImStockExportTopic"
   resource_group_name = "${azurerm_resource_group.test.name}"
   namespace_name      = "${azurerm_servicebus_namespace.test1.name}"

   enable_partitioning = true
 }


#Set subcription

 resource "azurerm_servicebus_subscription" "AdjustExportSubscription" {
   name                = "AdjustExportSubscription"
   resource_group_name = "${azurerm_resource_group.test.name}"
   namespace_name      = "${azurerm_servicebus_namespace.test1.name}"
   topic_name          = "${azurerm_servicebus_topic.AdjustExportTopic.name}"
   max_delivery_count  = 1
 }

 resource "azurerm_servicebus_subscription" "CountExportSubscription" {
   name                = "CountExportSubscription"
   resource_group_name = "${azurerm_resource_group.test.name}"
   namespace_name      = "${azurerm_servicebus_namespace.test1.name}"
   topic_name          = "${azurerm_servicebus_topic.ImCountExportTopic.name}"
   max_delivery_count  = 1
 }

 resource "azurerm_servicebus_subscription" "InventoryBalanceExportSubscription" {
   name                = "InventoryBalanceExportSubscription"
   resource_group_name = "${azurerm_resource_group.test.name}"
   namespace_name      = "${azurerm_servicebus_namespace.test1.name}"
   topic_name          = "${azurerm_servicebus_topic.ImInventoryBalanceExportTopic.name}"
   max_delivery_count  = 1
 }
 resource "azurerm_servicebus_subscription" "PoAsnSubscription" {
   name                = "PoAsnSubscription"
   resource_group_name = "${azurerm_resource_group.test.name}"
   namespace_name      = "${azurerm_servicebus_namespace.test1.name}"
    topic_name          = "${azurerm_servicebus_topic.ImPoAsnTopic.name}"
  max_delivery_count  = 1
}
 resource "azurerm_servicebus_subscription" "PoConfirmedSubscription" {
   name                = "PoConfirmedSubscription"
   resource_group_name = "${azurerm_resource_group.test.name}"
   namespace_name      = "${azurerm_servicebus_namespace.test1.name}"
   topic_name          = "${azurerm_servicebus_topic.ImPoConfirmedTopic.name}"
   max_delivery_count  = 1
 }
 resource "azurerm_servicebus_subscription" "PoSubmitSubscription" {
   name                = "PoSubmitSubscription"
   resource_group_name = "${azurerm_resource_group.test.name}"
   namespace_name      = "${azurerm_servicebus_namespace.test1.name}"
   topic_name          = "${azurerm_servicebus_topic.ImPoSubmitTopic.name}"
   max_delivery_count  = 1
 }
 resource "azurerm_servicebus_subscription" "ReturnToWarehouseSubscription" {
   name                = "ReturnToWarehouseSubscription"
   resource_group_name = "${azurerm_resource_group.test.name}"
   namespace_name      = "${azurerm_servicebus_namespace.test1.name}"
   topic_name          = "${azurerm_servicebus_topic.ImReturnToWarehouseTopic.name}"
   max_delivery_count  = 1
 }
 resource "azurerm_servicebus_subscription" "StockExportSubscription" {
   name                = "StockExportSubscription"
   resource_group_name = "${azurerm_resource_group.test.name}"
   namespace_name      = "${azurerm_servicebus_namespace.test1.name}"
   topic_name          = "${azurerm_servicebus_topic.ImStockExportTopic.name}"
   max_delivery_count  = 1
 }

#Set output for queue
 output "AdjustExportQueueSqs" {
   value = "${azurerm_servicebus_queue.ImAdjustExportQueue.name}"
   description="AdjustExport Service Bus Queue"
 }

 output "ImAdjustExportQueue-dlq" {
   value = "${azurerm_servicebus_queue.ImAdjustExportQueue-dlq.name}"
   description="AdjustExport sevice bus DLQ"
 }

output "ImCountExportQueue" {
   value = "${azurerm_servicebus_queue.ImCountExportQueue.name}"
   description="CountExport Service bus Queue"
 }

 output "ImCountExportQueue-dlq" {
   value = "${azurerm_servicebus_queue.ImCountExportQueue-dlq.name}"
   description="CountExport Service bus DLQ"
 }

 output "ImInventoryBalanceExportQueue" {
   value = "${azurerm_servicebus_queue.ImInventoryBalanceExportQueue.name}"
   description="InventoryBalanceExport Service bus Queue"
 }

 output "InventoryBalanceExportQueueDlqSqs" {
   value = "${azurerm_servicebus_queue.ImInventoryBalanceExportQueueDlq.name}"
   description="InventoryBalanceExport Service bus DLQ"
 }

 output "ImPoAsnQueue" {
   value = "${azurerm_servicebus_queue.ImPoAsnQueue.name}"
   description="PoAsn Service bus Queue"
 }

 output "ImPoAsnQueue-dlq" {
   value = "${azurerm_servicebus_queue.ImPoAsnQueue-dlq.name}"
   description="PoAsn Service bus DLQ"
 }

 output "ImPoConfirmedQueue" {
   value = "${azurerm_servicebus_queue.ImPoConfirmedQueue.name}"
   description="PoConfirmed Service bus Queue"
 }

 output "ImPoConfirmedQueue-dlq" {
   value = "${azurerm_servicebus_queue.ImPoConfirmedQueue-dlq.name}"
   description="PoConfirmed Service bus DLQ"
 }

 output "ImPoSubmitQueue" {
   value = "${azurerm_servicebus_queue.ImPoSubmitQueue.name}"
   description="PoSubmitQueue"
 }

 output "ImPoSubmitQueue-dlq" {
   value = "${azurerm_servicebus_queue.ImPoSubmitQueue-dlq.name}"
   description="PoSubmit Service bus DLQ"
 }

 output "ImReturnToWarehouseQueue" {
   value = "${azurerm_servicebus_queue.ImReturnToWarehouseQueue.name}"
   description="ReturnToWarehouse Service Bus Queue"
 }

 output "ImReturnToWarehouseQueue-dlq" {
   value = "${azurerm_servicebus_queue.ImReturnToWarehouseQueue-dlq.name}"
   description="ReturnToWarehouse Service bus DLQ"
 }

 output "ImStockExportQueue" {
   value = "${azurerm_servicebus_queue.ImStockExportQueue.name}"
   description="StockExport Service bus Queue"
 }

 output "ImStockExportQueue-dlq" {
   value = "${azurerm_servicebus_queue.ImStockExportQueue-dlq.name}"
   description="StockExport service bus DLQ"
 }

 output "ImPosTlogQueue" {
   value = "${azurerm_servicebus_queue.ImPosTlogQueue.name}"
   description="PosTlog Service bus Queue"
 }

 output "ImPosTlogQueue-dlq" {
   value = "${azurerm_servicebus_queue.ImPosTlogQueue-dlq.name}"
   description="PosTlog Service bus DLQ"
 }

#set output Topics
 output "ImAdjustExportTopic" {
 value = "${azurerm_servicebus_topic.AdjustExportTopic.name}"
 description=" AdjustExport Service bus Topic"
 }

 output "ImCountExportTopic" {
  value = "${azurerm_servicebus_topic.ImCountExportTopic.name}"
 description=" CountExport Service Bus Topic"
 }

 output "ImInventoryBalanceExportTopic" {
  value = "${azurerm_servicebus_topic.ImInventoryBalanceExportTopic.name}"
  description="InventoryBalanceExport Service bus Topic"
 }

 output "ImPoAsnTopic" {
  value = "${azurerm_servicebus_topic.ImPoAsnTopic.name}"
  description="PoAsn Service Bus Topic"
 }

 output "ImPoConfirmedTopic" {
  value = "${azurerm_servicebus_topic.ImPoConfirmedTopic.name}"
  description="PoConfirmed Service Bus Topic"
 }

 output "ImPoSubmitTopic" {
  value = "${azurerm_servicebus_topic.ImPoSubmitTopic.name}"
  description="PoSubmit Service Bus Topicc"
 }

 output "ImReturnToWarehouseTopic" {
  value = "${azurerm_servicebus_topic.ImReturnToWarehouseTopic.name}"
  description="ReturnToWarehouse Service Bus Topic"
 }

 output "ImStockExportTopic" {
  value = "${azurerm_servicebus_topic.ImStockExportTopic.name}"
  description="StockExport Service Bus Topic"
 }