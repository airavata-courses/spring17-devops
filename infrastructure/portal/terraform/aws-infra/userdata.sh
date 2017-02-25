#!/usr/bin/env bash

CONSUL_SERVER_IP="52.14.80.85"
THIS_HOST_IP=`wget -qO- http://instance-data/latest/meta-data/public-ipv4`

sudo apt-get update

## Install AWS CLI
sudo apt-get -y install awscli

# AWS CLI configuration
echo "$AWS_ACCESS_KEY
$AWS_SECRET_ACCESS_KEY


" | aws configure

## Install Amazon Codedeploy agent
sudo apt-get update
sudo apt-get -y install python-pip
sudo apt-get -y install ruby
cd /home/ubuntu
wget https://aws-codedeploy-us-east-2.s3.amazonaws.com/latest/install
chmod +x ./install
sudo ./install auto
sudo service codedeploy-agent start

## Install Docker
sudo apt-get -y install apt-transport-https ca-certificates
curl -fsSL https://yum.dockerproject.org/gpg | sudo apt-key add -
sudo apt-get -y install software-properties-common
sudo add-apt-repository "deb https://apt.dockerproject.org/repo/ ubuntu-$(lsb_release -cs) main"
sudo apt-get update
sudo apt-get -y install docker-engine
sudo service docker start

## Start consul server
sudo touch /var/log/sga-consul.log
sudo chmod 777 /var/log/sga-consul.log
sudo docker run -d -e SERVICE_IGNORE -p 8400:8400 -p 8500:8500 -p 8300:8300 -p 8301:8301 -p 8301:8301/udp -p 8302:8302 -p 8302:8302/udp -p 8600:53/udp -h consul`echo $THIS_HOST_IP | cut -d . -f 4` --name consul`echo $THIS_HOST_IP | cut -d . -f 4` progrium/consul -server -advertise $THIS_HOST_IP -join $CONSUL_SERVER_IP >> /var/log/sga-consul.log 2>&1

## Wait for consul to startup
sleep 5

## Start Registrator
sudo docker run -d --name=registrator --net=host --volume=/var/run/docker.sock:/tmp/docker.sock gliderlabs/registrator:latest consul://localhost:8500

## TO-DO Add Portal install script