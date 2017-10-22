Notes: 

https://stackoverflow.com/questions/84882/sudo-echo-something-etc-privilegedfile-doesnt-work-is-there-an-alterna
http://docs.aws.amazon.com/sdk-for-javascript/v2/developer-guide/setting-up-node-on-ec2-instance.html
https://superuser.com/questions/93385/run-part-of-a-bash-script-as-a-different-user
https://stackoverflow.com/questions/7642674/how-do-i-script-a-yes-response-for-installing-programs
https://github.com/soterinsights/speedtest
https://github.com/drumadrian/setupspeedtest


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


#start the app now
sudo -u ec2-user bash /home/ec2-user/setupspeedtest/runspeedtestapp.bash



##update /etc/rc.local   So it starts at boot
echo "" | sudo tee --append /etc/rc.local
echo "###################### START: ADDED BY setup_speedtest_server.bash ######################" | sudo tee --append /etc/rc.local
echo "sudo -u ec2-user bash /home/ec2-user/setupspeedtest/runspeedtestapp.bash" | sudo tee --append /etc/rc.local
echo "" | sudo tee --append /etc/rc.local
echo "###################### END: ADDED BY setup_speedtest_server.bash ######################" | sudo tee --append /etc/rc.local





