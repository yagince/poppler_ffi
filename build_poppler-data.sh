#!/usr/bin/env bash

wget http://poppler.freedesktop.org/poppler-data-0.4.7.tar.gz
tar xf poppler-data-0.4.7.tar.gz
cd poppler-data
./configure
make
sudo make install
