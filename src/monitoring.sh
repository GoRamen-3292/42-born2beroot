#!/usr/bin/env bash

printf "#Architecture: "
uname --all

printf "#Physical CPU: "
# Get the largest number of the physical id
grep -F 'physical id' /proc/cpuinfo | sort -u | wc -l

printf "#vCPU: "
echo

printf "#Memory Usage: "

free_result_h=`free -h | grep Mem:`
available_h=`echo $free_result_h | awk '{print $7}'`
total_h=`echo $free_result_h | awk '{print $2}'`

free_result=`free | grep Mem:`
available=`echo $free_result | awk '{print $7}'`
total=`echo $free_result | awk '{print $2}'`
free_percent=$(($available * 100 / $total))

echo "$available_h / $total_h ($free_percent %)"

printf "#Disk Usage: "
echo
df_h=`df -h /`
available_h=`echo $free_result_h | awk '{print $7}'`
total_h=`echo $free_result_h | awk '{print $2}'`

available_t=0
total_t=0

mnts=('/boot' '/' '/home' '/var' '/srv' '/tmp' '/var/log')
for mnt in "${mnts[@]}"; do
  df_res=`df -mP $mnt | sed -n '2p'`
  available=`echo $df_res | awk '{print $3}'`
  total=`echo $df_res | awk '{print $2}'`
  # printf '[%s] %s / %s \n' "$mnt" "$available" "$total"
  available_t=$(($available_t + $available))
  total_t=$(($total_t + $total))
done
echo "$available_t/$total_t M ($(($available_t * 100 / $total_t)) %)"

printf "#CPU load: "
echo

printf "#Last boot: "
echo

printf "#LVM Use: "
echo

printf "#TCP Connections: "
echo

printf "#User log: "
echo

printf "#Network: "
echo

printf "#Sudo: "
echo