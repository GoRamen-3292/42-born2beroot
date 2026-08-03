#!/usr/bin/env bash

printf "#Architecture: "
uname --all

printf "#Physical CPU: "
grep -F 'physical id' /proc/cpuinfo | sort -u | wc -l

printf "#vCPU: "
grep -F 'physical id' /proc/cpuinfo | sort -u | wc -l

# uname --kernel-name | head -c -1
# printf " "
# uname --nodename | head -c -1
# printf " "
# uname --kernel-version | head -c -1
# printf " "
# uname --kernel-release | head -c -1
# printf " "
# uname --hardware-platform | head -c -1
# printf " "
# uname --processor | head -c -1
# printf " "
# uname -- | head -c -1
