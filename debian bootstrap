#!/bin/bash
sudo su -
apt-get update
mkdir /tmp/ssm
cd /tmp/ssm
wget https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/latest/debian_amd64/amazon-ssm-agent.deb
sudo dpkg -i amazon-ssm-agent.deb
sudo systemctl enable amazon-ssm-agent
sudo systemctl start amazon-ssm-agent
apt install python3-pip -y
pip3 install awscli
sed -re 's/^(PasswordAuthentication)([[:space:]]+)no/\1\2yes/' -i.`date -I` /etc/ssh/sshd_config
password=$(aws ssm get-parameters --names linuxadmin --with-decryption $true --region ap-northeast-1 --query 'Parameters[0].Value' --output text)
useradd administrator -d /home/administrator -m
echo administrator:$password | chpasswd
usermod --shell /bin/bash administrator
echo "administrator ALL = NOPASSWD : ALL" >> /etc/sudoers
reboot
