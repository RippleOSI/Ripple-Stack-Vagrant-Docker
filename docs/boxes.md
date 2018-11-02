# Boxes

## Thank you.

Our Vagrant boxes are built using Packer, an open source tool for creating identical machine images for multiple platforms. Our core configuration comes from the Boxcutter vm templates for Ubuntu. 

The 23160 contributions from 1654 people to these open source projects made this possible. Thank you.

## Building


git@github.com:boxcutter/ubuntu.git

    ```json
    {
      "_comment": "Build with `packer build -var-file=ubuntu1804-desktop.json -var-file=rippleosi-desktop.json ubuntu.json`",
      "vm_name": "ubuntu1804-desktop",
      "locale": "en_GB.UTF-8",
      "cpus": "2",
      "memory": "2048",
      "disk_size": "65536",
      "custom_script": "rippleosi-desktop.sh"
    }
    ```

    ```sh
    #!/usr/bin/env bash

    set -eux

    # Sample custom configuration script - add your own commands here
    # to add some additional commands for your environment
    #
    # For example:
    # yum install -y curl wget git tmux firefox xvfb

    # Install Atom editor
    echo "==> Installing Atom"
    apt-key adv --fetch-keys https://packagecloud.io/AtomEditor/atom/gpgkey
    echo 'deb [arch=amd64] https://packagecloud.io/AtomEditor/atom/any/ any main' > /etc/apt/sources.list.d/atom.list
    apt-get update
    apt-get install -y atom

    # Install chromium browser
    echo "==> Installing Chromium browser"
    apt-get install -y chromium-browser
    ```
    
## Distributing

Boxes are manaully uploaded to Vagrantcloud.