##Install Docker on ubuntu
 sudo apt-get install apt-transport-https                        ca-certificates
 curl -fsSL https://yum.dockerproject.org/gpg | sudo apt-key add -
 apt-key fingerprint 58118E89F3A912897C070ADBF76221572C52609D
 sudo add-apt-repository        "deb https://apt.dockerproject.org/repo/ \
       ubuntu-$(lsb_release -cs) \
       main"
 sudo apt-get update
 sudo apt-get -y install docker-engine
 
 
 ##Starts consul server inside docker ubuntu
 sudo docker run -d -p 8400:8400 -p 8500:8500 -p 8300:8300 -p 8301:8301 -p 8301:8301/udp -p 8302:8302 -p 8302:8302/udp -p 8600:53/udp -h consul --name consul progrium/consul -server -advertise `wget -qO- http://instance-data/latest/meta-data/public-ipv4` -bootstrap >> /var/log/sga-consul.log 2>&1
 ## UI - IP:8500/ui
 
## Start consul agent on laravel instance
sudo docker run -d -p 8400:8400 -p 8500:8500 -p 8300:8300 -p 8301:8301 -p 8301:8301/udp -p 8302:8302 -p 8302:8302/udp -p 8600:53/udp -h consulAgent1 --name consulAgent1 progrium/consul -server -advertise `wget -qO- http://instance-data/latest/meta-data/public-ipv4` -join 52.14.33.15 >> /var/log/sga-consul.log 2>&1
 
 
 ## Start registrator 
 sudo docker run -d --name=registrator --net=host --volume=/var/run/docker.sock:/tmp/docker.sock gliderlabs/registrator:latest consul://localhost:8500
 
 
 sudo docker build --no-cache -t sga/laravel:v1 .
 
 sudo docker run -it --name laravelApp -v /home/ubuntu/laravel-portal/spring17-laravel-portal/:/var/www/laravel/ -h sga.portal -p 8089:80 -d sga/laravel:v1
