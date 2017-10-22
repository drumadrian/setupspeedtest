Notes: 

http://www.ookla.com/hosttester.php
http://www.ookla.com/host






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







