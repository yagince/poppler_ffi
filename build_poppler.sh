#!/usr/bin/env bash

echo "[Download]"
wget https://launchpad.net/ubuntu/+archive/primary/+files/poppler_0.38.0.orig.tar.xz

echo "[Unarchive]"
tar xf poppler_0.38.0.orig.tar.xz

echo "[Make & Install]"
cd poppler_0.38.0
./configure
make
sudo make install
