terraform {
  required_providers {
    kubectl = {
      source  = "gavinbunney/kubectl"
    }
    helm = {
      source  = "hashicorp/helm"
    }
    http = {
      source = "hashicorp/http"
    }
  }
}

provider "kubectl" {
  config_path    = "~/.kube/config"
  config_context = "kubernetes-admin@cluster.local"
}

provider "helm" {
  kubernetes {
    config_path    = "~/.kube/config"
    config_context = "kubernetes-admin@cluster.local"
  }
}
