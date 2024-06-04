variable "varDevs" {
  description = "Name of Role"
  type        = string
  default     = "role-default"
}

variable "Repository" {
  description = "Name if S3 Bucket"
  type        = string
  default     = "default-s3-bucket"
}

variable "VarProduction" {
  description = "name of instancia EC2 VarProduction"
  type        = string
  default     = "default-ec2-instance"
}

variable "VarIntranetCIDR" {
  description = "CIDR of VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "VarSubnetCIDR" {
  description = "CIDR de la Subnet"
  type        = string
  default     = "10.0.1.0/24"
}
