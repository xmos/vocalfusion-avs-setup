#!/usr/bin/env bash
cd $SOURCE_FOLDER/*curl*/
./configure --with-ssl=$LOCAL_BUILD --with-nghttp2=$LOCAL_BUILD --prefix=$LOCAL_BUILD
make -j3
sudo make install

# or sudo apt-get install -y libcurl4-openssl-dev
