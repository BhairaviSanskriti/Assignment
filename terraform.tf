terraform {

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.52.0"
    }

    tls = {
      source  = "hashicorp/tls"
      version = "~> 4.0.4"
    }

    cloudinit = {
      source  = "hashicorp/cloudinit"
      version = "~> 2.2.0"
    }
    kubectl = {
      source = "gavinbunney/kubectl"
      version = "1.14.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.16.1"
    }

    helm = {
      source = "hashicorp/helm"
      version = "2.8.0"
    }
  }

  required_version = "~> 1.3"
}
