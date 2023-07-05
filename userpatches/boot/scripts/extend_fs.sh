#!/bin/bash

c=0
cd /dev
for file in `ls mmcblk*`
do
    filelist[$c]=$file
    ((c++))
done

ROOT_DEV=/dev/${filelist[0]}

BOOT_NUM=1
ROOT_NUM=2

ROOTFS_START=532480

# 使用 fdisk 工具进行磁盘分区;
sudo fdisk "$ROOT_DEV" << EOF
p
d
$ROOT_NUM
n
p
$ROOT_NUM
$ROOTFS_START

y
w
EOF

sudo resize2fs /dev/${filelist[$c-1]}          # 扩展分区;
unset filelist

#-----------------
# username=biqu
# sudo usermod -a -G root $username         # 将biqu加入root用户组
# sudo gpasswd -d biqu root     # 将biqu移出root用户组

sudo sed -i '/extend_fs.sh/d' /boot/scripts/btt_init.sh
