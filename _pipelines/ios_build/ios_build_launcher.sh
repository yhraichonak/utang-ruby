#!/bin/zsh
IGNORE_EXISTING_BINARIES=false
SIMILATOR_PREPARE_ONLY=false
IOS_BINARIES_STORAGE_PATH=/Users/yhraichonak/WORK/utang/AS1-iOS-binaries
REMOTE_DESTINATION_ROOT_FOLDER=/Users/qaautomation/AS1-iOS-binaries
if [ "$#" -lt 1 ]
then
  echo "Incorrect number of arguments provided (expected 1). Use following syntax:
  ios_build_launcher.sh [CSV_CONFIG_FILE_LOCATION] [IGNORE_EXISTING_BINARIES] [SIMILATOR_PREPARE_ONLY] [REMOTE_DESTINATION]
  Sample:
       - ios_build_config.csv true false qaautomation@10.10.170.125
  NOTE:
       - set CWD to checked out ios-as1
       - use zsh for running"
  exit 1
fi
TOOL_ROOT_DIR=$(dirname "$0")

filename=$1

if [ -n "$2" ]
then
  IGNORE_EXISTING_BINARIES=$2
fi

if [ -n "$3" ]
then
  SIMILATOR_PREPARE_ONLY=$3
fi


if [ -n "$4" ]
then
  REMOTE_DESTINATION=$4
fi

echo "config file name: [$filename]"
sed 1d $TOOL_ROOT_DIR/$filename | while IFS=, read -r PLATFORM DEVICE_TYPE AS1_VERSION SCHEME SDK
do
  DEVICE_TYPE_N0RMALIZED=$(echo $DEVICE_TYPE | sed 's/ /_/g;s/(//g;s/)//g')
  LOCAL_DESTINATION_FULL_PATH=$IOS_BINARIES_STORAGE_PATH/$AS1_VERSION/$PLATFORM/$DEVICE_TYPE_N0RMALIZED/AS1-$AS1_VERSION-iOS_$PLATFORM-$DEVICE_TYPE_N0RMALIZED.app
  $TOOL_ROOT_DIR/ios_build.sh $PLATFORM $DEVICE_TYPE $AS1_VERSION $IOS_BINARIES_STORAGE_PATH $SCHEME $SDK $IGNORE_EXISTING_BINARIES $SIMILATOR_PREPARE_ONLY $REMOTE_DESTINATION || true
  if [ -n "$REMOTE_DESTINATION" ]
  then
    REMOTE_DESTINATION_FOLDER=$REMOTE_DESTINATION_ROOT_FOLDER/$AS1_VERSION/$PLATFORM/$DEVICE_TYPE_N0RMALIZED
    REMOTE_DESTINATION_FULL_PATH=$REMOTE_DESTINATION_FOLDER/AS1-$AS1_VERSION-iOS_$PLATFORM-$DEVICE_TYPE_N0RMALIZED.app
    echo "Trying to upload binary to remote destination: [$REMOTE_DESTINATION]"
    REMOTE_DIR_EXISTS=$(ssh -n $REMOTE_DESTINATION 'ls '"$REMOTE_DESTINATION_FULL_PATH"' 2>&1')
    echo "REMOTE_DIR_EXISTS: $REMOTE_DIR_EXISTS"
    if [[ "$REMOTE_DIR_EXISTS" == *"No such file or directory"* ]]
    then
      ssh -n $REMOTE_DESTINATION "mkdir -p $REMOTE_DESTINATION_FOLDER"
      echo "Binary $REMOTE_DESTINATION_FULL_PATH does not exist on remote system. Uploading.."
      scp -r $LOCAL_DESTINATION_FULL_PATH "$REMOTE_DESTINATION:$REMOTE_DESTINATION_FOLDER/"
    else
      echo "Binary $REMOTE_DESTINATION_FULL_PATH already exists on remote system. Skip uploading"
    fi
  fi

done
