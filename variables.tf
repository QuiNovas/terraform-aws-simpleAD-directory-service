variable "availability_zones" {
  description = "The avaiability zones for the subnets"
  type        = list(string)
  default     = []
}

variable "alias" {
  description = " The alias for the directory (must be unique amongst all aliases in AWS). Required for enable_sso."
  type        = string
  default     = ""
}

variable "cidr_block" {
  description = "The CIDR block for VPC."
  type        = string
  default     = "192.168.0.0/16"
}

variable "description" {
  description = "A textual description for the directory"
  type        = string
  default     = ""
}

variable "enable_sso" {
  description = "Whether to enable single-sign on for the directory. Requires alias. Defaults to false."
  type        = bool
  default     = false
}

variable "name" {
  description = "The fully qualified name for the directory, such as corp.example.com"
  type        = string
}

variable "size" {
  description = "The size of the directory (Small or Large are accepted values)."
  type        = string
}

variable "short_name" {
  description = "The short name of the directory, such as CORP"
  type        = string
  default     = ""
}

variable "type" {
  description = "The directory type (SimpleAD, ADConnector or MicrosoftAD are accepted values)."
  type        = string
  default     = "SimpleAD"
}

variable "tags" {
  description = "A map of tags to assign to the resource."
  type        = map(string)
  default     = {}
}