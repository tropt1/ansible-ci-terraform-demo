variable "sa_key_file" {
  description = "Path to service account JSON key"
  type        = string
  default     = "key.json"
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
