output "builder ip" {
  value = "ssh root@${packet_device.builder.network.0.address}"
}
