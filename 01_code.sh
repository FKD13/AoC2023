
part_1() {
  first_file="$(mktemp)"
  last_file="$(mktemp)"

  sed -E 's/^[^0-9]*([0-9]).*$/\1/' < ./01_input.txt > "$first_file"
  sed -E 's/^.*([0-9])[^0-9]*$/\1/' < ./01_input.txt > "$last_file"

  paste -d '' "$first_file" "$last_file" | paste -sd '+' | bc

  rm "$first_file" "$last_file"
}

part_2() {
  first_file="$(mktemp)"
  last_file="$(mktemp)"

  input=$(
    while read -r line; do
      nline=""
      for ((i = 0; i < ${#line};)); do
        if [[ "${line:i:3}" == "one" ]]; then
          nline+=1
          i=$((i+2))
        elif [[ "${line:i:3}" == "two" ]]; then
          nline+=2
          i=$((i+2))
        elif [[ "${line:i:5}" == "three" ]]; then
          nline+=3
          i=$((i+4))
        elif [[ "${line:i:4}" == "four" ]]; then
          nline+=4
          i=$((i+4))
        elif [[ "${line:i:4}" == "five" ]]; then
          nline+=5
          i=$((i+3))
        elif [[ "${line:i:3}" == "six" ]]; then
          nline+=6
          i=$((i+3))
        elif [[ "${line:i:5}" == "seven" ]]; then
          nline+=7
          i=$((i+4))
        elif [[ "${line:i:5}" == "eight" ]]; then
          nline+=8
          i=$((i+4))
        elif [[ "${line:i:4}" == "nine" ]]; then
          nline+=9
          i=$((i+3))
        else
          nline+=${line:i:1}
          i=$((i+1))
        fi
      done
      echo "$nline"
    done < ./01_input.txt
  )

  sed -E 's/^[^0-9]*([0-9]).*$/\1/' <<< "$input" > "$first_file"
  sed -E 's/^.*([0-9])[^0-9]*$/\1/' <<< "$input" > "$last_file"

  paste -d '' "$first_file" "$last_file" | paste -sd '+' | bc
  
  rm "$first_file" "$last_file"
}

echo "Part 1: $(part_1)"

echo "Part 2: $(part_2)"
