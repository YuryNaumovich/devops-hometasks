variable "apache2_container_image" {
  description = "Docker container with apache2 and static site"
  type        = string
  default     = "yurynaumovich/it-academy:v1"
}

variable "apache2_container_name" {
  description = "Docker container name"
  type        = string
  default     = "apache2"
}

variable "apache2_port" {
  description = "Apache2 default port"
  type        = number
  default     = 80
}

variable "apache2_cluster_replicas" {
  description = "K8s cluster apache2 replicas"
  type        = number
  default     = 3
}

variable "k8s_service_app_name" {
  description = "K8s app name"
  type        = string
  default     = "apache2"
}

variable "k8s_service_metadata_name" {
  description = "K8s metadat name"
  type        = string
  default     = "web-service"
}

variable "k8s_service_node_port" {
  description = "K8s service node_port"
  type        = number
  default     = 30000
}
