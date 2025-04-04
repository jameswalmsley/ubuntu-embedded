#!/bin/sh

echo "Welcome to the core-packages script!"

apt-get -y update
apt-get -y install \
    neovim

apt-get -y autoremove
apt-get -y autoclean

