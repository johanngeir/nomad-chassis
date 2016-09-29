#!/bin/sh
ipaddr=$(ip addr | awk '/inet/ && /ens/{sub(/\/.*$/,"",$2); print $2}')
consul agent -server -bootstrap-expect 1 -data-dir /tmp/consul -node=agent-one -bind=$ipaddr -config-dir /etc/consul.d