#!/bin/bash

data=( $(cat data.txt) )

for i in $(seq 0 $((${#data[@]} - 1)))
do
  a=${data[$i]}
  for j in $(seq $i $((${#data[@]} - 1)))
  do
    b=${data[$j]}
    for x in $(seq $j $((${#data[@]} - 1)))
    do
      c=${data[$x]}
      if [ $(( a + b +c )) -eq 2020 ]; then
        let m=a*b*c
        echo "A: $a  B: $b  C: $c   A*B*C=$m"
      fi
    done
  done
done
