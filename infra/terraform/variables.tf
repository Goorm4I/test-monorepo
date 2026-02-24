variable "region" {
  description = "AWS 리전"
  type        = string
  default     = "ap-southeast-2"
}

variable "aws_profile" {
  description = "AWS CLI 프로필 이름 (null이면 AWS_PROFILE 환경변수 또는 default 프로필 사용)"
  type        = string
  default     = null
}

variable "project_name" {
  description = "프로젝트 이름 (리소스 태그에 사용)"
  type        = string
  default     = "timedeal"
}
