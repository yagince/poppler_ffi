#!/usr/bin/env bash

wget https://launchpad.net/ubuntu/+archive/primary/+files/poppler_0.38.0.orig.tar.xz

echo $(tar xvf poppler_0.38.0.orig.tar.xz)
echo $(ls -al)
echo $(cd poppler_0.38.0 && ./configure && make && sudo make install)
