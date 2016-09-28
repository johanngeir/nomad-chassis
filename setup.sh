#!/bin/sh

locale-gen is_IS.UTF-8

apt update
apt upgrade
apt install curl unzip bsdtar

# install docker
curl -sSL https://get.docker.com/ | sh
usermod -aG docker $(whoami)

# install consul
curl https://releases.hashicorp.com/consul/0.7.0/consul_0.7.0_linux_amd64.zip | sudo bsdtar -xzf- -C /usr/local/bin/
mkdir /etc/consul.d

# install nomad 
curl https://releases.hashicorp.com/nomad/0.4.1/nomad_0.4.1_linux_amd64.zip | sudo bsdtar -xzf- -C /usr/local/bin/

chmod guo+x /usr/local/bin/*

ipaddr=$(ip addr | awk '/inet/ && /ens/{sub(/\/.*$/,"",$2); print $2}')
echo Consul start:
echo consul agent -server -bootstrap-expect 1 -data-dir /tmp/consul -node=agent-one -bind=$ipaddr -config-dir /etc/consul.d
