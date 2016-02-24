#!/usr/bin/env bash

wget https://poppler.freedesktop.org/poppler-0.41.0.tar.xz
tar xf poppler-0.41.0.tar.xz
cd poppler
./configure
make
sudo main install

# TODO: install poppler-data
