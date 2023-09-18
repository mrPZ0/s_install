#!/bin/bash

BIN_FOLDER="bin"
ETC_FOLDER="etc"
SECRET_FOLDER="secrets"

if [[ ! -e "./s_install.pkg" ]];then
    echo file s_install.pkg not found
    exit 1
else
    source ./s_install.pkg
fi

#check
if [[ "$SCRIPT_HOME"="" ]]; then
    export SCRIPT_HOME="$HOME"
fi
SCRIPT_FOLDER="$SCRIPT_HOME/$BIN_FOLDER"
SCRIPT_ETC=$SCRIPT_HOME/$ETC_FOLDER
SCRIPT_SECRETS=$SCRIPT_HOME/$SECRET_FOLDER

#copy to bin
if [[ ! -d "$SCRIPT_FOLDER" ]]; then
    mkdir -p "$SCRIPT_FOLDER"
fi
for item in $SOURCE_BIN_LIST ; do
    cp -fuR $item "$SCRIPT_FOLDER/$item"
done

#copy to etc

if [[ ! -d "$SCRIPT_ETC/$PACKAGE_NAME" ]]; then
    mkdir -p "$SCRIPT_ETC/$PACKAGE_NAME"
fi
cp -fuR ./s_install.pkg "$SCRIPT_ETC/$PACKAGE_NAME/"

for item in $SOURCE_ETC_LIST ; do
    target_name="$SCRIPT_ETC/$PACKAGE_NAME/$(basename $item)"
    cp -fuR $item $target_name
done

#create secrets folder
if [[ ! -d "$SCRIPT_SECRETS/$PACKAGE_NAME" ]]; then
    mkdir -p "$SCRIPT_SECRETS/$PACKAGE_NAME"
fi


