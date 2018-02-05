#!/usr/bin/env bash

# Setup paths
SCRIPTS_DIR="$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")"
source $SCRIPTS_DIR/avs-config.sh

cd $SDK_BUILD
sudo apt-get install -y python-flask python-requests | sed "s/^/[py packages] /"
pip install flask commentjson
sudo fuser -k -TERM -n tcp 3000
python AuthServer/AuthServer.py | grep -v '400' &
chromium-browser http://localhost:3000 > /dev/null 2>&1
wait

# Take a backup
cp $SDK_BUILD/Integration/AlexaClientSDKConfig.json $SCRIPTS_DIR/
