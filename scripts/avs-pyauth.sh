#!/usr/bin/env bash
cd $HOME/BUILD
sudo apt-get install -y python-flask python-requests | sed "s/^/[py packages] /"
echo Open localhost:3000 and enter amz dev credentials
python AuthServer/AuthServer.py
cp $HOME/BUILD/Integration/AlexaClientSDKConfig.json $SCRIPTS_DIR/
