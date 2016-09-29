#!/bin/sh

locale-gen is_IS.UTF-8

apt -y update
apt -y upgrade
apt -y install unzip bsdtar wget

# install docker
curl -sSL https://get.docker.com/ | sh
usermod -aG docker $(whoami)

# install consul
curl https://releases.hashicorp.com/consul/0.7.0/consul_0.7.0_linux_amd64.zip | bsdtar -xzf- -C /usr/local/bin/
mkdir /etc/consul.d
mkdir /etc/nomad.d

# install nomad 
curl https://releases.hashicorp.com/nomad/0.4.1/nomad_0.4.1_linux_amd64.zip | bsdtar -xzf- -C /usr/local/bin/

wget -O /etc/nomad.d/server.hcl https://raw.githubusercontent.com/johanngeir/nomad-chassis/master/server.hcl
wget -O /usr/local/bin/seed-consul.sh https://raw.githubusercontent.com/johanngeir/nomad-chassis/master/seed-consul.sh
wget -O /usr/local/bin/start-nomad.sh https://raw.githubusercontent.com/johanngeir/nomad-chassis/master/start-nomad.sh

chmod guo+x /usr/local/bin/*

