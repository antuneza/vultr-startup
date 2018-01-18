#!/bin/sh

sudo apt-get update
sudo apt-get upgrade -y

sudo apt-get install -y build-essential

sudo sh -c 'echo "Asia/Hong_Kong" > /etc/timezone'
sudo ln -s /usr/share/zoneinfo/Asia/Hong_Kong /etc/localtime 
