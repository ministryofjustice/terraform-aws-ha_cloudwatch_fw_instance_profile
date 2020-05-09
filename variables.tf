variable "name" {
  description = "Name to prepend to IAM resources"
  default     = "palo"
  type        = string
}

variable "enable_ha" {
  description = "Enable for HA IAM policy"
  default     = false
  type        = bool
}

variable "enable_cw" {
  description = "Enable for CW IAM policy"
  default     = false
  type        = bool
}

variable "enable_bs" {
  description = "Enable boostrap bucket"
  default     = false
  type        = bool
}

variable "bs_bucket" {
  description = "name of bootstrap bucket"
  default     = ""
  type        = string
}
