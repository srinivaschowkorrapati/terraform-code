#local varibale declaration
locals {
  policy_name = "AIP_${var.env}_AMQ_log_publishing_policy"
}


data "aws_iam_policy_document" "AMQ-log-publishing-policy" {
  statement {
    actions = [
      "logs:CreateLogStream",
      "logs:PutLogEvents",
      "logs:PutLogEventsBatch",
    ]

    resources = ["arn:aws:logs:*:*:log-group:/aws/amazonmq/*"]

    principals {
      identifiers = ["mq.amazonaws.com"]
      type        = "Service"
    }
  }
}

resource "aws_cloudwatch_log_resource_policy" "AMQ-log-publishing-policy" {
  policy_document = data.aws_iam_policy_document.AMQ-log-publishing-policy.json
  policy_name     = local.policy_name
}
