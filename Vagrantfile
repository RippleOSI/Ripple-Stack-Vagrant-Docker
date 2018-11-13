# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

# Defaults

## Network
$subnet = "192.168.50"

## Docker
$compose_version = "1.21.2"

# Plugins
## Check for required plugins and install missing plugins
plugins_dependencies = %w( vagrant-vbguest vagrant-docker-compose vagrant-hostsupdater )
plugin_status = false
plugins_dependencies.each do |plugin_name|
  unless Vagrant.has_plugin? plugin_name
    puts "Required plugins not found"
    puts "Installing #{plugin_name}"
    system("vagrant plugin install #{plugin_name}")
    plugin_status = true
    puts "Installed #{plugin_name}"
  end
end

## Restart Vagrant if any new plugin installed
if plugin_status === true
  exec "vagrant #{ARGV.join' '}"
else
  plugin_status = false
end

Vagrant.configure("2") do |config|

  # Common options

  ## Mount ripple stack components
  config.vm.synced_folder "../ripple-pulsetile", "/ripple-pulsetile" # Pulsetile
  config.vm.synced_folder "../ripple-qewd", "/ripple-qewd" # Qewd.js

  ## Disable /vagrant mount
  config.vm.synced_folder ".", "/vagrant", disabled: true

  ## Mount docker to /docker
  config.vm.synced_folder "docker/", "/docker/"

  # Ripple VMs

  ## Desktop version
  config.vm.define 'desktop', autostart: false do |d|
    d.vm.box = "rippleosi/desktop"
    d.vm.box_version = "0.1.1"
    d.vm.provider :virtualbox do |v|
      v.cpus = 2
      v.memory = 4096
      v.gui = true
    end

    # Set vm hostname and network
    d.vm.hostname = 'ripple-desktop'
    d.vm.network :private_network, ip: "#{$subnet}.10"

    # Provision with Docker
    d.vm.provision :docker
    d.vm.provision "shell", path: "docker/docker-helpers.sh", args: "vagrant", privileged: false

    # Provision with Docker Compose
    d.vm.provision :docker_compose, compose_version: "#{$compose_version}", yml: "/docker/docker-compose.yml", rebuild: true, run: "always"
  end

  ## Stack/headless version
  config.vm.define "stack", autostart: false do |s|
    s.vm.box = "rippleosi/headless"
    s.vm.box_version = "0.1.1"
    s.vm.provider :virtualbox do |v|
      v.cpus = 2
      v.memory = 2048
    end

    # Set hostname and network
    s.vm.hostname = "ripple-stack"
    s.vm.network :private_network, ip: "#{$subnet}.100"

    # Forward ports in the guest's microservices to host ports
    s.vm.network "forwarded_port", guest: 3000, host: 3000 # Pulsetile
    s.vm.network "forwarded_port", guest: 8000, host: 8000 # conductor-service-phr
    s.vm.network "forwarded_port", guest: 8001, host: 8001 # authentication-service-phr
    s.vm.network "forwarded_port", guest: 8002, host: 8002 # mpi-service
    s.vm.network "forwarded_port", guest: 8003, host: 8003 # cdr-service-openehr
    s.vm.network "forwarded_port", guest: 8080, host: 8080 # openid-connect-server

    # Provision with Docker
    s.vm.provision :docker
    s.vm.provision "shell", path: "docker/docker-helpers.sh", args: "vagrant", privileged: false

    # Provision with Docker Compose
    s.vm.provision :docker_compose, compose_version: "#{$compose_version}", yml: "/docker/docker-compose.yml", rebuild: true, run: "always"
  end


  ## Worker version
  (1..2).each do |i|
    config.vm.define "worker#{i}", autostart: false do |w|
      w.vm.box = "rippleosi/headless"
      w.vm.box_version = "0.1.0"
      w.vm.provider :virtualbox do |v|
        v.cpus = 1
        v.memory = 2048
      end

      # Set vm hostname and network
      w.vm.hostname = "worker#{i}"
      w.vm.network :private_network, ip: "#{$subnet}.#{i+100}"

      # Provision with Docker
      w.vm.provision :docker
      w.vm.provision "shell", path: "docker/docker-helpers.sh", args: "vagrant", privileged: false

      # Provision with Docker Compose
      # w.vm.provision :docker_compose, compose_version: "#{$compose_version}", yml: "/docker/docker-compose.yml", rebuild: true, run: "always"
    end
  end

end
