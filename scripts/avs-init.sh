#!/usr/bin/env bash

# Setup paths
SCRIPTS_DIR="$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")" 
source $SCRIPTS_DIR/avs-config.sh

echo "export PATH=$SDK_BUILD/bin:$PATH" >> $HOME/.bash_aliases
echo "export PKG_CONFIG_PATH=$SDK_BUILD/lib/pkgconfig:$PKG_CONFIG_PATH" >> $HOME/.bash_aliases
echo "alias avsmake=\"cd ~ && . $SCRIPTS_DIR/../auto_install.sh\"" >>  $HOME/.bash_aliases
echo "alias avsrun=\"LD_LIBRARY_PATH=$SDK_BUILD/lib:$LD_LIBRARY_PATH TZ=UTC $SDK_BUILD/SampleApp/src/SampleApp $SDK_BUILD/Integration/AlexaClientSDKConfig.json $SDK_BUILD/models\"" >> $HOME/.bash_aliases
echo "alias avsunit=\"LD_LIBRARY_PATH=$SDK_BUILD/lib:$LD_LIBRARY_PATH pushd $SDK_BUILD && sudo make all test && popd\"" >> $HOME/.bash_aliases
echo "alias avsintegration=\"LD_LIBRARY_PATH=$SDK_BUILD/lib:$LD_LIBRARY_PATH pushd $SDK_BUILD && sudo make all integration && popd\"" >> $HOME/.bash_aliases
echo "echo \"Available AVS aliases:\"" >> $HOME/.bash_aliases
echo "echo -e \"\tavsmake, avsrun, avsunit, avsintegration\"" >> $HOME/.bash_aliases
echo "echo \"If authentication fails, please check $SDK_BUILD/Integration/AlexaClientSDKConfig.json\"" >> $HOME/.bash_aliases
echo "echo \"remove .bash_aliases and open a new terminal to remove bindings\"" >> $HOME/.bash_aliases
source $HOME/.bashrc
