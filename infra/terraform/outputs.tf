output "account_id" {
  description = "AWS 계정 ID"
  value       = data.aws_caller_identity.current.account_id
}

output "caller_arn" {
  description = "현재 IAM 사용자 ARN"
  value       = data.aws_caller_identity.current.arn
}

output "region" {
  description = "현재 리전"
  value       = data.aws_region.current.name
}
