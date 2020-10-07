# This Script configures server as YUM Repository for CM and CDH
clear
# Define Variables
server=192.168.69.219
# Install all necessary packages
sudo yum -y install wget createrepo yum-utils httpd

# Enable httpd
sudo systemctl enable httpd --now

## Cloudera Manager Part
sudo wget https://archive.cloudera.com/cm6/6.1.1/redhat7/yum/cloudera-manager.repo -P /etc/yum.repos.d/
# Prepare directories
cd /var/www/html
sudo mkdir -p cloudera/cm6
sudo reposync -r cloudera-manager
sudo mv /var/www/html/cloudera-manager/RPMS /var/www/html/cloudera/cm6/
rmdir cloudera-manager
# Create local repo
cd /var/www/html/cloudera/cm6
sudo createrepo .
# GPG Key
cd /var/www/html/cloudera/cm6
sudo wget https://archive.cloudera.com/cm6/6.1.1/redhat7/yum/RPM-GPG-KEY-cloudera


# Create Repo for Cloudera Manager
sudo cat <<EOF > /var/tmp/cloudera-manager6.repo 
[cloudera-manager6]
# Packages for Cloudera Manager, Version 6, on RedHat or CentOS 7 x86_64
name=Cloudera Manager
baseurl=http://$server/cloudera/cm6
gpgkey =http://$server/cloudera/cm6/RPM-GPG-KEY-cloudera
gpgcheck = 1
EOF
## End of Cloudera Manager Part


## Cloudera CDH5 Part
cd /etc/yum.repos.d/
sudo cat <<EOF > /etc/yum.repos.d/cloudera-cdh6.repo
[cloudera-cdh6]
name=Cloudera CDH 6.1.1
baseurl=https://archive.cloudera.com/cdh6/6.1.1/redhat7/yum/
gpgkey=https://archive.cloudera.com/cdh6/6.1.1/redhat7/yum/RPM-GPG-KEY-cloudera
gpgcheck=1
enabled=0
autorefresh=0
type=rpm-md
EOF


# Prepare directories
cd /var/www/html
sudo mkdir -p cloudera/cdh6
sudo reposync -r cloudera-cdh6
sudo mv /var/www/html/cloudera-cdh6/RPMS /var/www/html/cloudera/cdh6/
rmdir cloudera-cdh6
# Create local repo
cd /var/www/html/cloudera/cdh6
sudo createrepo .
# GPG Key
cd /var/www/html/cloudera/cdh6
sudo wget https://archive.cloudera.com/cdh6/6.1.1/redhat7/yum/RPM-GPG-KEY-cloudera

# Create Repo for CDH
sudo cat <<EOF > /var/tmp/cloudera-cdh6.repo
[cloudera-cdh6]
# Packages for Cloudera's Distribution for Hadoop, Version 6, on RedHat or CentOS 7 x86_64
name=Cloudera's Distribution for Hadoop, Version 6
baseurl=http://$server/cloudera/cdh6
gpgkey =http://$server/cloudera/cdh6/RPM-GPG-KEY-cloudera
gpgcheck = 1
EOF
## End of CDH5 Part

# Displays repo files
echo "cloudera-manager6.repo"
cat /var/tmp/cloudera-manager6.repo
echo
echo "cloudera-cdh6.repo"
cat /var/tmp/cloudera-cdh6.repo
