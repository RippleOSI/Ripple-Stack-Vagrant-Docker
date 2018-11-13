# Boxes

Our Vagrant boxes are built using Packer. Our core configuration comes from the [Boxcutter](https://github.com/boxcutter/ubuntu) vm templates for Ubuntu.

You will need to install [Packer](https://www.packer.io/) and clone Boxcutter/Ubuntu `git clone https://github.com/boxcutter/ubuntu.git`

## Building

In the `packer/` folder you will find the packer definitions and custom scripts for building our Vagrant boxes.

To build the boxes with Packer, copy the .json and .sh files from `packer/` to your clone of Boxcutter/ubuntu

Check each json file for an example usage.

```json
{
  "_comment": "Build with `packer build -var-file=ubuntu1804-desktop.json -var-file=ripple-desktop.json ubuntu.json`",
}
```

    packer build -var-file=ubuntu1804-desktop.json -var-file=ripple-desktop.json ubuntu.json

## Distributing

Boxes versions are released from Vagrantcloud.

## Thank you.

The 23160 contributions from 1654 people to these open source projects made this possible. Thank you.
