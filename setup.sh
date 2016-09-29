#!/bin/sh

locale-gen is_IS.UTF-8

apt update
apt upgrade
apt install unzip bsdtar

# install docker
curl -sSL https://get.docker.com/ | sh
usermod -aG docker $(whoami)

# install consul
curl https://releases.hashicorp.com/consul/0.7.0/consul_0.7.0_linux_amd64.zip | sudo bsdtar -xzf- -C /usr/local/bin/
mkdir /etc/consul.d
mkdir /etc/nomad.d

# install nomad 
curl https://releases.hashicorp.com/nomad/0.4.1/nomad_0.4.1_linux_amd64.zip | sudo bsdtar -xzf- -C /usr/local/bin/

chmod guo+x /usr/local/bin/*

ipaddr=$(ip addr | awk '/inet/ && /ens/{sub(/\/.*$/,"",$2); print $2}')
#echo \n\nConsul seed start:
#echo consul agent -server -bootstrap-expect 1 -data-dir /tmp/consul -node=agent-one -bind=$ipaddr -config-dir /etc/consul.d

sudo wget -O /etc/nomad.d/ https://raw.githubusercontent.com/johanngeir/nomad-chassis/master/server.hcl
sudo wget -O /usr/local/bin/ https://raw.githubusercontent.com/johanngeir/nomad-chassis/master/seed-consul.sh
sudo wget -O /usr/local/bin/ https://raw.githubusercontent.com/johanngeir/nomad-chassis/master/start-nomad.sh

echo \nNomad seed start
echo sudo nomad agent -config server.hcl