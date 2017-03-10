#!/usr/bin/env bash

yum -y update
yum -y install wget
yum -y install java-1.8.0-openjdk
cd /home/centos/
wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat/jenkins.repo
rpm --import http://pkg.jenkins-ci.org/redhat/jenkins-ci.org.key
yum -y install jenkins
chkconfig jenkins on
service jenkins start
