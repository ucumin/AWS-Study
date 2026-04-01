# WAF Web ACL
resource "aws_wafv2_web_acl" "aws_study_waf" {

  name  = "AWS-Study"
  scope = "REGIONAL"

  default_action {
    allow {}
  }

  visibility_config {
    cloudwatch_metrics_enabled = true
    metric_name                = "AWS-Study"
    sampled_requests_enabled   = true
  }

  rule {
    name     = "AWSManagedRulesCommonRuleSet"
    priority = 0

    override_action {
      none {}
    }

    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesCommonRuleSet"
        vendor_name = "AWS"
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "AWSManagedRulesCommonRuleSet"
      sampled_requests_enabled   = true
    }
  }
}

# WAF と ALB を関連付け
resource "aws_wafv2_web_acl_association" "aws_study_waf_association" {

  resource_arn = aws_lb.aws_study_alb.arn
  web_acl_arn  = aws_wafv2_web_acl.aws_study_waf.arn
}

# WAFログ保存先
resource "aws_cloudwatch_log_group" "waf_log_group" {

  name              = "aws-waf-logs-aws-study"
  retention_in_days = 7
}

# WAF Logging
resource "aws_wafv2_web_acl_logging_configuration" "waf_logging" {

  resource_arn = aws_wafv2_web_acl.aws_study_waf.arn

  log_destination_configs = [
    aws_cloudwatch_log_group.waf_log_group.arn
  ]
}