#!/bin/bash

part_1() {
  input="$((sed -E 's/^[a-zA-Z]+: //;s/ +/ /g' | tr '\n' '-') < 06_input.txt)"

  [[ "$input" =~ ([^-]+)-([^-]+) ]]
  IFS=' ' read -ra times <<< "${BASH_REMATCH[1]}"
  IFS=' ' read -ra dists <<< "${BASH_REMATCH[2]}"

  for ((i = 0; i < "${#times[@]}"; i++)); do
    echo "scale=5;(-${times[i]}-sqrt(${times[i]}^2-4*-1*-${dists[i]}))/(2*-1)-(-${times[i]}+sqrt(${times[i]}^2-4*-1*-${dists[i]}))/(2*-1)" 
  done |
  bc |
  xargs printf "%.0f\n" |
  paste -sd'*' |
  bc
}

part_2() {
  input="$((sed -E 's/^[a-zA-Z]+: //;s/ +//g' | tr '\n' '-') < 06_input.txt)"

  [[ "$input" =~ ([^-]+)-([^-]+) ]]
  time="${BASH_REMATCH[1]}"
  dist="${BASH_REMATCH[2]}"

  echo "scale=5;(-${time}-sqrt(${time}^2-4*-1*-${dist}))/(2*-1)-(-${time}+sqrt(${time}^2-4*-1*-${dist}))/(2*-1)" |
  bc |
  xargs printf "%.0f\n" |
  paste -sd'*' |
  bc
  
  echo "-> Please ceil ◔_◔ <-"
}
