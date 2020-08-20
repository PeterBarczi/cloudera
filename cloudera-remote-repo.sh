# This Script configures server as YUM Repository for CM and CDH

# Define Variables
server=infranode2.dual.edu
# Install all necessary packages
sudo yum -y install wget createrepo yum-utils httpd

# Enable httpd
sudo systemctl enable httpd --now

## Cloudera Manager Part
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


# Create Repo for Cloudera Manager
sudo cat <<EOF > /etc/yum.repos.d/cloudera-manager.repo 
[cloudera-manager]
# Packages for Cloudera Manager, Version 5, on RedHat or CentOS 7 x86_64
name=Cloudera Manager
baseurl=http://$server/cm5/redhat/7/x86_64/cm/5/
gpgkey =http://$server/cm5/redhat/7/x86_64/cm/RPM-GPG-KEY-cloudera
gpgcheck = 1
EOF
## End of Cloudera Manager Part


## Cloudera CDH5 Part
cd /etc/yum.repos.d/
sudo wget https://archive.cloudera.com/cdh5/redhat/7/x86_64/cdh/cloudera-cdh5.repo
# Prepare directories
cd /var/www/html
sudo mkdir -p cdh5/redhat/7/x86_64/cdh/5/
sudo reposync -r cloudera-cdh5
sudo mv cloudera-cdh5/RPMS cdh5/redhat/7/x86_64/cdh/5/
rmdir cloudera-cdh5
# Create local repo
cd cdh5/redhat/7/x86_64/cdh/5/
sudo createrepo .
# GPG Key
cd /var/www/html/cdh5/redhat/7/x86_64/cdh
sudo wget https://archive.cloudera.com/cdh5/redhat/7/x86_64/cdh/RPM-GPG-KEY-cloudera

# Create Repo for CDH
sudo cat <<EOF > /etc/yum.repos.d/cloudera-cdh5.repo
[cloudera-cdh5]
# Packages for Cloudera's Distribution for Hadoop, Version 5, on RedHat or CentOS 7 x86_64
name=Cloudera's Distribution for Hadoop, Version 5
baseurl=http://$server/cdh5/redhat/7/x86_64/cdh/5/
gpgkey =http://$server/cdh5/redhat/7/x86_64/cdh/RPM-GPG-KEY-cloudera
gpgcheck = 1
EOF
## End of CDH5 Part

# Displays repo files
echo "cloudera-manager.repo"
cat /etc/yum.repos.d/cloudera-manager.repo
echo
echo "cloudera-cdh5.repo"
cat /etc/yum.repos.d/cloudera-cdh5.repo
