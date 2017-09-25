#!/usr/bin/env bash
cd $SOURCE_FOLDER/*gstreamer*/
./configure --prefix=$LOCAL_BUILD
make -j3
sudo make install
