#!/bin/bash

date=$(date "+%Y%m%d%H")

#if [ ! -d "$format" ]; then
#    exit 1
#fi

min_mt=$((99999999999))
max_mt=$((0))

min_mu=$((99999999999))
max_mu=$((0))

min_mf=$((99999999999))
max_mf=$((0))

min_ms=$((99999999999))
max_ms=$((0))

min_mb=$((99999999999))
max_mb=$((0))

min_ma=$((99999999999))
max_ma=$((0))

min_st=$((99999999999))
max_st=$((0))

min_su=$((99999999999))
max_su=$((0))

min_sf=$((99999999999))
max_sf=$((0))

min_ps=$((99999999999))
max_ps=$((0))

for file in ~/log/metrics_"$date"*.log; do
	if [ -f "$file" ]; then
		#mem_total
                mem_total=$(awk 'BEGIN { FS = "," } ; NR == 2 {print $1}' "$file")
		if [[ $mem_total -gt $max_mt ]]; then
			max_mt=$mem_total
		fi

		if [[ $mem_total -lt $min_mt ]]; then
			min_mt=$mem_total
		fi

		#mem_used
                mem_used=$(awk 'BEGIN { FS = "," } ; NR == 2 {print $2}' "$file")
		if [[ $mem_used -gt $max_mu ]]; then
			max_mu=$mem_used
		fi

		if [[ $mem_used -lt $min_mu ]]; then
			min_mu=$mem_used
		fi

		#mem_free
                mem_free=$(awk 'BEGIN { FS = "," } ; NR == 2 {print $3}' "$file")
		if [[ $mem_free -gt $max_mf ]]; then
			max_mf=$mem_free
		fi

		if [[ $mem_free -lt $min_mf ]]; then
			min_mf=$mem_free
		fi

		#mem_shared
                mem_shared=$(awk 'BEGIN { FS = "," } ; NR == 2 {print $4}' "$file")
		if [[ $mem_shared -gt $max_ms ]]; then
			max_ms=$mem_shared
		fi

		if [[ $mem_shared -lt $min_ms ]]; then
			min_ms=$mem_shared
		fi

		#mem_buff
                mem_buff=$(awk 'BEGIN { FS = "," } ; NR == 2 {print $5}' "$file")
		if [[ $mem_buff -gt $max_mb ]]; then
			max_mb=$mem_buff
		fi

		if [[ $mem_buff -lt $min_mb ]]; then
			min_mb=$mem_buff
		fi

		#mem_available
                mem_available=$(awk 'BEGIN { FS = "," } ; NR == 2 {print $6}' "$file")
		if [[ $mem_available -gt $max_ma ]]; then
			max_ma=$mem_available
		fi

		if [[ $mem_available -lt $min_ma ]]; then
			min_ma=$mem_available
		fi

		#swap_total
                swap_total=$(awk 'BEGIN { FS = "," } ; NR == 2 {print $7}' "$file")
		if [[ $swap_total -gt $max_st ]]; then
			max_st=$swap_total 
		fi

		if [[ $swap_total -lt $min_st ]]; then
			min_st=$swap_total
		fi

		#swap_used
                swap_used=$(awk 'BEGIN { FS = "," } ; NR == 2 {print $8}' "$file")
		if [[ $swap_used -gt $max_su ]]; then
			max_su=$swap_used 
		fi

		if [[ $swap_used -lt $min_su ]]; then
			min_su=$swap_used
		fi

		#swap_free
                swap_free=$(awk 'BEGIN { FS = "," } ; NR == 2 {print $9}' "$file")
		if [[ $swap_free -gt $max_sf ]]; then
		        max_sf=$swap_free
		fi

		if [[ $swap_free -lt $min_sf ]]; then
		        min_sf=$swap_free
		fi

		#path_size
                path_size=$(awk 'BEGIN { FS = "," } ; NR == 2 {print $11}' "$file")

		interger=$(echo $path_size | sed 's/[^0-9.]//g')
		interger=${interger%.*}
		suffix=${path_size//$interger}

		if [[ $interger > $max_ps ]]; then
		        max_ps=$interger
		fi

		if [[ $interger < $min_ps ]]; then
		        min_ps=$interger
		fi
	fi
done

avg_memtotal=$(((max_mt+min_mt)/2))
avg_memused=$(((max_mu+min_mu)/2))
avg_memfree=$(((max_mf+min_mf)/2))
avg_memshared=$(((max_ms+min_ms)/2))
avg_membuff=$(((max_mb+min_mb)/2))
avg_memavailable=$(((max_ma+min_ma)/2))
avg_swaptotal=$(((max_st+min_st)/2))
avg_swapused=$(((max_su+min_su)/2))
avg_swapfree=$(((max_sf+min_sf)/2))
avg_pathsize=$(((max_ps+min_ps)/2))

path=$(echo "$HOME")

echo "type,mem_total,mem_used,mem_free,mem_shared,mem_buff,mem_available,swap_total,swap_used,swap_free,path,path_size"
echo "minimum,$min_mt,$min_mu,$min_mf,$min_ms,$min_mb,$min_ma,$min_st,$min_su,$min_sf,$path,$min_ps$suffix"
echo "maximum,$max_mt,$max_mu,$max_mf,$max_ms,$max_mb,$max_ma,$max_st,$max_su,$max_sf,$path,$max_ps$suffix"
echo "average,$avg_memtotal,$avg_memused,$avg_memfree,$avg_memshared,$avg_membuff,$avg_memavailable,$avg_swaptotal,$avg_swapused,$avg_swapfree,$path,$avg_pathsize$suffix"
echo -e "\n"

#command cron
#59 * * * * umask 077 && /bin/bash ~/sisop/modul1/soal_4/aggregate_minutes_to_hourly_log.sh >> ~/log/metrics_agg_$(date +\%Y\%m\%d\%H\%M\%S).log 2>&1
