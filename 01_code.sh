#!/bin/bash

part_1() {
  (
    sed -E 's/^[^0-9]*([0-9]).*([0-9])[^0-9]*$/\1\2/' | 
    sed -E 's/^[^0-9]*([0-9])[^0-9]*$/\1\1/' |
    paste -sd '+' |
    bc
  ) < 01_input.txt
}

part_2() {
  (
    sed -e 's/one/o1e/g;s/two/t2o/g;s/three/t3e/g;s/four/f4r/g;s/five/f5e/g;s/six/s6x/g;s/seven/s7n/g;s/eight/e8t/g;s/nine/n9e/g' |
    sed -E 's/^[^0-9]*([0-9]).*([0-9])[^0-9]*$/\1\2/' | 
    sed -E 's/^[^0-9]*([0-9])[^0-9]*$/\1\1/' |
    paste -sd '+' |
    bc
  ) < 01_input.txt 
}
