#!/usr/bin/env bash

wget https://launchpad.net/ubuntu/+archive/primary/+files/poppler_0.38.0.orig.tar.xz

tar xvf poppler_0.38.0.orig.tar.xz
ls -al
cd poppler_0.38.0 && ./configure && make && sudo make install
