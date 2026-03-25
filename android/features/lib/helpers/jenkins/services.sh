#!/c3po/bash -l

function check_site_services() {
  echo "[SERVICES] Checking if services are running for site: $1"
  case $1 in
    '34')
      PM_URL='http://10.10.160.156:8765/census2'
      CA_URL=''
      check_pm_service PM_URL
      ;;
    '35')
      PM_URL_1='http://10.10.160.175:8765/census2'
      PM_URL_2='http://10.10.160.156:8765/census2'
      CA_URL=''
      check_pm_service PM_URL_1
      check_pm_service PM_URL_2
      ;;
    'NK')
      PM_URL='http://10.10.160.219:8765/census2'
      ;;
    'MPM')
      PM_URL='http://10.10.160.14:8765/census2'
      ;;
    'M9')
      CA_URL=''
      ;;
    'MNX')
      CA_URL=''
      ;;
    *)
      echo "[SERVICES] FAILURE: Unknown Site: '$1'. [exit 1]"
      exit 1
      ;;
  esac
}

function check_pm_service() {
  PM_SERVICE_STATE=`curl $PM_URL`
  echo $PM_SERVICE_STATE
}

check_site_services '34'