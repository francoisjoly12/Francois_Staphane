#!/usr/bin/bash
ip=$1
gateway=$2
dns=$3
nom=$4

#script 1, changer l'ip et mettre en fixe
#1/home/francois/projet1/install/1_script_addr_ip.sh $1 $2 $3 home/francois/projet1/install/log/1_script_addr_ip_$(date +%Y%m%d_%T).log

#script 2, hostname change
bash /home/francois/projet1/install/2_script_hosts.sh $nom &> /home/francois/projet1/install/log/2_script_host_$(date +%Y%m%d_%T).log

#script 3, update system
bash /home/francois/projet1/install/3_script_update.sh &> /home/francois/projet1/install/log/3_script_update_$(date +%Y%m%d_%T).log

#5_script_users.sh $5
#8_script_install_app.sh $6
