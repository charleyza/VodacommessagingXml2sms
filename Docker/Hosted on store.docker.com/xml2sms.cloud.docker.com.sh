#!/bin/bash
docker pull carlpaton/vodacommessagingxml2sms:v1.0.0
sudo docker container kill xml2sms
sudo docker rm xml2sms

sudo docker run --env-file=env_file_name.env -d -p 81:80 --name xml2sms carlpaton/vodacommessagingxml2sms:v1.0.0

sudo docker start xml2sms
sudo docker ps --all