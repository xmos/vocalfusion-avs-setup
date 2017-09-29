#!/usr/bin/env bash
if [ -z $SOURCE_FOLDER ]; then
	echo "Environment not set correctly, delete ~/.bash_aliases and try again"
	exit 1
fi

cd $SOURCE_FOLDER
wget https://github.com/nghttp2/nghttp2/releases/download/v1.0.0/nghttp2-1.0.0.tar.gz
tar xzf nghttp2-1.0.0.tar.gz
wget https://www.openssl.org/source/old/1.0.2/openssl-1.0.2a.tar.gz
tar xzf openssl-1.0.2a.tar.gz
wget https://curl.haxx.se/download/curl-7.50.2.tar.gz
tar xzf curl-7.50.2.tar.gz
wget https://gstreamer.freedesktop.org/src/gstreamer/gstreamer-1.10.4.tar.xz
tar xf gstreamer-1.10.4.tar.xz
wget https://gstreamer.freedesktop.org/src/gst-plugins-base/gst-plugins-base-1.10.4.tar.xz
tar xf gst-plugins-base-1.10.4.tar.xz
wget https://gstreamer.freedesktop.org/src/gst-libav/gst-libav-1.10.4.tar.xz
tar xf gst-libav-1.10.4.tar.xz
wget https://gstreamer.freedesktop.org/src/gst-plugins-good/gst-plugins-good-1.10.4.tar.xz
tar xf gst-plugins-good-1.10.4.tar.xz
wget https://gstreamer.freedesktop.org/src/gst-plugins-bad/gst-plugins-bad-1.10.4.tar.xz
tar xf gst-plugins-bad-1.10.4.tar.xz
wget http://www.portaudio.com/archives/pa_stable_v190600_20161030.tgz
tar xf pa_stable_v190600_20161030.tgz
