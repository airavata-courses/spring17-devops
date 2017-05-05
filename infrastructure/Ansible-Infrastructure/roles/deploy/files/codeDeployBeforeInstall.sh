

sudo service docker start


echo 'Removing the previous image'
if  [ "$(sudo docker images | grep "^<none>" | awk '{print $3}')" != "" ]; then
	sudo docker rmi $(sudo docker images | grep "^<none>" | awk '{print $3}')
fi

echo 'Removing the previous images with exit status'
sudo docker ps -a | grep Exit | cut -d ' ' -f 1 | xargs  --no-run-if-empty sudo docker rm


echo 'check if consul is running'
if [[ "$(sudo docker ps -q --filter ancestor=consul)" == "" ]]; then
    #Allow alias to be used in non-interactive shell
    shopt -s expand_aliases

    # Creating alias for determining the wan ip address and lan ip address of the instance
    alias wanip="dig +short myip.opendns.com @resolver1.opendns.com"
    alias lanip="ifconfig eth0 | sed -En 's/127.0.0.1//;s/.*inet (addr:)?(([0-9]*\.){3}[0-9]*).*/\2/p'"


    #run consul on instance
    sudo docker run --net=host  -d  -e 'CONSUL_LOCAL_CONFIG={"translate_wan_addrs": true}' consul \
            agent  -advertise $(lanip) -ui -advertise-wan $(wanip) -client=0.0.0.0 -retry-join=52.14.96.95
fi

sudo docker ps -a | grep -w "airavata_api_server" | awk '{print $1}' | xargs --no-run-if-empty docker stop
sudo docker ps -a | grep -w "airavata_api_server" | awk '{print $1}' | xargs --no-run-if-empty docker rm

echo 'Remove existing images if any'
sudo docker images | grep -w "airavata_api_server" | awk '{print $3}' | xargs --no-run-if-empty docker rmi -f

echo 'pulling latest image from dockerhub'
sudo docker pull sagarkrkv/airavata_api_server
#
# cd /home/ec2-user/api-deployment/
# rm -rf spring17-API-Server
# mkdir spring17-API-Server
