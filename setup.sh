#!/bin/sh
sudo su -

locale-gen is_IS.UTF-8

apt update
apt upgrade
apt install curl unzip bsdtar

# install docker
curl -sSL https://get.docker.com/ | sh
usermod -aG docker $(whoami)

# install consul
curl https://releases.hashicorp.com/consul/0.7.0/consul_0.7.0_linux_amd64.zip | sudo bsdtar -xzf- -C /usr/local/bin/

# install nomad 
curl https://releases.hashicorp.com/nomad/0.4.1/nomad_0.4.1_linux_amd64.zip | sudo bsdtar -xzf- -C /usr/local/bin/

chmod guo+x /usr/local/bin/*