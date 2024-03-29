variable "domain_name" {
  description = "The name of the OpenSearch domain."
  type        = string
  default     = "systlabs"
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

variable "region" {
  default = "ap-south-1"
}

variable "master_nodes_needed" {
  type        = bool
  default     = false
}

variable "worker_nodes_needed" {
  type        = bool
  default     = true  # by default there will be one worker nodes will be created you can configure master node and number of nodes as per req.
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
