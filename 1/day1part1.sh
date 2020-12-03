#!/bin/bash

data=( $(cat data.txt) )

for i in $(seq 0 $((${#data[@]} - 1)))
do
  a=${data[$i]}
  for j in $(seq $i $((${#data[@]} - 1)))
  do
    b=${data[$j]}
    if [ $(( a + b )) -eq 2020 ]; then
        let m=a*b
        echo "A: $a  B: $b   A*B=$m"
    fi
  done
done
