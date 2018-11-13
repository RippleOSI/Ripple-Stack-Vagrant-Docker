#!/usr/bin/env bash

set -eux

# Install Atom editor
echo "==> Installing Atom"
apt-key adv --fetch-keys https://packagecloud.io/AtomEditor/atom/gpgkey
echo 'deb [arch=amd64] https://packagecloud.io/AtomEditor/atom/any/ any main' > /etc/apt/sources.list.d/atom.list
apt-get update
apt-get install -y atom

# Install chromium browser
echo "==> Installing Chromium browser"
apt-get install -y chromium-browser
