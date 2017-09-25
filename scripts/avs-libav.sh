#!/usr/bin/env bash
cd $SOURCE_FOLDER/*gst-libav*/
./configure --prefix=$LOCAL_BUILD
make -j3
sudo make install
