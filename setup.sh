#!/bin/sh

sudo locale-gen is_IS.UTF-8

apt update
apt upgrade
apt install curl

curl -sSL https://get.docker.com/ | sh
usermod -aG docker $(whoami)
