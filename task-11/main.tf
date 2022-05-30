terraform {
  required_providers {
    kubernetes = {
      source = "hashicorp/kubernetes"
      version = "2.11.0"
    }
    github = {
      source = "integrations/github"
      version = "4.26.0"
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

resource "kubernetes_namespace" "terraform-default" {
  metadata {
    name = "terraform-default"
  }
}

provider "github" {
  # Configuration options
  token = "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"
  owner = "YuryNaumovich"
}
