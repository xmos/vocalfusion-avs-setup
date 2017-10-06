while [[ -z $SDK_CONFIG_CLIENT_ID ]] ; do
    echo "Enter your ClientId:"
    read SDK_CONFIG_CLIENT_ID
done
while [[ -z $SDK_CONFIG_CLIENT_SECRET ]] ; do
    echo "Enter your ClientSecret:"
    read SDK_CONFIG_CLIENT_SECRET
done
while [[ -z $SDK_CONFIG_DEVICE_TYPE_ID ]] ; do
    echo "Enter your deviceTypeId/ProductId:"
    read SDK_CONFIG_DEVICE_TYPE_ID
done
while [[ -z $SDK_CONFIG_DEVICE_SERIAL_NUMBER ]] ; do
    echo "Enter your deviceSerialNumber (this can be any number):"
    read SDK_CONFIG_DEVICE_SERIAL_NUMBER
done
while [[ ( "$SETTING_LOCALE_VALUE" != "en-US" ) && \
         ( "$SETTING_LOCALE_VALUE" != "en-GB" ) && \
         ( "$SETTING_LOCALE_VALUE" != "de-DE" ) ]] ; do
    echo "Enter your desired locale (valid values are en-US, en-GB, de-DE):"
    read SETTING_LOCALE_VALUE
done

SDK_SQLITE_DATABASE_FILE_PATH=\"$SDK_BUILD/alerts.db\"
SDK_ALARM_DEFAULT_SOUND_FILE_PATH=\"$SOUND_FILES/alarm.wav\"
SDK_ALARM_SHORT_SOUND_FILE_PATH=\"$SOUND_FILES/alarm_short.wav\"
SDK_TIMER_DEFAULT_SOUND_FILE_PATH=\"$SOUND_FILES/timer.wav\"
SDK_TIMER_SHORT_SOUND_FILE_PATH=\"$SOUND_FILES/timer_short.wav\"
