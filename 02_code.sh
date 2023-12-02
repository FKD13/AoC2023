#!/bin/bash

part_1() {

	declare -A limits

	limits[red]=12
	limits[green]=13
	limits[blue]=14

	sum=0
	
	while read -r game; do

		declare -A max_color
		
		game_id="$(sed -E 's/^Game ([0-9]+):.*$/\1/' <<< "$game")"
		games="$(echo "$game" | sed -E 's/^.*: (.*)$/\1/' | sed -E 's/(,|;) /\n/g')"
		
		while read -r count color; do
			if [[ "${max_color["$color"]}" -lt "$count" ]]; then
				max_color["$color"]="$count"
			fi
		done <<< "$games"

		fail="false"

		for key in "${!max_color[@]}"; do
			if [[ "${max_color["$key"]}" -gt "${limits["$key"]}" ]]; then
				fail="true"
			fi
		done

		if [[ "$fail" == "false" ]]; then
			sum+="+$game_id"
		fi

		unset max_color
		
	done < 02_input.txt

	bc <<< "$sum"
}

part_2() {

	sum=0
	
	while read -r game; do
		declare -A max_color
		
		game_id="$(sed -E 's/^Game ([0-9]+):.*$/\1/' <<< "$game")"
		games="$(echo "$game" | sed -E 's/^.*: (.*)$/\1/' | sed -E 's/(,|;) /\n/g')"
		
		while read -r count color; do
			if [[ "${max_color["$color"]}" -lt "$count" ]]; then
				max_color["$color"]="$count"
			fi
		done <<< "$games"
		
		sum+="+(${max_color[red]}*${max_color[green]}*${max_color[blue]})"
		
		unset max_color
	done < 02_input.txt

	bc <<< "$sum"
}
