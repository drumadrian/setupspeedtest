# Notes: 

# http://www.ookla.com/hosttester.php
# http://www.ookla.com/host






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









#####################################################################################
#Use the script below to update the server with new code from GitHub
#####################################################################################


# sudo yum install -y git

# #clone code from GitHub
# cd /home/ec2-user
# https://github.com/drumadrian/setupspeedtest.git


# #clone code from AWS Code Deploy
# cd /home/ec2-user
# git clone https://git-codecommit.us-west-2.amazonaws.com/v1/repos/ookla.adrianws.com


# #Manually Delete prior code from Code Deploy
# rm -Rf ookla.adrianws.com/setupspeedtest

# #Manually copy code from GitHub into Code Deploy
# cp -R setupspeedtest ookla.adrianws.com/.

# #Manually merge code from GitHub into Code Deploy
# cd ookla.adrianws.code
# git add -a 
# git commit -m 'AutoMerge from BLUE code merge server'

# #Manually push code from BLUE code merge server into Code Deploy
# git push origin master





