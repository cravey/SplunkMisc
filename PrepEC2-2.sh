#!/bin/sh

yum -y install curl wget nano

#curl -o botsv2.tgz https://s3.amazonaws.com/botsdataset/botsv2/botsv2_data_set.tgz
#curl -o botsv2.tgz https://s3.amazonaws.com/botsdataset/botsv2/botsv2_data_set_attack_only.tgz
#wget -O splunk.rpm 
'https://www.splunk.com/bin/splunk/DownloadActivityServlet?architecture=x86_64&platform=linux&version=8.0.3&product=splunk&filename=splunk-8.0.3-a6754d8441bf-linux-2.6-x86_64.rpm&wget=true'

mount -t xfs /dev/nvme1n1 /mnt
mkdir /opt/splunk
mount -t tmpfs -o size=75G tmpfs /opt/splunk
rpm -i /mnt/splunk.rpm
echo "" >> /opt/splunk/etc/splunk-launch.conf
echo "OPTIMISTIC_ABOUT_FILE_LOCKING=1" >> /opt/splunk/etc/splunk-launch.conf
cd /opt/splunk/etc/apps
tar -zxvf /mnt/botsv2.tgz
cd -
echo "[user_info]" > /opt/splunk/etc/system/local/user-seed.conf
echo "USERNAME = admin" >> /opt/splunk/etc/system/local/user-seed.conf
echo "PASSWORD = i<3bigDATA" >> /opt/splunk/etc/system/local/user-seed.conf
/opt/splunk/bin/splunk start --accept-license
sleep 10
curl -k -u "admin:i<3bigDATA" https://localhost:8089/services/authentication/users -d name=User1 -d password=47580723 -d roles=power
curl -k -u "admin:i<3bigDATA" https://localhost:8089/services/authentication/users -d name=User2 -d password=14454283 -d roles=power
curl -k -u "admin:i<3bigDATA" https://localhost:8089/services/authentication/users -d name=User3 -d password=77856346 -d roles=power
curl -k -u "admin:i<3bigDATA" https://localhost:8089/services/authentication/users -d name=User4 -d password=20597212 -d roles=power
curl -k -u "admin:i<3bigDATA" https://localhost:8089/services/authentication/users -d name=User5 -d password=94409870 -d roles=power
curl -k -u "admin:i<3bigDATA" https://localhost:8089/services/authentication/users -d name=User6 -d password=60647435 -d roles=power
#echo "$((1000 + RANDOM % 9999)).$((RANDOM % 9999))"

