#!/usr/bin/env bash
echo "Enter your ClientId:"
read CLIENT_ID
echo "Enter your ClientSecret:"
read CLIENT_SECRET
echo "Enter your deviceTypeId/ProductId:"
read DEVICE_TYPE_ID
echo "Enter your deviceSerialNumber (this can be any number):"
read DEVICE_SERIAL_NUMBER

echo "export SDK_CONFIG_CLIENT_ID=$CLIENT_ID" >> $HOME/.bash_aliases
echo "export SDK_CONFIG_CLIENT_SECRET=$CLIENT_SECRET" >> $HOME/.bash_aliases
echo "export SDK_CONFIG_DEVICE_TYPE_ID=$DEVICE_TYPE_ID" >> $HOME/.bash_aliases
echo "export SDK_CONFIG_DEVICE_SERIAL_NUMBER=$DEVICE_SERIAL_NUMBER" >> $HOME/.bash_aliases
echo "export SDK_SQLITE_DATABASE_FILE_PATH=\"$HOME/BUILD/alerts.db\"" >> $HOME/.bash_aliases
echo "export SDK_ALARM_DEFAULT_SOUND_FILE_PATH=\"$HOME/BUILD/alrm.wav\"" >> $HOME/.bash_aliases
echo "export SDK_ALARM_SHORT_SOUND_FILE_PATH=\"$HOME/BUILD/alrm_sht.wav\"" >> $HOME/.bash_aliases
echo "export SDK_TIMER_DEFAULT_SOUND_FILE_PATH=\"$HOME/BUILD/tmr.wav\"" >> $HOME/.bash_aliases
echo "export SDK_TIMER_SHORT_SOUND_FILE_PATH=\"$HOME/BUILD/tmr_sht.wav\"" >> $HOME/.bash_aliases
source $HOME/.bashrc
