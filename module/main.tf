resource "aws_opensearch_domain" "opensearch" {
  domain_name    = var.domain_name
  engine_version = var.engine_version
  ####################################################################################################################################
   vpc_options {
    subnet_ids               = var.subnet_ids
    # vpc_id =var.vpc_id
  }

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
#########################################################################################################################################
#AWS LAMBDA ansd Slack Notification COnfig:

resource "aws_cloudwatch_metric_alarm" "opensearch_green_alarm" {
  alarm_name          = "OpenSearchGreenAlarm"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = 1
  metric_name         = "ClusterStatus.green"
  namespace           = "AWS/OpenSearch"
  period              = 60
  statistic           = "Maximum"
  threshold           = 1
  alarm_description   = "Alarm triggered when OpenSearch cluster status is green"
  actions_enabled     = true
  dimensions = {
    DomainName = var.domain_name
  }

  # Trigger Lambda function when alarm state changes to "OK" (green)
  alarm_actions = [aws_lambda_function.lambda_function.arn]
}

# AWS Lambda Function to handle the CloudWatch Alarm trigger
resource "aws_lambda_function" "lambda_function" {
  filename      = "./lambda_function_payload.zip"
  function_name = var.lambda_function_name
  role          = aws_iam_role.lambda_role.arn
  handler       = "lambda_function.lambda_handler"
  runtime       = "python3.12"
}

# AWS IAM Role for Lambda function
resource "aws_iam_role" "lambda_role" {
  name = "lambda_execution_role"

  assume_role_policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Principal": {
          "Service": "lambda.amazonaws.com"
        },
        "Action": "sts:AssumeRole"
      }
    ]
  })
}

# Attach policies to IAM role for Lambda function
resource "aws_iam_role_policy_attachment" "lambda_attachment" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

# Lambda IAM policy to allow necessary OpenSearch actions
resource "aws_iam_policy" "lambda_opensearch_policy" {
  name        = "LambdaOpenSearchAccessPolicy"
  description = "Policy to allow Lambda function to interact with OpenSearch"
  policy      = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Action": [
          "es:DescribeElasticsearchDomain",
          "es:DescribeDomain"
        ],
        "Resource": "*"
      }
    ]
  })
}

# Attach Lambda IAM policy to IAM role
resource "aws_iam_role_policy_attachment" "lambda_opensearch_policy_attachment" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = aws_iam_policy.lambda_opensearch_policy.arn
}

#########################################################################################################################################

resource "aws_lambda_permission" "demo_lambda_every_one_minute" {
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda_function.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.opensearch_green_alarm.arn
}

resource "aws_cloudwatch_event_rule" "opensearch_green_alarm" {
  name                = "OpensearchGreenAlarmRule"
  description         = "Rule to trigger Lambda function every one minute"
  schedule_expression = "rate(1 minute)"
}

resource "aws_cloudwatch_event_target" "lambda_target" {
  rule      = aws_cloudwatch_event_rule.opensearch_green_alarm.name
  target_id = "TargetFunction"
  arn       = aws_lambda_function.lambda_function.arn
}
