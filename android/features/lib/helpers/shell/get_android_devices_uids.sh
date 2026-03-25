#echo $1
PROCESSES=$(ps -ef | grep qemu | awk '{print $2}'|  xargs -I@ lsof -aPi -p @ | awk '{print $2"\t"$9}')
#echo "PROCESSES:${PROCESSES}"

UIDS=$(adb devices | awk '{print $1}' | awk -F- '{print $2}' | sed '/^$/d')
#echo "UIDS:${UIDS}"

emulators=''
while IFS= read -r line ;
do
  while IFS= read -r innerline;
  do
    if [[ "$innerline" == *"$line"* ]]; then
       processId=$(echo $innerline|awk '{print $1}')
#       echo $line
#       ps -ef | grep qemu |grep $processId| awk '{print $9}' | xargs echo $line
       emulators+=$( ps -ef | grep qemu |grep $processId| awk '{print $9}' | xargs echo emulator-$line)"\n"
    fi
#    echo "UID[$line]" `echo $PROCESSES| grep $line`;
  done <<< "$PROCESSES"

done <<< "$UIDS"
if [ $# -eq 0 ]; then
    echo $emulators | uniq
 else
    echo $emulators | uniq | grep $1 | awk '{print $1}'
fi
