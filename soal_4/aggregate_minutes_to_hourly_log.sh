#!/bin/bash

date=$(date "+%Y%m%d%H")

#echo "$date"

directories=($(ls -d ~/[^.]*))

for dir in "${directories[@]}"
do
	for file in /home/admin-haidar/log/metrics_"$date"*.log
	do
		if [ -f "$file" ]; then
			#mem_total
            	        min=$((99999999999))
		        max=$((-99999999999))
			mem_total=$(awk -v dir="$dir" 'BEGIN { FS = "," } ; $0 ~ dir {print $1}' "$file")
			if [[ $mem_total -gt $max ]]; then
				max=$mem_total
			fi

			if [[ $mem_total -lt $min ]]; then
				min=$mem_total
			fi
			max_memtotal=$max
			min_memtotal=$min

			#mem_used
                        min=$((99999999999))
                        max=$((-99999999999))
                        mem_used=$(awk -v dir="$dir" 'BEGIN { FS = "," } ; $0 ~ dir {print $2}' "$file")
                        if [[ $mem_used -gt $max ]]; then
                                max=$mem_used
                        fi

                        if [[ $mem_used -lt $min ]]; then
                                min=$mem_used
                        fi
                        max_memused=$max
                        min_memused=$min

			#mem_free
                        min=$((99999999999))
                        max=$((-99999999999))
                        mem_free=$(awk -v dir="$dir" 'BEGIN { FS = "," } ; $0 ~ dir {print $3}' "$file")
                        if [[ $mem_free -gt $max ]]; then
                                max=$mem_free
                        fi

                        if [[ $mem_free -lt $min ]]; then
                                min=$mem_free
                        fi
                        max_memfree=$max
                        min_memfree=$min

			#mem_shared
                        min=$((99999999999))
                        max=$((-99999999999))
                        mem_shared=$(awk -v dir="$dir" 'BEGIN { FS = "," } ; $0 ~ dir {print $4}' "$file")
                        if [[ $mem_shared -gt $max ]]; then
                                max=$mem_shared
                        fi

                        if [[ $mem_shared -lt $min ]]; then
                                min=$mem_shared
                        fi
                        max_memshared=$max
                        min_memshared=$min

                        #mem_buff
                        min=$((99999999999))
                        max=$((-99999999999))
                        mem_buff=$(awk -v dir="$dir" 'BEGIN { FS = "," } ; $0 ~ dir {print $5}' "$file")
                        if [[ $mem_buff -gt $max ]]; then
                                max=$mem_buff
                        fi

                        if [[ $mem_buff -lt $min ]]; then
                                min=$mem_buff
                        fi
                        max_membuff=$max
                        min_membuff=$min

                        #mem_available
                        min=$((99999999999))
                        max=$((-99999999999))
                        mem_available=$(awk -v dir="$dir" 'BEGIN { FS = "," } ; $0 ~ dir {print $6}' "$file")
                        if [[ $mem_available -gt $max ]]; then
                                max=$mem_available  
                        fi

                        if [[ $mem_available -lt $min ]]; then
                                min=$mem_available
                        fi
                        max_memavailable=$max
                        min_memavailable=$min

                        #swap_total
                        min=$((99999999999))
                        max=$((-99999999999))
                        swap_total=$(awk -v dir="$dir" 'BEGIN { FS = "," } ; $0 ~ dir {print $7}' "$file")
                        if [[ $swap_total -gt $max ]]; then
                                max=$swap_total 
                        fi

                        if [[ $swap_total -lt $min ]]; then
                                min=$swap_total
                        fi
                        max_swaptotal=$max
                        min_swaptotal=$min

                        #swap_used
                        min=$((99999999999))
                        max=$((-99999999999))
                        swap_used=$(awk -v dir="$dir" 'BEGIN { FS = "," } ; $0 ~ dir {print $8}' "$file")
                        if [[ $swap_used -gt $max ]]; then
                                max=$swap_used 
                        fi

                        if [[ $swap_used -lt $min ]]; then
                                min=$swap_used
                        fi
                        max_swapused=$max
                        min_swapused=$min

                        #swap_free
                        min=$((99999999999))
                        max=$((-99999999999))
                        swap_free=$(awk -v dir="$dir" 'BEGIN { FS = "," } ; $0 ~ dir {print $9}' "$file")
                        if [[ $swap_free -gt $max ]]; then
                                max=$swap_free
                        fi

                        if [[ $swap_free -lt $min ]]; then
                                min=$swap_free
                        fi
                        max_swapfree=$max
                        min_swapfree=$min

                        #path_size
                        min=$((99999999999))
                        max=$((0))
                        path_size=$(awk -v dir="$dir" 'BEGIN { FS = "," } ; $0 ~ dir {print $11}' "$file")

			interger=$(echo $path_size | sed 's/[^0-9.]//g')
			interger=${interger%.*}
			suffix=${path_size//$interger}

                        if [[ $interger > $max ]]; then
                                max=$interger
                        fi

                        if [[ $interger < $min ]]; then
                                min=$interger
                        fi
                        max_pathsize=$max
                        min_pathsize=$min

        	fi
	done
        avg_memtotal=$(((max_memtotal+min_memtotal)/2))
        avg_memused=$(((max_memused+min_memused)/2))
        avg_memfree=$(((max_memfree+min_memfree)/2))
        avg_memshared=$(((max_memshared+min_memshared)/2))
	avg_membuff=$(((max_membuff+min_membuff)/2))
	avg_memavailable=$(((max_memavailable+min_memavailable)/2))
	avg_swaptotal=$(((max_swaptotal+min_swaptotal)/2))
	avg_swapused=$(((max_swapused+min_swapused)/2))
	avg_swapfree=$(((max_swapfree+min_swapfree)/2))
	avg_pathsize=$(((max_pathsize+min_pathsize)/2))

	echo "minimum,$min_memtotal,$min_memused,$min_memfree,$min_memshared,$min_membuff,$min_memavailable,$min_swaptotal,$min_swapused,$min_swapfree,$dir,$min_pathsize$suffix"
        echo "maximum,$max_memtotal,$max_memused,$max_memfree,$max_memshared,$max_membuff,$max_memavailable,$max_swaptotal,$max_swapused,$max_swapfree,$dir,$max_pathsize$suffix"
        echo "average,$avg_memtotal,$avg_memused,$avg_memfree,$avg_memshared,$avg_membuff,$avg_memavailable,$avg_swaptotal,$avg_swapused,$avg_swapfree,$dir,$avg_pathsize$suffix"
	echo -e "\n"
done

#command cron:
#59 * * * * umask 077 && /bin/bash /home/admin-haidar/sisop/modul1no4/aggregate_minutes_to_hourly_log.sh >> /home/admin-haidar/log/metrics_agg_$(date +\%Y\%m\%d\%H).log 2>&1

