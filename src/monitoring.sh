#!/usr/bin/env bash

echo -n "#Architecture: "
uname --all

echo -n "#Physical CPU: "
# Get the largest number of the physical id
grep -F 'physical id' /proc/cpuinfo | sort -u | wc -l

echo -n "#vCPU: "
echo

echo -n "#Memory Usage: "

free_result_h=`free -h | grep Mem:`
available_h=`echo $free_result_h | awk '{print $7}'`
total_h=`echo $free_result_h | awk '{print $2}'`

free_result=`free | grep Mem:`
available=`echo $free_result | awk '{print $7}'`
total=`echo $free_result | awk '{print $2}'`
free_percent=$(($available * 100 / $total))

echo "$available_h / $total_h ($free_percent %)"

echo -n "#Disk Usage: "
df_h=`df -h /`
available_h=`echo $free_result_h | awk '{print $7}'`
total_h=`echo $free_result_h | awk '{print $2}'`

available_t=0
total_t=0

mnts=('/boot' '/' '/home' '/var' '/srv' '/tmp' '/var/log')
df_res=`df -mP $mnt`
for mnt in "${mnts[@]}"; do
  df_res=`df -mP $mnt | sed -n '2p'`
  available=`echo $df_res | awk '{print $3}'`
  total=`echo $df_res | awk '{print $2}'`
  # printf '[%s] %s / %s \n' "$mnt" "$available" "$total"
  available_t=$(($available_t + $available))
  total_t=$(($total_t + $total))
done
echo "$available_t/$total_t M ($(($available_t * 100 / $total_t)) %)"

top -b -n1 | grep "%Cpu(s)" | awk '{printf("#CPU load: %.1f%%\n", 100 - $8)}'

echo -n "#Last boot: "
uptime -s

echo -n "#LVM Use: "
res=`lvs`
if [ -z "$res" ]; then
  echo "No"
else
  echo "Yes"
fi

echo -n "#TCP Connections: "
conn=`ss --tcp | wc -l`
echo $(($conn - 1))

printf "#User log: "
w -s -h | wc -l

printf "#Network: "
hostname -I
echo -n "("
ip a | grep --after-context=3 ": enp*" | awk 'NR==2' | awk '{ print $2 }'
echo -n ")"

printf "#Sudo: "
sudo_len=`cat /var/log/sudo/sudo.log | wc -l`
echo $(($sudo_len / 2))
