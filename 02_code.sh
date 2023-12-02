#!/bin/bash

part_1() {

	sum=0
	i=1

	max_values="$((
		sed -E ':a;s/Game ([0-9]+): ([0-9]+ (blue|red|green))(,|;)?/\2 \1\nGame \1:/g;ta' | 
		sed '/Game/d' | 
		sort -k3n -k2 -k1nr | 
		uniq -f1 | 
		cut -f 1 -d ' ' | 
		pr -a3 -s' ' -t -T
	) < 02_input.txt)"
	
	while read -r blue green red; do

		if [[ "$blue" -le 14 && "$green" -le 13 && "$red" -le 12 ]]; then
			sum+="+$i"
		fi

		i=$((i+1))
		
	done <<< "$max_values"

	bc <<< "$sum"
}

part_2() {
	(
		sed -E ':a;s/Game ([0-9]+): ([0-9]+ (blue|red|green))(,|;)?/\2 \1\nGame \1:/g;ta' | 
		sed '/Game/d' | 
		sort -k3n -k2 -k1nr | 
		uniq -f1 | 
		cut -f 1 -d ' ' | 
		pr -a3 -s'*' -t -T | 
		paste -sd '+' | 
		bc
	) < 02_input.txt
}
