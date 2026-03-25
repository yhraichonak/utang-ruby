#!/c3po/bash -l

source /Users/${USER}/.bash_profile

PACKAGE="#{APP_PACKAGE}"
OR_BUILD_VERSION=6.10.2[RC]
OR_BUILD_NUMBER=0

function get_last_rc_number () {
  echo "[BUILD] Finding RC build number..."
  if [[ ${OR_BUILD_NUMBER} == 0 ]]; then
    BUILD_NUMBER=$(python /Users/${USER}/development/appium/android/features/lib/helpers/python_lib/last_successful_build_number.py)
    BUILD_VERSION=$(python /Users/${USER}/development/appium/android/features/lib/helpers/python_lib/last_successful_build_version.py)
  else
    BUILD_NUMBER=${OR_BUILD_NUMBER}
    BUILD_VERSION=${OR_BUILD_VERSION}
  fi
  echo "[BUILD] Last RC build number: $BUILD_NUMBER , version: $BUILD_VERSION"
}

function copy_remote_build () {
  cd /Users/${USER}/Development/builds/as1/android
#  rm -rf *
  mkdir -p archive/; mv *.* archive/; rm -f *.apk # Archive builds/logs
  echo "[BUILD] Copying remote Jenkins builds to local directory for testing."
  PATH_QA_DEBUG_FROM=/var/lib/jenkins/jobs/utangONE_Android_release_candidate/builds/"${BUILD_NUMBER}"/archive/AS1/build/outputs/apk/qa/debug/AS1-*-qa-debug.apk
  PATH_QA_DEBUG_TO=-AS1-${BUILD_VERSION}-${BUILD_NUMBER}-qa-debug.apk

  PATH_QA_RELEASE_FROM=/var/lib/jenkins/jobs/utangONE_Android_release_candidate/builds/"${BUILD_NUMBER}"/archive/AS1/build/outputs/apk/qa/release/AS1-*-qa-release.apk
  PATH_QA_RELEASE_TO=/Users/qaautomation/Development/builds/as1/android/AS1-${BUILD_VERSION}-${BUILD_NUMBER}-qa-release.apk

  QA_DEBUG_PACKAGE_NAME=as1-${BUILD_VERSION}-${BUILD_NUMBER}-qa-debug
  QA_RELEASE_PACKAGE_NAME=as1-${BUILD_VERSION}-${BUILD_NUMBER}-qa-release

  scp -r jenkins@10.10.160.13:$PATH_QA_DEBUG_FROM $PATH_QA_DEBUG_TO
  scp -r jenkins@10.10.160.13:$PATH_QA_RELEASE_FROM $PATH_QA_RELEASE_TO
  echo "[BUILD] Finished copying builds."
}

function uninstall_build () {
  echo "[BUILD] Uninstalling existing package/APK."
  adb uninstall $PACKAGE
  STATUS= check_package_state $PACKAGE
  if [ $STATUS == true ]; then
    echo "[BUILD] WARN: Package not successfully uninstalled."
  else
    echo "[BUILD] Successfully uninstalled build."
  echo "[BUILD] APK installation finished."
}

function check_package_state () {
  STATUS=`adb shell pm list packages | grep $1`
  if [[ $STATUS == *$PACKAGE_MAIN* ]]; then
    return true
  else
    return false
  fi
}

function install_build () {
  echo "[BUILD] Site environment type: ${SITE_TYPE}"
  echo "[BUILD] Installing test package/APK."
  if [ "${SITE_TYPE}" == "QA" ]; then
    adb install /Users/${USER}/Development/builds/as1/android/${QA_DEBUG_PACKAGE_NAME}.apk > ${QA_DEBUG_PACKAGE_NAME}.install.txt
    echo "[BUILD] Finished installing [DEBUG] ${QA_DEBUG_PACKAGE_NAME}.apk"
  elif [ "${SITE_TYPE}" == "PROD" ]; then
      adb install /Users/${USER}/Development/builds/as1/android/${QA_RELEASE_PACKAGE_NAME}.apk > ${QA_RELEASE_PACKAGE_NAME}.install.txt
      echo "[BUILD] Finished installing [PRODUCTION] ${QA_RELEASE_PACKAGE_NAME}.apk"
  else
    echo "[BUILD] ERROR: SITE ENVIRONMENT type not recognized !"
  fi

  STATUS= check_package_state $PACKAGE
  if [ $STATUS == true ]; then
    echo "[BUILD] Successfully installed build."
  else
    echo "[BUILD] FAILURE: Package not successfully installed. [exit 1]"
    exit 1
  fi

  VERSION_NAME=$(adb shell dumpsys package com.utang.one.qa | grep versionName | cut -d'=' -f2)
  echo "VERSION_NAME=${VERSION_NAME}"
}


function set_build_info () {
  declare -a data_values

  # Load file into array.
  let i=0
  while IFS=$'\n' read -r line_data; do
      data_values[i]="${line_data}"
      ((++i))
  done < /Users/${USER}/development/appium/buildInfo.txt

  APP_VERSION="${data_values[0]}"
  BLD_NUMBER="${data_values[1]}"

  printf "${APP_VERSION}\n"
  printf "${BLD_NUMBER}\n"

  echo APP_VERSION=${APP_VERSION} > propsfile
  echo BLD_NUMBER=${BLD_NUMBER} >> propsfile
}
