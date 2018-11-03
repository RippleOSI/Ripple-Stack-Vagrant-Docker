# Vagrant environments

## RippleOSI Desktop

`vagrant up desktop`

Vagrant will import our Vagrantbox rippleosi/desktop VM and start a VM. Then Docker will fetch the Ripple stack containers and start the services.

## RippleOSI Multi VM

Stack 1
 - `vagrant up stack1`
 - 192.168.50.101

Stack 2
- `vagrant up stack2`
- 192.168.50.102
