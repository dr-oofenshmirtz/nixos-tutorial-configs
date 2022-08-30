#!/bin/sh

echo "Run as sudo"
bakdir="bak-$(date +%s)"
mkdir "/tmp/$bakdir" | true
mv /etc/nixos/* "/tmp/$bakdir"

ln -s "$PWD/flake-time/"* /etc/nixos/

