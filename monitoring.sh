#!/bin/bash

ARCH=$(uname -pr)
PCPU_NB=$(nproc)
VCPU_NB=$(grep "processor" /proc/cpuinfo | wc -l)
CPU_USAGE=$(top -bn1 | awk '/Cpu/ {printf "%.2f %%\n", $2 + $6}')
RAM=$(free -m | awk '/Mem/ { printf "%.2f/%.2f Mi (%.2f %%)", $NF, $2, 1 - $NF / $2}')
DISK=$(df -h --total | awk '/total/ { print  $4, $5}')
LAST_BOOT=$(who -b | awk '{ print $3, $4}')
LVM=$(lsblk | awk 'BEGIN {IS_LVM="NO"} {if ($0 ~ /[lL][vV][mM]/) IS_LVM="YES"} END {printf "%s", IS_LVM}')
TCP=$(awk '/TCP/ {print $3}' /proc/net/sockstat)
USER_NB=$(users | wc -w)
IPV4=$(ip -4 addr | awk '$1 ~ /inet/ && $2 !~ /127\.0\.0\.1/ {print $2}')
MAC=$(ip link show | awk '$1 ~ /link/ && $2 !~ /0+\:0+\:0+\:0+\:0+\:0+/ {print $2}')
CMD_SUDO=$(journalctl | grep sudo | wc -l)


wall "Architecture      : $ARCH\
	CPU physical      : $PCPU_NB\
	vCPU              : $RAM\
	Memory Usage      : $DISK\
	CPU load  : $CPU_USAGE\
	Last boot : $LAST_BOOT\
	LVM use           : $LVM\
	Connexions TCP    : $TCP\
	User log  : $IPV4\
	Network           : $MAC\
	Sudo              : $CMD_SUDO"

# Broadcast message from root@wil (tty1) (Sun Apr 25 15:45:00 2021):
#Architecture: Linux wil 4.19.0-16-amd64 #1 SMP Debian 4.19.181-1 (2021-03-19) x86_64 GNU/Linux
#CPU physical : 1
#vCPU : 1
#Memory Usage: 74/987MB (7.50%) #Disk Usage: 1009/2Gb (39%)
#CPU load: 6.7%
#Last boot: 2021-04-25 14:45
#LVM use: yes
#Connexions TCP : 1 ESTABLISHED
#User log: 1
#Network: IP 10.0.2.15 (08:00:27:51:9b:a5)
#Sudo : 42 cmd
~
