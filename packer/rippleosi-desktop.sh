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
