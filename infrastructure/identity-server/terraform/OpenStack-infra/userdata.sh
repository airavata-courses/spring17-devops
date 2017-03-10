#!/usr/bin/env bash

yum -y update
yum -y install wget
yum -y install java-1.8.0-openjdk
cd /home/centos/
wget https://downloads.jboss.org/keycloak/2.5.4.Final/keycloak-2.5.4.Final.tar.gz
tar xfz keycloak-2.5.4.Final.tar.gz
cd keycloak-2.5.4.Final/bin
nohup ./standalone.sh -b 0.0.0.0 &
