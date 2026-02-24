variable "region" {
  description = "AWS 리전"
  type        = string
  default     = "ap-southeast-2"
}

variable "aws_profile" {
  description = "AWS CLI 프로필 이름"
  type        = string
  default     = "goorm"
}

variable "project_name" {
  description = "프로젝트 이름 (리소스 태그에 사용)"
  type        = string
  default     = "timedeal"
}
