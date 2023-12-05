#!/bin/bash

part_1() {
  (
    sed -E 's/ +/ /g' |
    sed -E 's/Card [0-9]+:/0-1 |/' |
    sed -E ':a;s/^([^\|]+ \| ([0-9]+ )*)([0-9]+) (([0-9]+ )*\|( [0-9]+)*) \3(( [0-9]+)*)$/1+\1\4\7/g;ta' |
    sed -E 's/^([^ ]+) .*$/2^(\1)/' |
    paste -sd+ |
    bc 
  ) < 04_input.txt
}

part_2() {
  readarray -t scores <<< "$( 
    sed -E 's/ +/ /g' 04_input.txt |
    sed -E 's/Card [0-9]+:/0 |/' |
    sed -E ':a;s/^([^\|]+ \| ([0-9]+ )*)([0-9]+) (([0-9]+ )*\|( [0-9]+)*) \3(( [0-9]+)*)$/1+\1\4\7/g;ta' |
    sed -E 's/^([^ ]+) .*$/\1/' |
    bc
  )"

  cards="${#scores[@]}"
 
  declare -a card_count

  for ((i = 0; i < "$cards"; i++)); do
    card_count["$i"]=1
  done

  sum=0
  for ((i = 0; i < "$cards"; i++)); do
    sum+="+${card_count["$i"]}"
    for ((j = i+1; j <= i + "${scores["$i"]}" && j < "$cards"; j++ )); do
      card_count["$j"]=$((card_count[j]+card_count[i]))
    done
  done
  
  bc <<< "$sum"
}
