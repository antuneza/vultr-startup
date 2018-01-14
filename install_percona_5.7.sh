#!/bin/sh

export MYSQL_ROOT_PASSWORD=${MYSQL_ROOT_PASSWORD:-root}

wget https://repo.percona.com/apt/percona-release_0.1-4.$(lsb_release -sc)_all.deb
sudo dpkg -i percona-release_0.1-4.$(lsb_release -sc)_all.deb

sudo apt-get update

echo "percona-server-server-5.7 percona-server-server-5.7/root-pass password $MYSQL_ROOT_PASSWORD" | sudo debconf-set-selections
echo "percona-server-server-5.7 percona-server-server-5.7/re-root-pass password $MYSQL_ROOT_PASSWORD" | sudo debconf-set-selections

sudo apt-get -y install percona-server-server-5.7

