#Install tools
sudo yum install -y telnet
sudo yum install -y git

#execute_setup_speedtest_server
cd /home/ec2-user
git clone https://github.com/drumadrian/setupspeedtest.git
cd setupspeedtest
sudo -u ec2-user bash setup_speedtest_server.bash
