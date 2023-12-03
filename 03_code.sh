#!/bin/bash

part_1() {
  width=140
  height=140

  readarray -t map <<< "$(cat 03_input.txt | tr -d '\n' | fold -w 1)"

  # States
  # idle
  # idle_special
  # parsing
  # parsing_special
  state=idle

  number=
  sum=0
  
  for ((j = 0; j < "$height"; j++)); do
    for ((i = 0; i < "$width"; i++)); do
      char="${map[((j*width+i))]}"
    
      if [[ "$char" =~ [0-9] ]]; then

        case "$state" in
          idle | parsing) 
            state=parsing
            if [[ "$j" -gt 0 && "${map[(((j-1)*width+i))]}" =~ [^0-9\.] ]]; then
              state=parsing_special
            fi
            if [[ "$j" -lt "$((height-1))" && "${map[(((j+1)*width+i))]}" =~ [^0-9\.] ]]; then
              state=parsing_special
            fi
            ;;
          idle_special | parsing_special) 
            state=parsing_special 
            ;;
        esac

        number+="$char"
        
      elif [[ ! "$char" =~ [0-9] ]]; then
        special=0

        if [[ "$char" =~ [^0-9\.] ]]; then
          special=1
        else
          if [[ "$j" -gt 0 && "${map[(((j-1)*width+i))]}" =~ [^0-9\.] ]]; then
            special=1
          fi
          if [[ "$j" -lt "$((height-1))" && "${map[(((j+1)*width+i))]}" =~ [^0-9\.] ]]; then
            special=1
          fi
        fi

        case "$state" in
          parsing)
            if [[ "$special" -eq 1 ]]; then
              sum+="+$number"
            fi
            ;;
          parsing_special) 
            sum+="+$number"
            ;;
        esac

        number=

        if [[ "$special" -eq 1 ]]; then
          state=idle_special
        else
          state=idle
        fi
      fi
    done
  done
  
  bc <<< "$sum"
  
}
