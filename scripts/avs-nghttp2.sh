#!/usr/bin/env bash
cd $SOURCE_FOLDER/*nghttp2*/
./configure --prefix=$LOCAL_BUILD --disable-app
make -j3
sudo make install
