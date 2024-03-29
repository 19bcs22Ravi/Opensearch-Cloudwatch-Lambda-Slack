resource "aws_opensearch_domain" "opensearch" {
  domain_name    = var.domain_name
  engine_version = var.engine_version

  cluster_config {
    instance_type             = var.instance_type
    dedicated_master_enabled = false
    instance_count           = var.worker_nodes + var.master_nodes
  }

  ebs_options {
    ebs_enabled = true
    volume_type = var.volume_type 
    volume_size = var.volume_size    
  }

  tags = var.tags
}

output "opensearch_domain_id" {
  description = "The ID of the OpenSearch domain."
  value       = aws_opensearch_domain.opensearch.id
}

output "opensearch_endpoint" {
  description = "The endpoint URL of the OpenSearch domain."
  value       = aws_opensearch_domain.opensearch.endpoint
}
