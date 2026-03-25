#!/c3po/bash -l

function run_tests () {
  cd "${WORKSPACE}"
  pwd
  bundle
  echo "[CUCUMBER] Cucumber Settings"
  echo "[CUCUMBER] Features directory: 'android/features'"
  echo "[CUCUMBER] Flags/tags: ${TAGS}"
  echo "[CUCUMBER] Site name: {$SITE_NAME_CI}"
  echo "[CUCUMBER] Starting cucumber test run..."
  cucumber android/features/ ${TAGS} -r android/features/ -p debug SITE_NAME_CI=${SITE_NAME_CI}
  echo "[CUCUMBER] Completed cucumber test run."
}