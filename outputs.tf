output "instance_id" {
  description = "ocid of created instances. "
  value       = ["${oci_core_instance.faasd_instance.id}"]
}

output "private_ip" {
  description = "Private IPs of created instances. "
  value       = ["${oci_core_instance.faasd_instance.private_ip}"]
}

output "public_ip" {
  description = "Public IPs of created instances. "
  value       = "${oci_core_instance.faasd_instance.public_ip}"
}