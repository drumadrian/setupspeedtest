#!/bin/bash
sudo apt-get update

export DEBIAN_FRONTEND=noninteractive

sudo apt-get -y install htop
sudo pip install awscli

source /etc/plat_name.sh

#################################
#### Install apt-get-waiter #####
#################################
read -r -d '' aptgetwaiter << EOM
#!/bin/python
import fcntl


def is_dpkg_active():
    with open('/var/lib/dpkg/lock', 'w') as handle:
        try:
            fcntl.lockf(handle, fcntl.LOCK_EX | fcntl.LOCK_NB)
            return False
        except IOError:
            return True


print(is_dpkg_active())
EOM

echo "$aptgetwaiter" > /tmp/apt-get-waiter
chmod +x /tmp/apt-get-waiter

function waitforapt () {
    echo "Waiting for apt-get to be available."
    test="$(python /tmp/apt-get-waiter)"
    breaker="False"
    while [ "$breaker" == "False" ]; do
        test="$(python /tmp/apt-get-waiter)"
        if [ "$test" == "True" ]; then
            echo -n "."
        elif [ "$test" == "False" ]; then
            echo "Starting apt-get or dpkg install"
            breaker="True"
        fi
        sleep 4
    done
}

