#!/usr/bin/bash
cp -rf /etc/hosts /home/francois/projet1/install/backup/
cp -rf /etc/hostname /home/francois/projet1/install/backup/
hostnamectl set-hostname $1
hostnamectl

echo  "-------------------------------------------------------------"
echo "cp -rf /etc/hosts /home/francois/projet1/install/backup/
cp -rf /etc/hostname /home/francois/projet1/install/backup/
hostnamectl set-hostname $1
hostnamectl"

