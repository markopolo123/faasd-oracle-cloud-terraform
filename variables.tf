variable "oracle_api_key_fingerprint" {}
variable "oracle_api_private_key_path" {}

variable "ssh_public_key" {}
variable "ssh_private_key_path" {}

variable "compartment_ocid" {}
variable "tenancy_ocid" {}
variable "user_ocid" {}

variable "region" {}

variable "instance_display_name" {
  default = "faasd"
}

variable "vcn_cidr_block" {
  default = "10.1.0.0/16"
}

variable "availability_domain_number" {
  default = 1
}

variable "instance_shape" {
  # Free-Tier is VM.Standard.E2.1.Micro
  default = "VM.Standard.E2.1.Micro"
}


variable "instance_image_ocid" {
  type = map

  default = {
    # See https://docs.cloud.oracle.com/en-us/iaas/images/image/cc81a889-bc7f-4b70-b8e7-0503812665be/
    # Oracle-provided image "Canonical-Ubuntu-20.04-2020.07.16-0"
    ap-chuncheon-1 = "ocid1.image.oc1.ap-chuncheon-1.aaaaaaaaafm3nsgeh72ge5r5dmgn57bh4kmpesltosepkh2roe3h4llfpdhq"
    ap-hyderabad-1 = "ocid1.image.oc1.ap-hyderabad-1.aaaaaaaazmbgtzazrssgl45hzw5f23axwno6wx3rhmxxa6shw2ykdbh2pqxa"
    ap-melbourne-1 = "ocid1.image.oc1.ap-melbourne-1.aaaaaaaaa4zpsvzbmugxddymwdfqnwwsw4d4qieveqvcwvrnakf6hnyojama"
    ap-mumbai-1 = "ocid1.image.oc1.ap-mumbai-1.aaaaaaaaf2ctxguwzb6sxkyj2jlirw6o7jl2d6lhbsi2zgihb7wql5v4wa5a"
    ap-osaka-1 = "ocid1.image.oc1.ap-osaka-1.aaaaaaaaijgdp5ihhys3esebzyfv3ug4jgspwdknvdlaodtk4jbxm5a6lbea"
    ap-seoul-1 = "ocid1.image.oc1.ap-seoul-1.aaaaaaaafz2lmkykuzmfvhewxvbyopqedmfdvtbgicite66eka4ap6xvkn2q"
    ap-sydney-1 = "ocid1.image.oc1.ap-sydney-1.aaaaaaaarykwucuw32pt4m7gs7aume5gkatkgckzjq4kfhsm2l7sg4lq2b6a"
    ap-tokyo-1 = "ocid1.image.oc1.ap-tokyo-1.aaaaaaaanylxbn5o4xjseiw5njwye5gy3zqwruwhwwcts3i7nuynaijlz6fq"
    ca-montreal-1 = "ocid1.image.oc1.ca-montreal-1.aaaaaaaarwcfsynqxpfi6vbzjwsskj5gfkzctfh6o3ek43ufn3ak4p5wib2a"
    ca-toronto-1 = "ocid1.image.oc1.ca-toronto-1.aaaaaaaad4woo4hcrlyogpjem4qrxrkjzzib6evemhk62dyp4vmxksamfulq"
    eu-amsterdam-1 = "ocid1.image.oc1.eu-amsterdam-1.aaaaaaaauqwgdatvxhqgzx54z66nmnyb4sr6ez6sx7gafbvufzpksyzhfxea"
    eu-frankfurt-1 = "ocid1.image.oc1.eu-frankfurt-1.aaaaaaaakdtauwupkvi54552qmli3ozzj5zdwlhdfzcluphhyawzv7tqeu7q"
    eu-zurich-1 = "ocid1.image.oc1.eu-zurich-1.aaaaaaaawkkm3xng6doqyoqcmeqjopwee2kqij2ps52v5dlclniamorw3xtq"
    me-dubai-1 = "ocid1.image.oc1.me-dubai-1.aaaaaaaaj7hwquuzayfqwheiz4zxxsq2t4k5eiwc72vywt2qqdusz5vsqyuq"
    me-jeddah-1 = "ocid1.image.oc1.me-jeddah-1.aaaaaaaaiec7saioen3mza5ho5xhtzz37lqyjud2novkuk2wbhidnle6nxca"
    sa-santiago-1 = "ocid1.image.oc1.sa-santiago-1.aaaaaaaadx3snop7di7atjnjfgchbumjkczyphbimt747wsrjilfix7uyjya"
    sa-saopaulo-1 = "ocid1.image.oc1.sa-saopaulo-1.aaaaaaaaobh7kvmplodtn2eweqmdkuyqaxbsghi4mowtgbamuyrkmtyon6ia"
    sa-vinhedo-1 = "ocid1.image.oc1.sa-vinhedo-1.aaaaaaaafvg4fnsexbfr5rmuohr6dzkim23ikdzczm3o6rqhtpz7ye3fmujq"
    uk-cardiff-1 = "ocid1.image.oc1.uk-cardiff-1.aaaaaaaasa22ny7m4jtymkrmq7zkdbhq32xuf7fjr6msiczbvwkty7tjlffa"
    uk-london-1 = "ocid1.image.oc1.uk-london-1.aaaaaaaabua7a5t44bmhgr673yukpaoogs3xblp7fu5o7sglu35j4udb3nha"
    us-ashburn-1 = "ocid1.image.oc1.iad.aaaaaaaaptlkcfoeekceqjkbzfd6rujyqgnwto3ftntolpnshbmaq2a73uzq"
    us-phoenix-1 = "ocid1.image.oc1.phx.aaaaaaaapd67qc2b7q6flfhn3ai5jkpsx4vxz5afch2qwdqujjepvbx25rpq"
    us-sanjose-1 = "ocid1.image.oc1.us-sanjose-1.aaaaaaaa2jqekrtzkdvdksptigewqirjmdtfbpuqcoifn5smxsswrotvpufq"
  }
}

variable "cloudflare_zone_id" {
  type = string
}

variable "cloudflare_api_token" {
  type = string
}

variable "cloudflare_email" {
  type = string
}

variable "faasd_domain" {
  type = string
}

variable "tld" {
  type = string
}

variable "faasd_password" {
  type = string
}