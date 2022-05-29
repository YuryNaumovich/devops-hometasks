terraform {
  required_providers {
    kubernetes = {
      source = "hashicorp/kubernetes"
      version = "2.11.0"
    }
  }

  backend "kubernetes" {
    secret_suffix    = "state"
    config_path      = "~/.kube/config"
  }

}

provider "kubernetes" {
# Configuration options
   config_context_cluster   = "minikube"
   config_path = "~/.kube/config"
}

resource "kubernetes_namespace" "default" {
  metadata {
    name = "default"
  }
}
