locals {
  faasd_domain = "${var.faasd_domain}.${var.tld}"
}


resource "oci_core_vcn" "faasd_vcn" {
  cidr_block     = var.vcn_cidr_block
  compartment_id = var.compartment_ocid
  display_name   = "faasdVCN"
  dns_label      = "faasdVCN"
}

resource "oci_core_subnet" "faasd_subnet" {
  availability_domain = data.oci_identity_availability_domain.ad.name
  cidr_block          = "10.1.0.0/24"
  display_name        = "faasdSubnet"
  dns_label           = "faasdSubnet"
  security_list_ids   = [oci_core_security_list.faasd_security_list.id]
  compartment_id      = var.compartment_ocid
  vcn_id              = oci_core_vcn.faasd_vcn.id
  route_table_id      = oci_core_vcn.faasd_vcn.default_route_table_id
  dhcp_options_id     = oci_core_vcn.faasd_vcn.default_dhcp_options_id
}

resource "oci_core_internet_gateway" "faasd_internet_gateway" {
  compartment_id = var.compartment_ocid
  display_name   = "faasd_IG"
  vcn_id         = oci_core_vcn.faasd_vcn.id
}

resource "oci_core_default_route_table" "test_route_table" {
  manage_default_resource_id = oci_core_vcn.faasd_vcn.default_route_table_id

  route_rules {
    destination       = "0.0.0.0/0"
    destination_type  = "CIDR_BLOCK"
    network_entity_id = oci_core_internet_gateway.faasd_internet_gateway.id
  }
}

resource "oci_core_security_list" "faasd_security_list" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_vcn.faasd_vcn.id
  display_name   = "FaaSD Security List"

  // allow outbound tcp traffic on all ports
  egress_security_rules {
    destination = "0.0.0.0/0"
    protocol    = "all"
  }

  // allow inbound ssh traffic from all ports to port
  ingress_security_rules {
    protocol  = "6" // tcp
    source    = "0.0.0.0/0"
    stateless = false

    tcp_options {
      source_port_range {
        min = 1
        max = 65535
      }

      // These values correspond to the destination port range.
      min = 22
      max = 22
    }
  }

  // allow inbound web traffic from all ports to port
  ingress_security_rules {
    protocol  = "6" // tcp
    source    = "0.0.0.0/0"
    stateless = false

    tcp_options {
      source_port_range {
        min = 1
        max = 65535
      }

      // These values correspond to the destination port range.
      min = 443
      max = 443
    }
  }

  // allow inbound web traffic from all ports to port
  ingress_security_rules {
    protocol  = "6" // tcp
    source    = "0.0.0.0/0"
    stateless = false

    tcp_options {
      source_port_range {
        min = 1
        max = 65535
      }

      // These values correspond to the destination port range.
      min = 80
      max = 80
    }
  }
}

resource "oci_core_instance" "faasd_instance" {
  availability_domain = data.oci_identity_availability_domain.ad.name
  compartment_id      = var.compartment_ocid
  display_name        = var.instance_display_name
  shape               = var.instance_shape
  create_vnic_details {
    subnet_id        = oci_core_subnet.faasd_subnet.id
    display_name     = "faasdVNIC"
    assign_public_ip = true
    hostname_label   = var.instance_display_name
  }

  source_details {
    source_type = "image"
    source_id   = var.instance_image_ocid[var.region]
  }

  metadata = {
    ssh_authorized_keys = var.ssh_public_key
    user_data           = base64encode(templatefile("./userdata/bootstrap.sh", {
      faasd_password = var.faasd_password
      faasd_domain = local.faasd_domain
      letsencrypt_email = var.cloudflare_email
      }))
  }
  # user_data           = base64encode(file("./userdata/init.sh"))

  timeouts {
    create = "60m"
  }
}

resource "oci_core_instance_console_connection" "faasd_instance_console_connection" {
  #Required
  instance_id = oci_core_instance.faasd_instance.id
  public_key  = var.ssh_public_key
}

data "oci_identity_availability_domain" "ad" {
  compartment_id = var.compartment_ocid
  ad_number      = var.availability_domain_number
}

# Gets a list of vNIC attachments on the instance
data "oci_core_vnic_attachments" "instance_vnics" {
  compartment_id      = var.compartment_ocid
  availability_domain = data.oci_identity_availability_domain.ad.name
  instance_id         = oci_core_instance.faasd_instance.id
}

# Gets the OCID of the first (default) vNIC
data "oci_core_vnic" "instance_vnic" {
  vnic_id = lookup(data.oci_core_vnic_attachments.instance_vnics.vnic_attachments[0], "vnic_id")
}