## terraform

```sh
git clone https://github.com/robdyke/Ripple-Stack-Vagrant-Docker.git stack
cd stack
git checkout feature-vagrant-dev-env
cd ../
git clone https://github.com/boxcutter/ubuntu.git
cd ubuntu
packer build -only=virtualbox-iso -var-file=ubuntu1804.json -var-file=../stack/packer/ripple-stack.json ubuntu.json
```
