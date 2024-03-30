#!/bin/bash

mem_total=$(free -m | awk 'NR == 2 {print $2}')
mem_used=$(free -m | awk 'NR == 2 {print $3}')
mem_free=$(free -m | awk 'NR == 2 {print $4}')
mem_shared=$(free -m | awk 'NR == 2 {print $5}')
mem_buff=$(free -m | awk 'NR == 2 {print $6}')
mem_available=$(free -m | awk 'NR == 2 {print $7}')
swap_total=$(free -m | awk 'NR == 3 {print $2}')
swap_used=$(free -m | awk 'NR == 3 {print $3}')
swap_free=$(free -m | awk 'NR == 3 {print $4}')

path=$(echo "$HOME")
path_size=$(du -sh ~ | awk '{print $1}')

echo "mem_total,mem_used,mem_free,mem_shared,mem_buff,mem_available,swap_total,swap_used,swap_free,path,path_size"
echo "$mem_total,$mem_used,$mem_free,$mem_shared,$mem_buff,$mem_available,$swap_total,$swap_used,$swap_free,$path,$path_size"

#command cron
#* * * * * umask 077 && /bin/bash ~/sisop/modul1/soal_4/minute_log.sh >> ~/log/metrics_$(date +\%Y\%m\%d\%H\%M\%S).log 2>&1

