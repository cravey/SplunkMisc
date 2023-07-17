#!/bin/sh
#
# Must open ports 22 and 8000 in security group to any system you're accessing this from.
# web interface is HTTP, not HTTPS. #YOLO
# Suitable for c4.8xlarge or larger. $$
# NOT SUITABLE FOR PRODUCTION USE. Spin this up for training then burn it. Nothing here is secure. NOTHING!
#
# On your marks:
yum -y install curl wget nano net-tools

# Don't make this too easy... Uncomment
#wget https://s3.amazonaws.com/botsdataset/botsv2/botsv2_data_set.tgz
#wget -O splunk-9.1.0.1-77f73c9edb85.x86_64.rpm "https://download.splunk.com/products/splunk/releases/9.1.0.1/linux/splunk-9.1.0.1-77f73c9edb85.x86_64.rpm"

# Get set:
# Create a mountpoint. Set up a 30GB ramdisk to hold splunk and the indexes. Install splunk. Extract dataset to the correct location. Return.
mkdir /opt/splunk
mount -t tmpfs -o size=30G tmpfs /opt/splunk
rpm -i splunk-9.1.0.1-77f73c9edb85.x86_64.rpm 
cd /opt/splunk/etc/apps
tar -zxvf ~ec2-user/botsv2_data_set.tgz
cd -

# Prep Config files:
echo "" >> /opt/splunk/etc/splunk-launch.conf
echo "OPTIMISTIC_ABOUT_FILE_LOCKING=1" >> /opt/splunk/etc/splunk-launch.conf
echo "[user_info]" > /opt/splunk/etc/system/local/user-seed.conf
echo "USERNAME = admin" >> /opt/splunk/etc/system/local/user-seed.conf
echo "PASSWORD = i<3bigDATA" >> /opt/splunk/etc/system/local/user-seed.conf

# GO!
# Check output carefully. it likes to fail nearly silently.
/opt/splunk/bin/splunk start --accept-license
sleep 10
curl -k -u "admin:i<3bigDATA" https://localhost:8089/services/authentication/users -d name=User1 -d password=58072312 -d roles=power
curl -k -u "admin:i<3bigDATA" https://localhost:8089/services/authentication/users -d name=User2 -d password=15428332 -d roles=power
curl -k -u "admin:i<3bigDATA" https://localhost:8089/services/authentication/users -d name=User3 -d password=77834643 -d roles=power
curl -k -u "admin:i<3bigDATA" https://localhost:8089/services/authentication/users -d name=User4 -d password=29721263 -d roles=power
curl -k -u "admin:i<3bigDATA" https://localhost:8089/services/authentication/users -d name=User5 -d password=94087093 -d roles=power
curl -k -u "admin:i<3bigDATA" https://localhost:8089/services/authentication/users -d name=User6 -d password=60743569 -d roles=power

#echo "$((1000 + RANDOM % 9999)).$((RANDOM % 9999))"
#curl -o botsv2.tgz https://s3.amazonaws.com/botsdataset/botsv2/botsv2_data_set.tgz
#curl -o botsv2.tgz https://s3.amazonaws.com/botsdataset/botsv2/botsv2_data_set_attack_only.tgz
#wget -O splunk.rpm 
#'https://www.splunk.com/bin/splunk/DownloadActivityServlet?architecture=x86_64&platform=linux&version=8.0.3&product=splunk&filename=splunk-8.0.3-a6754d8441bf-linux-2.6-x86_64.rpm&wget=true'


