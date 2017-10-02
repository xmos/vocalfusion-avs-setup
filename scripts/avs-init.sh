#!/usr/bin/env bash
echo "export SCRIPTS_DIR="$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")"" >> $HOME/.bash_aliases
echo "export SOURCE_FOLDER=$HOME/sources" >> $HOME/.bash_aliases
echo "export LOCAL_BUILD=$HOME/local-builds" >> $HOME/.bash_aliases
echo "export PATH=$HOME/local-builds/bin:$PATH" >> $HOME/.bash_aliases
echo "export PKG_CONFIG_PATH=$HOME/local-builds/lib/pkgconfig:$PKG_CONFIG_PATH" >> $HOME/.bash_aliases
echo "export SDK_SRC=$HOME/AVS_SDK/avs-device-sdk" >> $HOME/.bash_aliases
echo "export VERSION=$(sed 's/\..*//' /etc/debian_version)" >> $HOME/.bash_aliases
echo "alias avsmake=\"cd ~ && . $SCRIPTS_DIR/../auto_install.sh\"" >>  $HOME/.bash_aliases
echo "alias avsrun=\"LD_LIBRARY_PATH=$HOME/local-builds/lib:$LD_LIBRARY_PATH TZ=UTC ~/BUILD/SampleApp/src/SampleApp ~/BUILD/Integration/AlexaClientSDKConfig.json $HOME/local-builds/models\"" >> $HOME/.bash_aliases
echo "alias avsunit=\"pushd LD_LIBRARY_PATH=$HOME/local-builds/lib:$LD_LIBRARY_PATH ~/BUILD && sudo make all test && popd\"" >> $HOME/.bash_aliases
echo "alias avsintegration=\"pushd LD_LIBRARY_PATH=$HOME/local-builds/lib:$LD_LIBRARY_PATH ~/BUILD && sudo make all integration && popd\"" >> $HOME/.bash_aliases
echo "echo \"Available AVS aliases:\"" >> $HOME/.bash_aliases
echo "echo -e \"\tavsmake, avsrun, avsunit, avsintegration\"" >> $HOME/.bash_aliases
echo "echo \"If authentication fails, please check ~/BUILD/Integration/AlexaClientSDKConfig.json\"" >> $HOME/.bash_aliases
echo "echo \"remove .bash_aliases and open a new terminal to remove bindings\"" >> $HOME/.bash_aliases
source $HOME/.bashrc
