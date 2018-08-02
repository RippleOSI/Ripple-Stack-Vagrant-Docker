# -*- mode: ruby -*-
# vi: set ft=ruby :

# install the Docker Compose provisioner plugin
unless Vagrant.has_plugin?("vagrant-docker-compose")
  system("vagrant plugin install vagrant-docker-compose")
  raise "Dependencies installed, please try the command again."
  exit
end

# TODO git clones and git pulls of the development repos here on local machine
# these are all to be kept in their own folders so you can develop on them
# and still maintain a coherent Git history in each

Vagrant.configure("2") do |config|
  # start with an Ubuntu 16.04 box TODO: upgrade to latest LTS 18.04
  config.vm.box = "ubuntu/xenial64"

  # forward ports in the guest to ports
  config.vm.network "forwarded_port", guest: 8000, host: 8000 # conductor-service-phr
  config.vm.network "forwarded_port", guest: 8001, host: 8001 # authentication-service-phr
  config.vm.network "forwarded_port", guest: 8002, host: 8002 # mpi-service
  config.vm.network "forwarded_port", guest: 8003, host: 8003 # cdr-service-openehr
  config.vm.network "forwarded_port", guest: 8080, host: 8080 # openid-connect-server

  # Sync the local clones of the development repos with the VM filesystem
  config.vm.synced_folder "../ripple-qewd", "/ripple-qewd"

  config.vm.provision :shell, inline: "sudo apt update"
  config.vm.provision :shell, inline: "sudo apt install -y language-pack-en"

  # install docker
  config.vm.provision :docker, run: "always"

  # install docker-compose & run docker-compose.yml
  config.vm.provision :docker_compose, yml: "/vagrant/docker-compose.yml", rebuild: true, run: "always"
end
