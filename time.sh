
token="6125975993:AAFxNHMWbxzsnaFeoNSApt9oM-VPmIy3SQE"

Telebot() {

curl --request POST \
     --url https://api.telegram.org/bot $token/sendMessage \
     --header 'User-Agent: Telegram Bot SDK - (https://github.com/irazasyed/telegram-bot-sdk)' \
     --header 'accept: application/json' \
     --header 'content-type: application/json' \
     --data '
{
     "text": "%s",  '% mess' ,
     "disable_web_page_preview": false,
     "disable_notification": false,
     "reply_to_message_id": null,
     "chat_id": "-853140300"

}
'
}

Time() {

  cpu_current= top -bn1 | grep load | awk '{printf "%.2f%%\t\t\n", $(NF-2)}'
  ram_current= free -m | awk 'NR==2{printf "%.2f%%\t\t", $3*100/$2 }'
  disk_current= df -h | awk '$NF=="/"{printf "%s\t\t", $5}'
  current_date_time=$(date)
  
  while true;
  do
      if [[ -$cpu_current -ge 90 && -$ram_current -ge 90 && -$disk_current -ge 90 ]] ;
      then
         text="Over 90"
         echo $text
         $Telebot
      else
          text2="normal"
          echo $text2
          $Telebot
      fi

      echo  "CPU $cpu_current"
      echo "RAM $ram_current"
      echo "DISK $disk_current"

      output=timeset.txt
      ls > output
      exec 4<> timeset.txt
        echo $current_date_time
        echo $cpu_current
        echo $ram_current
        echo $disk_current
      exec 4>&-
      cat $output
      sleep 60m

  done

}
Time
myfunc(){
  echo "Stating up ..."
  sleep 10s
  echo "startup complete"

  while condition;
  do
      Time
      sleep 5m
  done
#  $Time
}