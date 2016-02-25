#!/usr/bin/env bash
#
# build poppler-0.38.0
#

sudo apt-get install -y lbzip2 pkg-config libpng++-dev libxml2-dev libcairo2-dev

wget http://downloads.sourceforge.net/freetype/freetype-2.6.3.tar.bz2
tar xf freetype-2.6.3.tar.bz2
$(cd 'freetype-2.6.3' && ./configure && make && sudo make install)

wget https://launchpad.net/ubuntu/+archive/primary/+files/fontconfig_2.11.1.orig.tar.bz2
tar xf fontconfig_2.11.1.orig.tar.bz2
$(cd 'fontconfig-2.11.1' && ./configure --enable-libxml2 && make && sudo make install)

wget https://launchpad.net/ubuntu/+archive/primary/+files/poppler_0.38.0.orig.tar.xz
tar xf poppler_0.38.0.orig.tar.xz
$(cd 'poppler-0.38.0' && ./configure && make && sudo make install)
