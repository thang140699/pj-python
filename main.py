import datetime
import email.message
import logging
import os
import socket
import psutil
import time
import sys
import json
import requests
from datetime import datetime
import systemd.daemon

now = datetime.now()
current_time = now.strftime("%H:%M:%S")
token = "6125975993:AAFxNHMWbxzsnaFeoNSApt9oM-VPmIy3SQE"
url = f"https://api.telegram.org/bot{token}/sendMessage"
NAME_FILE="time.txt"


def telebot(mess):

    payload = {
        "text": "%s" % mess,
        "chat_id": "-853140300",
        "disable_web_page_preview": False,
        "disable_notification": False,
        "reply_to_message_id": None
    }
    headers = {
        "accept": "application/json",
        "User-Agent": "Telegram Bot SDK - (https://github.com/irazasyed/telegram-bot-sdk)",
        "content-type": "application/json"
    }

    response = requests.post(url, json=payload, headers=headers)

    print(json.loads(response.text))

def get_time():
    try:

        host_name = socket.gethostname()
        host_ip = socket.gethostbyname(host_name)
        current_cpu = psutil.cpu_percent()
        current_ram = psutil.virtual_memory()[2]
        current_disk = psutil.disk_usage('/')[3]

        starttime = time.time()
        while True:
            if current_ram >= 90  and current_cpu >=90 and current_disk >=90:
                text="Over 90%"
                telebot(text)
            else:
                text2="Machine is normal"
                telebot(text2)

            print("CPU",current_cpu,"\tRam",current_ram,"\tDisk",current_disk)
            f = open("time.txt", "w+")
            f.writelines(f"{current_time} : CPU {current_cpu} %, RAM {current_ram} %, DISK {current_disk} %")
            f.close()
            time.sleep(60*60)

    except Exception as err:
        raise err
        print("Unable to get Hostname and IP and Current CPU, Disk and Ram")



if __name__ == "__main__":

    print('Starting up...')
    time.sleep(10)
    print('Startup complete')
    systemd.daemon.notify('READY=1')
    while True:
        get_time()
        time.sleep(5)


# get_time()
