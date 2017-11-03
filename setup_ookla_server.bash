#!/bin/bash

# Notes: 

# http://www.ookla.com/hosttester.php
# http://www.ookla.com/host
# http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/install-LAMP.html





#Install tools
sudo yum install -y telnet
sudo yum install -y git


#Initially Setup Ookla
cd /home/ec2-user
wget http://install.speedtest.net/ooklaserver/ooklaserver.sh
chmod a+x ooklaserver.sh
yes | ./ooklaserver.sh install

#Initially Setup Ookla
./ooklaserver.sh start





##Update /etc/rc.local

sudo echo "" >> /etc/rc.local
sudo echo "###################### START: ADDED BY setup_ookla_server.bash ######################" >> /etc/rc.local
sudo echo "./home/ec2-user/OoklaServer --daemon" >> /etc/rc.local
sudo echo "" >> /etc/rc.local
sudo echo "###################### END: ADDED BY setup_ookla_server.bash ######################" >> /etc/rc.local






#Install php and httpd for HTTP based test
sudo yum update -y
sudo yum install -y httpd24 php70
sudo service httpd start
sudo chkconfig httpd on
chkconfig --list httpd
sudo usermod -a -G apache ec2-user
ls /var/www/
sudo chown -R ec2-user:apache /var/www
ls /var/www/
sudo chmod 2775 /var/www
find /var/www -type d -exec sudo chmod 2775 {} \;
find /var/www -type f -exec sudo chmod 0664 {} \;




















