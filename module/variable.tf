variable "region" {
  description = "The AWS region to deploy the OpenSearch domain in."
  type        = string
  default     = "ap-south-1"
}

variable "domain_name" {
  description = "The name of the OpenSearch domain."
  type        = string
  default     = "sytlabs"
}

variable "engine_version" {
  description = "The version of OpenSearch to deploy."
  type        = string
  default     = "Elasticsearch_7.10"
}

variable "instance_type" {
  description = "The instance type for the OpenSearch cluster."
  type        = string
  default     = "r5.xlarge.search"
}

variable "tags" {
  description = "A map of tags to apply to the OpenSearch domain."
  type        = map(string)
  default     = {
    Domain = "Test"
  }
}

variable "volume_type" {
  description = "The type of EBS volume."
  type        = string
  default     = "gp2" 
}

variable "volume_size" {
  description = "The size of the EBS volume in gigabytes."
  type        = number
  default     = 10    
}

variable "master_nodes" {
  description = "The number of master nodes for the OpenSearch cluster."
  type        = number
  default     = 1
}

variable "worker_nodes" {
  description = "The number of worker nodes in the OpenSearch cluster."
  type        = number
  default     = 1
}
######################################################################################################################################
variable "subnet_ids" {
  description = "A list of subnet IDs within the VPC where OpenSearch nodes will be deployed."
  type        = list(string)
  default = [ "subnet-0cd236092a6928054" ]
}

# variable "security_group_ids" {
#   description = "A list of security group IDs for the OpenSearch domain."
#   type        = list(string)
#   default = [ "sg-0b79870ed838ea4ff" ]
# }

variable "vpc_id" {
  description = "The ID of the VPC where the OpenSearch domain will be deployed."
  type        = string
  default = "vpc-0ac4fbae029ce587b"
}

#######################################################################################################################################

#AWS LAMBDA ansd Slack Notification COnfig:

variable "open_search_cluster_name" {
  description = "Name of the OpenSearch cluster to monitor"
  type        = string
  default = "systlabs"
}

variable "lambda_function_name" {
  description = "Name of the Lambda function to trigger"
  type        = string
  default     = "es-alert-handler"
}

variable "slack_webhook_url" {
  description = "Slack webhook URL for sending notifications"
  type        = string
  default = "https://hooks.slack.com/services/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"
}



############################################################################################################################################