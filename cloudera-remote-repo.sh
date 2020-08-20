# This Script configures server as YUM Repository for CM and CDH

# Install all necessary packages
sudo yum -y install wget createrepo yum-utils httpd

# Enable httpd
sudo systemctl enable httpd --now

# Cloudera Manager Part
cd /etc/yum.repos.d/
sudo wget https://archive.cloudera.com/cm5/redhat/7/x86_64/cm/cloudera-manager.repo
# Prepare directories
cd /var/www/html
sudo mkdir -p cm5/redhat/7/x86_64/cm/5
sudo reposync -r cloudera-manager
sudo mv /var/www/html/cloudera-manager/RPMS /var/www/html/cm5/redhat/7/x86_64/cm/5
rmdir cloudera-manager
# Create local repo
cd /var/www/html/cm5/redhat/7/x86_64/cm/5
sudo createrepo .
# GPG Key
cd /var/www/html/cm5/redhat/7/x86_64/cm/
sudo wget https://archive.cloudera.com/cm5/redhat/7/x86_64/cm/RPM-GPG-KEY-cloudera


