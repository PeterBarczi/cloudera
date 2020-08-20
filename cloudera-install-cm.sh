#!/bin/bash
# This Script Installs Cloudera Manager
clear
## Install necessary packages
# JAVA
echo "Installing JAVA"
sudo yum install oracle-j2sdk1.7 -y
echo "JAVA installed."
# mysql-connector-java
sudo yum install mysql-connector-java

# Install Cloudera Manager
sudo yum -y install cloudera-manager-server
# Configure DB
sudo systemctl stop cloudera-scm-server
/usr/share/cmf/schema/scm_prepare_database.sh mysql -h localhost scm root cloudera
# Start CM
sudo systemctl enable cloudera-scm-server.service
sudo systemctl start cloudera-scm-server.service
