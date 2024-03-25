#!/bin/bash

# Function to get memory metrics
get_memory_metrics() {
    mem_info=($(grep -E "MemTotal|MemFree|MemAvailable|Buffers|Cached|SwapTotal|SwapFree" /proc/meminfo | awk '{print $2}'))
    mem_total=${mem_info[0]}
    mem_free=$(( ${mem_info[1]} + ${mem_info[2]} + ${mem_info[3]} ))
    mem_shared=0 # Not available in /proc/meminfo
    mem_buff=${mem_info[3]}
    mem_available=${mem_info[5]}
    swap_total=${mem_info[6]}
    swap_free=${mem_info[7]}
    echo "$mem_total,$((mem_total - mem_free)),$mem_free,$mem_shared,$mem_buff,$mem_available,$swap_total,$((swap_total - swap_free)),$swap_free"
}

get_directory_size() {
    du -hs "$1" | awk '{print $1}'
}

directories=($(ls -d ~/[^.]*))

for dir in "${directories[@]}"; do
    memory_metrics=$(get_memory_metrics)
    directory_size=$(get_directory_size "$dir")
    echo "$memory_metrics,$dir,$directory_size"
done

#command cron
#* * * * * umask 077 && /bin/bash /home/admin-haidar/sisop/modul1no4/minute_log.sh >> /home/admin-haidar/log/metrics_$(date +\%Y\%m\%d\%H\%M\%S).log 2>&1
