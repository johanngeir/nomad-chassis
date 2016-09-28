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
mkdir /etc/nomad.d

# install nomad 
curl https://releases.hashicorp.com/nomad/0.4.1/nomad_0.4.1_linux_amd64.zip | sudo bsdtar -xzf- -C /usr/local/bin/

chmod guo+x /usr/local/bin/*

ipaddr=$(ip addr | awk '/inet/ && /ens/{sub(/\/.*$/,"",$2); print $2}')
echo \n\nConsul seed start:
echo consul agent -server -bootstrap-expect 1 -data-dir /tmp/consul -node=agent-one -bind=$ipaddr -config-dir /etc/consul.d

echo \nNomad config:
echo "echo '# Increase log verbosity
log_level = "DEBUG"

# Setup data dir
data_dir = "/tmp/server1"

# Enable the server
server {
    enabled = true

    # Self-elect, should be 3 or 5 for production
    bootstrap_expect = 1
}' > /etc/nomad.d/server.hcl "
