# SNS Topic
resource "aws_sns_topic" "alarm_topic" {
  name = "aws-study-alarm-topic"
}

# SNS Subscription（メール通知）
resource "aws_sns_topic_subscription" "email_notification" {
  topic_arn = aws_sns_topic.alarm_topic.arn
  protocol  = "email"
  endpoint  = var.alarm_email
}

# CloudWatch Log Group（EC2用）
resource "aws_cloudwatch_log_group" "ec2_log_group" {
  name              = "/aws-study/ec2"
  retention_in_days = 7
}

# CloudWatch Alarm（CPU使用率）
resource "aws_cloudwatch_metric_alarm" "ec2_cpu_alarm" {

  alarm_name          = "aws-study-ec2-cpu-alarm"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 300
  statistic           = "Average"
  threshold           = 80

  alarm_description = "EC2 CPU usage too high"

  dimensions = {
    InstanceId = aws_instance.aws_study_ec2.id
  }

  alarm_actions = [
    aws_sns_topic.alarm_topic.arn
  ]
}

# Metric Filter（WAFログなど検知用）
resource "aws_cloudwatch_log_metric_filter" "waf_block_filter" {

  name           = "waf-block-filter"
  log_group_name = aws_cloudwatch_log_group.waf_log_group.name

  pattern = "{ $.action = \"BLOCK\" }"

  metric_transformation {
    name      = "WAFBlockedRequests"
    namespace = "AWSStudy"
    value     = "1"
  }
}