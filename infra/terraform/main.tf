provider "aws" {
  region  = var.region
  profile = var.aws_profile
}

# 현재 연결된 계정 정보 조회 (읽기 전용, 무료)
data "aws_caller_identity" "current" {}
data "aws_region" "current" {}
