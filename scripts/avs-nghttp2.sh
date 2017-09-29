#!/usr/bin/env bash
if [ $VERSION == '9' ]; then
	sudo apt-get install -y nghttp2
else
	cd $SOURCE_FOLDER/*nghttp2*/
	./configure --prefix=$LOCAL_BUILD --disable-app
	make -j3
	sudo make install
fi