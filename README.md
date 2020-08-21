# My Cloudera Installation Guide

0. OS Level configuration based on Cloudera prerequisites
>cloudera-os-config.sh

1. Configure server as Local YUM repository server for CM and CDH (on infranode):
>bash cloudera-local-yum-repo.sh


2. Install & Configure MariaDB (on namenode):
>bash cloudera-install-mariadb.sh


3. Install Cloudera Manager (on namenode):
>bash cloudera-install-cm.sh
