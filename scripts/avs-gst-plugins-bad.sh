#!/usr/bin/env bash
cd $SOURCE_FOLDER/*gst-plugins-bad*/
./configure --prefix=$LOCAL_BUILD
make -j3
sudo make install
