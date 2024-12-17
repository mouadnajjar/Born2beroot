#!/bin/bash
arc=$(uname -a)
pcpu=$(lscpu | grep "Socket(s)" | awk '{print $2}')
vcpu=$(nproc)
muse=$(free -m | awk '/Mem/{printf "%d/%dMB (%.2f%%)", $3, $2, $3/$2*100}')
duse=$(df -h --total | grep "^total" | awk '{printf "%s/%s (%s)", $3, $2, $5}')
lcpu=$(mpstat | awk '/all/ {print 100 - $NF}')
lboot=$(who -b | grep "system boot" | awk '{printf "%s %s", $3, $4}')
lvmu=$(lsblk | grep -q "lvm" && echo "Yes" || echo "No")
tcp=$(netstat -tn | grep "ESTABLISHED" | wc -l)
users=$(who | wc -l)
netip=$(hostname -I)
mac=$(ip addr show | grep "ether" | awk 'NR==1{print $2}')
cmd=$(journalctl _COMM=sudo -q | grep "COMMAND" | wc -l)

wall "#Architevture : $arc
#CPU physical : $pcpu
#vCPU : $vcpu
#Memory usage : $muse
#Disk Usage : $duse
#CPU load : $lcpu%
#Last boot : $lboot
#LVM use : $lvmu
#Connections TCP : $tcp ESTABLISHED
#User log : $users
#Network : IP $netip ($mac)
#Sudo : $cmd cmd"
