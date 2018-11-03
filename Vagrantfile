# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

# Check for required plugins and install missing plugins
required_plugins = %w( vagrant-vbguest vagrant-docker-compose )
required_plugins.each do |plugin|
    exec "vagrant plugin install #{plugin};vagrant #{ARGV.join(" ")}" unless Vagrant.has_plugin? plugin || ARGV[0] == 'plugin'
end

# Network defaults
$subnet = "192.168.50"

Vagrant.configure("2") do |config|

  # Mount ripple stack components
  config.vm.synced_folder "../ripple-pulsetile", "/ripple-pulsetile" # Pulsetile
  config.vm.synced_folder "../ripple-qewd", "/ripple-qewd" # Qewd.js

  # Disable /vagrant mount
  config.vm.synced_folder ".", "/vagrant", disabled: true

  # Mount docker to /docker
  config.vm.synced_folder "docker/", "/docker/"

  # Define desktop version
  config.vm.define 'desktop', autostart: false do |d|
    d.vm.box = "rippleosi/desktop"
    d.vm.box_version = "0.1.0"
    d.vm.provider :virtualbox do |v|
      v.cpus = 2
      v.memory = 4096
      v.gui = true
    end
    d.vm.hostname = 'ripple-desktop'
    d.vm.network :private_network, ip: "#{$subnet}.10"
    d.vm.provision :docker
    d.vm.provision "shell", path: "docker/docker-helpers.sh", args: "engine", privileged: false
    d.vm.provision "shell", path: "docker/docker-helpers.sh", args: "compose", privileged: false
  end

  # Define headless version
    config.vm.define "stack", autostart: false do |s|
      s.vm.box = "rippleosi/headless"
      s.vm.box_version = "0.1.0"
      s.vm.provider :virtualbox do |v|
        v.cpus = 1
        v.memory = 2048
      end
      s.vm.hostname = "ripple-stack"
      s.vm.network :private_network, ip: "#{$subnet}.100"
      # forward ports in the guest's microservices to host ports
      s.vm.network "forwarded_port", guest: 8000, host: 8000 # conductor-service-phr
      s.vm.network "forwarded_port", guest: 8001, host: 8001 # authentication-service-phr
      s.vm.network "forwarded_port", guest: 8002, host: 8002 # mpi-service
      s.vm.network "forwarded_port", guest: 8003, host: 8003 # cdr-service-openehr
      s.vm.network "forwarded_port", guest: 8080, host: 8080 # openid-connect-server
      s.vm.provision :docker
      s.vm.provision "shell", path: "docker/docker-helpers.sh", args: "engine", privileged: false
      s.vm.provision "shell", path: "docker/docker-helpers.sh", args: "compose", privileged: false
    end

  # Define pair of headless version
  (1..2).each do |i|
    config.vm.define "worker#{i}", autostart: false do |s|
      s.vm.box = "rippleosi/headless"
      s.vm.box_version = "0.1.0"
      s.vm.provider :virtualbox do |v|
        v.cpus = 1
        v.memory = 2048
      end
      s.vm.hostname = "worker#{i}"
      s.vm.network :private_network, ip: "#{$subnet}.#{i+100}"
      s.vm.provision :docker
      s.vm.provision "shell", path: "docker/docker-helpers.sh", args: "engine", privileged: false
    end
  end

end
