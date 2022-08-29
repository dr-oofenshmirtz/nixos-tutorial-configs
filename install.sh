#!/bin/sh

echo "Run as sudo"

mkdir bak | true
mv /etc/nixos/* ./bak

chown `logname`: ./bak

ln -s "$PWD/nixos-only/"* /etc/nixos/

