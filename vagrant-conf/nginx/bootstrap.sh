#!/usr/bin/env bash

sudo su

apt-get -y update 
apt-get -y install --no-install-recommends nginx

mkdir -p /var/log/nginx
#mkdir -p /etc/nginx/

# nginx -g 'daemon off;'

