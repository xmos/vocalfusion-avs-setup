if [[ (! -z $SDK_CONFIG_CLIENT_ID) || (-e $SCRIPTS_DIR/AlexaClientSDKConfig.json) ]]; then
    return
fi

while [[ -z $SDK_CONFIG_CLIENT_ID ]] ; do
    echo "Enter your ClientId:"
    read SDK_CONFIG_CLIENT_ID
    export SDK_CONFIG_CLIENT_ID
done
while [[ -z $SDK_CONFIG_CLIENT_SECRET ]] ; do
    echo "Enter your ClientSecret:"
    read SDK_CONFIG_CLIENT_SECRET
    export SDK_CONFIG_CLIENT_SECRET
done
while [[ -z $SDK_CONFIG_PRODUCT_ID ]] ; do
    echo "Enter your ProductId:"
    read SDK_CONFIG_PRODUCT_ID
    export SDK_CONFIG_PRODUCT_ID
done
while [[ -z $SDK_CONFIG_DEVICE_SERIAL_NUMBER ]] ; do
    echo "Enter your deviceSerialNumber (this can be any number):"
    read SDK_CONFIG_DEVICE_SERIAL_NUMBER
    export SDK_CONFIG_DEVICE_SERIAL_NUMBER
done
while [[ ( "$SETTING_LOCALE_VALUE" != "en-US" ) && \
         ( "$SETTING_LOCALE_VALUE" != "en-GB" ) && \
         ( "$SETTING_LOCALE_VALUE" != "de-DE" ) ]] ; do
    echo "Enter your desired locale (valid values are en-US, en-GB, de-DE):"
    read SETTING_LOCALE_VALUE
    export SETTING_LOCALE_VALUE
done

export SDK_SQLITE_DATABASE_FILE_PATH=$APPS_FILES/alerts.db
export SDK_ALARM_DEFAULT_SOUND_FILE_PATH=$SOUND_FILES/alarm.wav
export SDK_ALARM_SHORT_SOUND_FILE_PATH=$SOUND_FILES/alarm_short.wav
export SDK_TIMER_DEFAULT_SOUND_FILE_PATH=$SOUND_FILES/timer.wav
export SDK_TIMER_SHORT_SOUND_FILE_PATH=$SOUND_FILES/timer_short.wav

export SDK_SQLITE_SETTINGS_DATABASE_FILE_PATH=$APPS_FILES/settings.db
export SDK_CERTIFIED_SENDER_DATABASE_FILE_PATH=$APPS_FILES/certifiedSender.db
