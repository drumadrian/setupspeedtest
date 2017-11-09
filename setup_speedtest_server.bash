#!/bin/bash
# Notes: 

# https://stackoverflow.com/questions/84882/sudo-echo-something-etc-privilegedfile-doesnt-work-is-there-an-alterna
# http://docs.aws.amazon.com/sdk-for-javascript/v2/developer-guide/setting-up-node-on-ec2-instance.html
# https://superuser.com/questions/93385/run-part-of-a-bash-script-as-a-different-user
# https://stackoverflow.com/questions/7642674/how-do-i-script-a-yes-response-for-installing-programs
# https://github.com/soterinsights/speedtest
# https://github.com/drumadrian/setupspeedtest
# https://www.skorks.com/2010/03/how-to-quickly-generate-a-large-file-on-the-command-line-with-linux/
# https://github.com/soterinsights/speedtest/issues/8



# REMEMBER:  RUN THIS SCRIPT AS THE ec2-user WHEN LOGGED INTO THE SERVER 

#Install tools
sudo yum update -y 
sudo yum install -y telnet
sudo yum install -y git



#Download and install NVM 
cd /home/ec2-user
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.32.0/install.sh | bash
. ~/.nvm/nvm.sh
nvm install 4.5


#check node installation
node -e "console.log('Running Node.js ' + process.version)"


#download the GitHub Speed Test app
cd /home/ec2-user
git clone https://github.com/soterinsights/speedtest.git
git clone https://github.com/drumadrian/setupspeedtest.git


#start the GitHub Speed Test app now
sudo -u ec2-user bash /home/ec2-user/setupspeedtest/runspeedtestapp.bash



##update /etc/rc.local   So it starts the GitHub Speed Test at boot
echo "" | sudo tee --append /etc/rc.local
echo "###################### START: ADDED BY setup_speedtest_server.bash ######################" | sudo tee --append /etc/rc.local
echo "sudo -u ec2-user bash /home/ec2-user/setupspeedtest/runspeedtestapp.bash" | sudo tee --append /etc/rc.local
echo "" | sudo tee --append /etc/rc.local
echo "###################### END: ADDED BY setup_speedtest_server.bash ######################" | sudo tee --append /etc/rc.local







# setup adrian files for download testing
sudo yum update -y
sudo yum update -y
sudo yum install -y httpd24
sudo service httpd start
sudo chkconfig httpd on
chkconfig --list httpd
sudo usermod -a -G apache ec2-user
ls -al /var/www/
sudo chown -R ec2-user:apache /var/www
ls -al /var/www/
sudo chmod 2775 /var/www
find /var/www -type d -exec sudo chmod 2775 {} \;
find /var/www -type f -exec sudo chmod 0664 {} \;



#create 1GB file
cd /var/www/html
dd if=/dev/zero of=file.txt count=1048576 bs=1024

#Create healthcheck page and welcome page
touch healthcheck.html
echo "Healthy" | sudo tee --append healthcheck.html
touch index.html
echo "Hello SpeedTester" | sudo tee --append index.html
echo -e "<br>"  >> index.html
echo -e "<br>"  >> index.html
echo -e "<br>"  >> index.html
echo -e "<br>"  >> index.html
echo "<a href=http://speedtest.adrianws.com:8080> For HTTP Speed Test click here </a>" | sudo tee --append index.html
echo -e "<br>"  >> index.html
echo -e "<br>"  >> index.html
echo -e "<br>"  >> index.html
echo "<a href=https://speedtest.adrianws.com/file.txt> For HTTPS 1 GB file download click here </a>" | sudo tee --append index.html
echo -e "<br>"  >> index.html
echo -e "<br>"  >> index.html
echo -e "<br>"  >> index.html
echo "<a href=http://speedtest.adrianws.com/file.txt> For HTTP 1 GB file download click here </a>" | sudo tee --append index.html


#Re-Setup all permissions
ls -al /var/www/
sudo chown -R ec2-user:apache /var/www
sudo chmod 2775 /var/www
find /var/www -type d -exec sudo chmod 2775 {} \;
find /var/www -type f -exec sudo chmod 0664 {} \;
ls -al /var/www/






