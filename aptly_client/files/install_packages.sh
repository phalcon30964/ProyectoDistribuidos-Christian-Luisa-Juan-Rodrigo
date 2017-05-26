#!/bin/bash

until $(curl --output /dev/null --silent --head --fail http://aptly_mirror:8080)
do   
  sleep 2
done

echo "deb http://aptly_mirror:8080/ xenial main" > /etc/apt/sources.list
 
apt-get clean
apt-get update -y

IFS=', ' read -r -a array <<< "${deps}"
for package in "${array[@]}"
do
 echo installing $package
 apt-get install $package -y
done


httpd-foreground


