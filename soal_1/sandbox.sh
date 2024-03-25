wget --no-check-certificate 'https://drive.google.com/uc?export=download&id=1cC6MYBI3wRwDgqlFQE1OQUN83JAreId0' -O Sandbox.csv
ls
cat Sandbox.csv
awk -F ',' '{sales[$1] += $3 * $4} END {for (buyer in sales) print buyer, sales[buyer]}' Sandbox.csv
awk -F ',' '{sales[$1] += $3 * $4} END {for (buyer in sales) print buyer, sales[buyer]}' Sandbox.csv | sort -k2nr
awk -F ',' '{sales[$1] += $3 * $4} END {for (buyer in sales) print buyer, sales[buyer]}' Sandbox.csv | sort -k2nr | head -n1
awk -F ',' '{profit[$2] += $3 * $4 - $5} END {for (segment in profit) print segment, profit[segment]}' Sandbox.csv
awk -F ',' '{profit[$2] += $3 * $4 - $5} END {for (segment in profit) print segment, profit[segment]}' Sandbox.csv | sort -k2n
awk -F ',' '{profit[$2] += $3 * $4 - $5} END {for (segment in profit) print segment, profit[segment]}' Sandbox.csv | sort -k2n | head -n1
awk -F ',' '{profit[$6] += $3 * $4 - $5} END {for (category in profit) print category, profit[category]}' Sandbox.csv
awk -F ',' '{profit[$6] += $3 * $4 - $5} END {for (category in profit) print category, profit[category]}' Sandbox.csv | sort -k2nr
awk -F ',' '{profit[$6] += $3 * $4 - $5} END {for (category in profit) print category, profit[category]}' Sandbox.csv | sort -k2nr | head -n3
awk -F ',' '$1=="adriaens" {print $2, $3}' Sandbox.csv
awk '/Adriaens/ {print}' Sandbox.csv
awk -F ',' '/Adriaens/ {print $2, $6, $17}' Sandbox.csv
