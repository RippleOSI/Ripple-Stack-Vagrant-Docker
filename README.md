# ripple-vagrant
Development version of the Ripple Stack deployed via Vagrant (for cross-platform usability) and the docker-compose provisioner (for simplicity and minimal configuration)

This repository contains a Vagrantfile and a Docker Compose file which automate the setup of a working Ripple Stack

Why use Vagrant and Docker?
Docker on its own is not completely at home on all platforms, Windows in particular being a problem. In order to make the development experience the same on all platforms, we've wrapped the development environment in a headless virtual machine (which is actually how the Ripple stack developer documentation suggests to do it anyway). Virtual machines work on all platforms and the Ubuntu guest that is created then gives us a consistent and reproducible development environment on all platforms.

Inside this VM we use Docker and docker-compose to orchestrate the creation of all of the Ripple Stack components, preconfigured to be able to communicate with each other.

Pulsetile

Ripple Microservices

EtherCIS
