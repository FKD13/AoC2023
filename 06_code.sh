#!/bin/bash

part_1() {
  input="$(< 06_input.txt)"

  [[ "${input//$'\n'/-}" =~ ([^-]+)-([^-]+) ]]
  IFS=' ' read -ra times <<< "${BASH_REMATCH[1]#*:}"
  IFS=' ' read -ra dists <<< "${BASH_REMATCH[2]#*:}"

  lines=
  for ((i = 0; i < "${#times[@]}"; i++)); do
    lines+="scale=5;(-${times[i]}-sqrt(${times[i]}^2-4*-1*-${dists[i]}))/(2*-1)-(-${times[i]}+sqrt(${times[i]}^2-4*-1*-${dists[i]}))/(2*-1)"
    lines+=$'\n' 
  done 
  
  bc <<< "$lines" |
  xargs printf "%.0f\n" |
  paste -sd'*' |
  bc
}

part_2() {
  input="$(< 06_input.txt)"

  [[ "${input//$'\n'/-}" =~ ([^-]+)-([^-]+) ]]
  ttime="${BASH_REMATCH[1]// /}"; time="${ttime#*:}"
  tdist="${BASH_REMATCH[2]// /}"; dist="${tdist#*:}"

  bc <<< "scale=1;(-${time}-sqrt(${time}^2-4*-1*-${dist}))/(2*-1)-(-${time}+sqrt(${time}^2-4*-1*-${dist}))/(2*-1)"
  echo "-> Please ceil ◔_◔ <-"
}
