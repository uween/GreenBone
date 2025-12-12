#!/bin/sh

# Clear the existing default route issued by Docker
ip route del default

# Run dhclient to obtain an IP address
dhclient eth0

# Add the docker host in to resolv.conf
echo "nameserver 172.20.0.1" > /etc/resolv.conf

# Run the main entrypoint
exec /usr/local/bin/entrypoint ospd-openvas --config /etc/gvm/ospd-openvas.conf -f -m 666