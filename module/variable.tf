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
  default     = "r6g.large.search"
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
