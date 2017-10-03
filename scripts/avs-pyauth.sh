#!/usr/bin/env bash
cd $HOME/BUILD
sudo apt-get install -y python-flask python-requests | sed "s/^/[py packages] /"
sudo fuser -k -TERM -n tcp 3000
python AuthServer/AuthServer.py | grep -v '400' &
chromium-browser http://localhost:3000 > /dev/null 2>&1
wait
cp $HOME/BUILD/Integration/AlexaClientSDKConfig.json $SCRIPTS_DIR/
