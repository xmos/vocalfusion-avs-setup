#!/usr/bin/env bash
if [ ! $VERSION == 9 ]; then
	cd $SOURCE_FOLDER/*openssl*/
	./config --prefix=$LOCAL_BUILD --openssldir=$LOCAL_BUILD shared
	make -j3
	sudo make install
fi
