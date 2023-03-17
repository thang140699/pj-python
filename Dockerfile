#FROM python:3.10-slim
## ADD ./code
#RUN mkdir /config
#COPY requirements.txt /config/requirements.txt
#RUN pip install -r /config/requirements.txt
#RUN mkdir /code
#WORKDIR /code
#COPY . .
#
#CMD [ "python", "main.py" ]
FROM python:3.10-slim

WORKDIR /app

RUN apt-get update && apt-get -y install apache2

EXPOSE 80
COPY . .

CMD [ "python3","./main.py"]