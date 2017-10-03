#!/usr/bin/env bash
cd $HOME/BUILD
sudo apt-get install -y python-flask python-requests | sed "s/^/[py packages] /"
python AuthServer/AuthServer.py &
ServerPID=$! &
chromium-browser http://localhost:3000
wait $ServerPID
cp $HOME/BUILD/Integration/AlexaClientSDKConfig.json $SCRIPTS_DIR/
