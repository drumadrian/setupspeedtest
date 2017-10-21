


#Install tools
sudo yum install -y telnet
sudo yum install -y git



#Setup GitHub Speed Test
cd /home/ec2-user
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.32.0/install.sh | bash
. ~/.nvm/nvm.sh
nvm install 4.4.5


#check node installation
node -e "console.log('Running Node.js ' + process.version)"


#download the speed test app
cd /home/ec2-user
git clone https://github.com/soterinsights/speedtest.git


##update /etc/rc.local
echo "" | sudo tee --append /etc/rc.local
echo "###################### START: ADDED BY setup_speedtest_server.bash ######################" | sudo tee --append /etc/rc.local
echo "sudo -u ec2-user bash /home/ec2-user/runspeedtestapp.bash" | sudo tee --append /etc/rc.local
echo "" | sudo tee --append /etc/rc.local
echo "###################### END: ADDED BY setup_speedtest_server.bash ######################" | sudo tee --append /etc/rc.local




sudo -u ec2-user bash /home/ec2-user/runspeedtestapp.bash

