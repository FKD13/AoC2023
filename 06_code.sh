#!/bin/bash

part_1() {
  input="$((sed -E 's/ +/ /g' | sed -E 's/^[a-zA-Z]+: //') < 06_input.txt)"

  IFS=' ' read -ra times <<< "$(head -n 1 <<< "$input")"
  IFS=' ' read -ra dists <<< "$(tail -n 1 <<< "$input")"

  for ((i = 0; i < "${#times[@]}"; i++)); do
    echo "solve(${dists[i]} < (${times[i]}-x)*x; x)"
  done |
  qalc -t -f - |
  sed -E 's/^(.*) < x < (.*)$/\2 - \1/' |
  bc |
  xargs printf "%.0f\n" |
  paste -sd'*' |
  bc
}

part_2() {
  input="$((sed -E 's/^[a-zA-Z]+: //' | sed -E 's/ +//g') < 06_input.txt)"

  time="$(head -n 1 <<< "$input")"
  dist="$(tail -n 1 <<< "$input")"
 
  qalc -t "solve($dist < ($time-x)*x; x)" | sed -E 's/^(.*) < x < (.*)$/\2 - \1/' | bc
  
  echo "-> Please ceil ◔_◔ <-"
}
