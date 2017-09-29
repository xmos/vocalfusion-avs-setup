#!/usr/bin/env bash
cd $SOURCE_FOLDER/*gst-plugins-base*/
./configure --prefix=$LOCAL_BUILD
make -j3
sudo make install
