#! /bin/bash

# Устанавливаем mdadm
yum install -y mdadm

# Создаем разделы на наших дисках
parted -s -a optimal /dev/sdb mklabel gpt -- mkpart primary ext4 1 -1
parted -s -a optimal /dev/sdc mklabel gpt -- mkpart primary ext4 1 -1
parted -s -a optimal /dev/sdd mklabel gpt -- mkpart primary ext4 1 -1
parted -s -a optimal /dev/sde mklabel gpt -- mkpart primary ext4 1 -1
parted -s -a optimal /dev/sdf mklabel gpt -- mkpart primary ext4 1 -1

# Создаем массив RAID
mdadm --create /dev/md0 --level=5 --raid-devices=5 /dev/sdb1 /dev/sdc1 /dev/sdd1 /dev/sde1 /dev/sdf1

# Зписываем конфигурацию нашего RAID-массива в mdadm.conf для автоматического подключения после перезагрузки
mkdir -p /etc/mdadm
echo "DEVICE partitions" > /etc/mdadm/mdadm.conf
mdadm --detail --scan >> /etc/mdadm/mdadm.conf
