#!/bin/bash
sudo su -
yum install lvm2 -y
(echo -e '#!/bin/bash\n'; echo -e 'echo "n\np';echo -e '1\n\n';echo -e 'w';echo '"|fdisk /dev/xvdb') > file
sudo bash ./file
pvcreate /dev/xvdb1
vgcreate data /dev/xvdb1
lvcreate -n data1 --size {{VolumeSize}} data
mkfs.ext4 /dev/data/data1
cd /./mnt
mkdir data
cd data
mkdir xvdb1
mount /dev/data/data1 /mnt/data/xvdb1
uuid=$(lsblk /dev/data/data1 -no UUID)
(echo "UUID=$uuid /mnt/data/xvdb1 ext4 defaults 0 0") >> /etc/fstab
reboot
