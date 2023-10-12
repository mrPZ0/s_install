#!/bin/bash

PACKAGE_NAME=s_install
BIN_FOLDER="bin"
ETC_FOLDER="config"
SECRET_FOLDER="secrets"
SOURCE_BIN_LIST=()
SOURCE_ETC_LIST=()
PREINSTALL_CMD=""
POSTINSTALL_CMD=""
DEPENCY=""
function _preinstall() {
    local i
}
function _postinstall() {
    local i
}

if [[ ! -e "./s_install.pkg" ]]; then
    echo file s_install.pkg not found
    exit 1
else
    source ./s_install.pkg
fi

#check
if [[ "$SCRIPT_HOME" == "" ]]; then
    export SCRIPT_HOME="$HOME/Scripts"
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
echo bin copied

#copy to etc

if [[ ! -d "$SCRIPT_ETC/$PACKAGE_NAME" ]]; then
    mkdir -p "$SCRIPT_ETC/$PACKAGE_NAME"
fi
for item in $SOURCE_ETC_LIST ; do
    target_name="$SCRIPT_ETC/$PACKAGE_NAME/$(basename $item)"
    cp -fuR $item $target_name
done
cp -fuR ./s_install.pkg "$SCRIPT_ETC/$PACKAGE_NAME/"
echo configs copied


#create secrets folder
if [[ ! -d "$SCRIPT_SECRETS/$PACKAGE_NAME" ]]; then
    mkdir -p "$SCRIPT_SECRETS/$PACKAGE_NAME"
fi
echo secrets copied

