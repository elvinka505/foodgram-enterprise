variable "cloud_id" {}
variable "folder_id" {}

variable "domain" {
  description = "Домен, делегированный в Cloud DNS, без точки на конце"
}

variable "node_memory" {
  description = "Память узла в ГБ"
  default     = 4
}