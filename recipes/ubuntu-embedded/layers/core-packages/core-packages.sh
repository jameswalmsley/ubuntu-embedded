#!/bin/sh

set -ex

echo "Welcome to the core-packages script!"

apt-get -y update
apt-get -y install \
  zsh

apt-get -y autoremove
apt-get -y autoclean
