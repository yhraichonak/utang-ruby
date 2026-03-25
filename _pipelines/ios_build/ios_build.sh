#!/bin/zsh
if [ "$#" -lt 6 ]
then
  echo "Incorrect number of arguments provided (expected 6). Use following syntax:
  build_ios.sh [PLATFORM_VERSION] \"[DEVICE_TYPE]\" [AS1_VERSION] [IOS_BINARIES_STORAGE_PATH] \"[SCHEME]\" [SDK]"

  exit 1
fi
echo "platform: [iOS$1]"
PLATFORM_VERSION=$1
echo "deviceType: [$2]"
DEVICE_TYPE=$2
DEVICE_TYPE_N0RMALIZED=$(echo $DEVICE_TYPE | sed 's/ /_/g;s/(//g;s/)//g')
echo "as1Version: [$3]"
AS1_VERSION=$3
echo "iOSBinariesStorage: [$4]"
IOS_BINARIES_STORAGE=$4
IOS_BINARIES_RELATIVE_PATH=$AS1_VERSION/$PLATFORM_VERSION/$DEVICE_TYPE_N0RMALIZED
IOS_BINARIES_PATH=$IOS_BINARIES_STORAGE/$IOS_BINARIES_RELATIVE_PATH
echo "iOSBinaryPath: [$IOS_BINARIES_PATH]"
echo "scheme: [$5]"
SCHEME=$5
echo "sdk: [$6]"
SDK=$6
IGNORE_EXISTING=false
if [ -n "$7" ]
then
  echo "ignoreExisting: [$7]"
  IGNORE_EXISTING=$7
fi
SIMILATOR_PREPARE_ONLY=false
if [ -n "$8" ]
then
  echo "simulatorPrepareOnly: [$8]"
  SIMILATOR_PREPARE_ONLY=$8
fi

DESTINATION="platform=iOS Simulator,OS=$PLATFORM_VERSION,name=$DEVICE_TYPE"
echo "DESTINATION: [$DESTINATION]"

device_exists=`xcrun xctrace list devices | grep "$DEVICE_TYPE Simulator ($PLATFORM_VERSION)"`
if [[ -z "$device_exists" ]];then
  echo "##[warning]Simulator $DEVICE_TYPE Simulator ($PLATFORM_VERSION) does not exists. Trying to create.."
  EXIT_CODE=0
  simulator_creation=`xcrun simctl create "$DEVICE_TYPE" "$DEVICE_TYPE" "iOS$PLATFORM_VERSION" 2>&1` || EXIT_CODE=$?
  if [ $EXIT_CODE -ne 0 ]; then
    echo "##[group][AVAILABLE DEVICES]"
    xcrun xctrace list devices | xargs -L1 echo \#\#\[warning\]
    echo "##[endgroup]"
    echo "##vso[task.logissue type=error;]Unable to create $DEVICE_TYPE iOS$PLATFORM_VERSION"
  fi
else
  echo "##[command]Simulator $DEVICE_TYPE Simulator ($PLATFORM_VERSION) exists."
fi
if [[ $SIMILATOR_PREPARE_ONLY == "true" ]]; then
    exit 0
fi
  mkdir -p $IOS_BINARIES_PATH
if test -d "$IOS_BINARIES_PATH/AS1-$AS1_VERSION-iOS_$PLATFORM_VERSION-$DEVICE_TYPE_N0RMALIZED.app"; then
    echo "Binary $IOS_BINARIES_PATH/AS1-$AS1_VERSION-iOS_$PLATFORM_VERSION-$DEVICE_TYPE_N0RMALIZED.app exists."
    if [[ $IGNORE_EXISTING == "true" ]]; then
        exit 0
    fi
fi

/usr/libexec/PlistBuddy -c "Set :CFBundleShortVersionString $AS1_VERSION"  "./One/One/One-Info.plist"
xcodebuild -project 'One/One.xcodeproj' -scheme "$SCHEME" -destination "$DESTINATION" -sdk "$SDK" -configuration 'Debug' -derivedDataPath 'build' -quiet
rm -fr $IOS_BINARIES_PATH/AS1-$AS1_VERSION-iOS_$PLATFORM_VERSION-$DEVICE_TYPE_N0RMALIZED.app
cp -fr "build/Build/Products/Debug-$SDK/$SCHEME.app"  $IOS_BINARIES_PATH/AS1-$AS1_VERSION-iOS_$PLATFORM_VERSION-$DEVICE_TYPE_N0RMALIZED.app
