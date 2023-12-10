#!/bin/bash

part_1() {
  input="$(< 08_input.txt)"

  command="${input//$'\n'*}"
  declare -A mapping

  while read -r key left right; do
    mapping["$key"]="$left-$right"
  done <<< "$(tail -n +3 <<< "$input" | sed -E 's/^(...) = \((...), (...)\)$/\1 \2 \3/')"

  steps=0
  goal=ZZZ
  current=AAA
  command_length="${#command}"

  while [[ "$current" != "$goal" ]]; do   
    step="${command:((steps % command_length)):1}"
    
    current="${mapping["$current"]}"
    if [[ "$step" == L ]]; then
      current="${current%-*}"
    else
      current="${current#*-}"
    fi
    
    ((steps++))
  done
  
  echo "$steps"
}

part_2() {
  input="$(< 08_input.txt)"

  command="${input//$'\n'*}"
  command_length="${#command}"
  declare -A mapping

  while read -r key left right; do
    mapping["$key"]="$left-$right"
  done <<< "$(tail -n +3 <<< "$input" | sed -E 's/^(...) = \((...), (...)\)$/\1 \2 \3/')"

  answer="1"

  for key in "${!mapping[@]}"; do
    if [[ ! "$key" =~ ..A ]]; then
      continue
    fi

    steps=0
    current="$key"
  
    while [[ "${current:2:1}" != Z ]]; do
      step="${command:((steps % command_length)):1}"
    
      current="${mapping["$current"]}"
      if [[ "$step" == L ]]; then
        current="${current%-*}"
      else
        current="${current#*-}"
      fi
        
      ((steps++))
    done

    answer="lcm($answer, $steps)"
  done
  qalc -t "$answer"
}
