variable "yc_token" {
  description = "IAM OAuth-token for access to Yandex Cloud"
  type        = string
}

variable "cloud_id" {
  description = "Yandex Cloud ID"
  type        = string
}

variable "folder_id" {
  description = "Yandex Folder ID"
  type        = string
}

variable "zone" {
  description = "Compute zone"
  type        = string
  default     = "ru-central1-a"
}
