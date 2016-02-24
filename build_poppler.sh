#!/usr/bin/env bash

echo "[Download]"
wget https://poppler.freedesktop.org/poppler-0.41.0.tar.xz

echo "[Unarchive]"
tar xf poppler-0.41.0.tar.xz

echo "[Make & Install]"
cd poppler-0.41.0
./configure
make
sudo make install
