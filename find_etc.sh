function find_etc() {
    local PACKAGE_NAME=$1
    local PACKAGE_ETC_NAME=$2
    local result=""
    if [[ "$PACKAGE_NAME"="" ]]; then
        PACKAGE_NAME="s_install"
    fi
    if [[ "$PACKAGE_ETC_NAME"="" ]]; then
        PACKAGE_ETC_NAME="config"
    fi
    etc_path=("." $SCRIPT_HOME/etc/$PACKAGE_NAME $HOME/etc/$PACKAGE_NAME)
    
    for folder in ${etc_path[*]}; do
        if [[ -e $folder/$PACKAGE_ETC_NAME ]]; then
            result=$(realpath $folder/$PACKAGE_ETC_NAME)
            break
        fi
    done
    echo $result
}