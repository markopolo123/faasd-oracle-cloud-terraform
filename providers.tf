terraform {
  required_providers {
    cloudflare = {
      source = "cloudflare/cloudflare"
      version = "2.21.0"
    }
    oci = {
      source = "hashicorp/oci"
      version = "4.31.0"
    }
  }
}

provider "cloudflare" {
  # Configuration options
  api_token = var.cloudflare_api_token
}


provider "oci" {
  tenancy_ocid     = var.tenancy_ocid
  user_ocid        = var.user_ocid
  fingerprint      = var.oracle_api_key_fingerprint
  private_key_path = var.oracle_api_private_key_path
  region           = var.region
}