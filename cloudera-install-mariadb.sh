#!/bin/bash
# This Script automates the MariaDB Installation & Configuration Process needed for CM
clear

# Install and Start MariaDB
echo "Installing MariaDB...."
yum install -y mariadb mariadb-server
systemctl enable mariadb --now

# Performs Secure Installation
echo "Securing Installation of MariaDB....."
echo "
Y
test
test
Y
Y
Y
Y"| /usr/bin/mysql_secure_installation
echo "MariaDB secured!"


# Create Databases, Users and set Privileges
echo "Creating Databases, Users and setting Privileges....."
mysql -u root -plipovnik << SQL_COMMANDS
CREATE DATABASE scm;
CREATE DATABASE hive;
CREATE DATABASE oozie;
CREATE DATABASE hue;
CREATE DATABASE reportmanager;

CREATE USER 'hive'@'%' IDENTIFIED BY 'itversity';
CREATE USER 'oozie'@'%' IDENTIFIED BY 'itversity';
CREATE USER 'hue'@'%' IDENTIFIED BY 'itversity';
CREATE USER 'rm'@'%' IDENTIFIED BY 'itversity';
CREATE USER 'scm'@'%' IDENTIFIED BY 'itversity';

GRANT ALL PRIVILEGES ON scm.* TO 'scm'@'%';
GRANT ALL PRIVILEGES ON hive.* TO 'hive'@'%';
GRANT ALL PRIVILEGES ON oozie.* TO 'oozie'@'%';
GRANT ALL PRIVILEGES ON hue.* TO 'hue'@'%';
GRANT ALL PRIVILEGES ON reportmanager.* TO 'rm'@'%';

FLUSH PRIVILEGES;
SQL_COMMANDS

echo "Done."