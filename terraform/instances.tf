# Create a project
resource "packet_project" "packer_builder" {
  name           = "Ripple Vagrant Builder"
}

# Create a device and add it to tf_project_1
resource "packet_device" "builder" {
  hostname         = "builder.ubuntu"
  plan             = "x1.small.x86"
  facility         = "lax1"
  operating_system = "ubuntu_16_04"
  billing_cycle    = "hourly"
  project_id       = "${packet_project.packer_builder.id}"

  provisioner "remote-exec" {
    inline = [
      "curl -fSsl https://www.virtualbox.org/download/oracle_vbox_2016.asc | apt-key add -",
      "curl -fSsl https://www.virtualbox.org/download/oracle_vbox.asc | apt-key add -",
      "add-apt-repository 'deb http://download.virtualbox.org/virtualbox/debian xenial contrib'",
      "DEBIAN_FRONTEND=noninteractive apt-get update",
      "DEBIAN_FRONTEND=noninteractive apt-get upgrade -y",
      "DEBIAN_FRONTEND=noninteractive apt-get install -y unzip zip git build-essential gcc make linux-headers-generic linux-headers-$(uname -r) dkms",
      "DEBIAN_FRONTEND=noninteractive apt-get install -y virtualbox-5.2",
      "curl -OL 'https://releases.hashicorp.com/packer/1.3.2/packer_1.3.2_linux_amd64.zip'",
      "unzip ./packer_1.3.2_linux_amd64.zip",
      "install packer /usr/local/bin"
    ]
  }
}
