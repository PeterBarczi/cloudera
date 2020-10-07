#!/bin/bash
# Removes MariaDB
sudo yum -y remove mariadb mariadb-server
sudo rm -rf /var/lib/mysql
sudo rm /etc/my.cnf
sudo rm -rf /etc/my.cnf.d/
