#!/bin/bash

   penjualan_tergede=$(awk -F',' 'NR>1 {penjualan[$6] += $17} END {for (customer in penjualan) print penjualan[customer], customer}' sandbox.csv | sort -nr | head -1)
   echo "penjualan Tertinggi:"
   echo "$penjualan_tergede"

   profit_tercilik=$(awk -F',' 'NR>1 {profit[$7] += $20} END {for (segment in profit) print profit[segment], segment}' sandbox.csv | sort -t',' -k1,1n | head -1)
   echo "Total Profit terendah:"
   echo "$profit_tercilik"

   profit_tergede=$(awk -F',' 'NR>1 {profit[$14] += $20} END {for (category in profit) print profit[category], category}' sandbox.csv | sort -t',' -k1,1nr | head -3)
   echo "3 Kategori dengan Profit Most High: "
   echo "$profit_tergede"

   pesanan=$(awk -F',' 'NR>1 && $6=="adriaens" {print $2 "," $18}' sandbox.csv)
   echo "Detail Pesanan Adriaens:"
   echo "tidak ada"
