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

get_cache() {
  eval "echo \${cache_z_${1}[$2]}"
}

set_cache() {
  eval "cache_z_${1}[$2]=$3"
}

part_2() {
  # Giving up on this part for now
  input="$(< 08_input.txt)"

  command="${input//$'\n'*}"
  command_length="${#command}"
  declare -A mapping

  while read -r key left right; do
    mapping["$key"]="$left-$right"
  done <<< "$(tail -n +3 <<< "$input" | sed -E 's/^(...) = \((...), (...)\)$/\1 \2 \3/')"

  declare -A cache
  
  for key in "${!mapping[@]}"; do
    if [[ "$key" =~ ..A ]]; then
      cache["$key"]="0-$key"
    fi

    declare -a "cache_z_$key"
    for ((i = 0; i < "$command_length"; i++)); do
      set_cache "$key" "$i" -1
    done
  done
  
  max_steps=0
  max_key=

  while true; do
    update=0
    for key in "${!cache[@]}"; do
      if [[ "$key" == "$max_key" ]]; then
        break
      fi

      steps="${cache["$key"]%-*}"
      current="${cache["$key"]#*-}"

     # set -x
      current_cache="$(get_cache "$key" "$((steps % command_length))")"

      while [[ "$current_cache" != "-1" && "$steps" -lt "$max_steps" ]]; do
        increment="${current_cache%-*}"
        current="${current_cache#*-}"
        ((steps += increment))
        current_cache="$(get_cache "$current" "$((steps % command_length))")"
      done
     # set +x

      og_steps="$steps"
      og_current="$current"
      
      while [[ "$steps" -lt "$max_steps" || ! "$current" =~ ..Z ]]; do
        step="${command:((steps % command_length)):1}"
    
        current="${mapping["$current"]}"
        if [[ "$step" == L ]]; then
          current="${current%-*}"
        else
          current="${current#*-}"
        fi
        
        ((steps++))
      done

      # set -x
      cache["$key"]="$((steps))-$current"
      if [[ "$steps" != "$og_steps" ]]; then
        set_cache "$og_current" "$((og_steps % command_length))" "$((steps - og_steps))-$current"
        if [[ "$og_current" == "$current" ]]; then
          echo "Recursion: $((steps - (steps - og_steps))) steps; recusion step: $((steps - og_steps))"
        fi
        update=1
      fi
      # set +x

      if [[ "$steps" -gt "$max_steps" ]]; then
        max_steps="$steps"
        max_key="$key"
        # echo "-> max is now $max_steps for key $key"
      fi
    done
    echo "${cache[@]}"

    if [[ $update == 0 ]]; then
      exit 0
    fi
  done
  echo "$((max_steps))"
}
