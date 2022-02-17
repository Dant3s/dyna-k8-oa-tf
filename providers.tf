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
  config_path    = var.k8configpath
  config_context = var.k8context
}

provider "helm" {
  kubernetes {
    config_path    = var.k8configpath
    config_context = var.k8context
  }
}
