# Configure the Packet Provider
provider "packet" {
  # auth_token = "${var.auth_token}"
}

# Create a project
resource "packet_project" "ripple_stack_vagrant" {
  name           = "Ripple Stack Vagrant"
  # payment_method = "PAYMENT_METHOD_ID"          # Only required for a non-default payment method
}

# Create a device and add it to tf_project_1
resource "packet_device" "web1" {
  hostname         = "tf.ubuntu"
  plan             = "t1.small.x86"
  facility         = "ams1"
  operating_system = "ubuntu_16_04"
  billing_cycle    = "hourly"
  project_id       = "${packet_project.ripple_stack_vagrant.id}"

  provisioner "remote-exec" {
    inline = [
      "apt-get update",
      "apt-get install -y unzip zip wget build-essential",
      "wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | apt-key add -",
      "wget -q https://www.virtualbox.org/download/oracle_vbox.asc -O- | apt-key add -",
      "add-apt-repository 'deb http://download.virtualbox.org/virtualbox/debian xenial contrib'",
      "apt-get update",
      "apt-get install -y virtualbox-5.2",
      "curl -OL 'https://releases.hashicorp.com/packer/1.3.2/packer_1.3.2_linux_amd64.zip'",
      "unzip ./packer_1.3.2_linux_amd64.zip"
    ]
  }

}
