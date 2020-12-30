#!/bin/bash

i=0
d1=0
d3=0
while read j; do
  echo -n $j
  if [ $i -gt 0 ]; then
    d=$(( $j - $oj ))
    if [ $d -eq 1 ]; then
      let d1++
    elif [ $d -eq 3 ]; then
      let d3++
    fi
    echo -n " " $d
  fi
  oj=$j
  echo 
  let i++
done <<< "$( cat jolts.txt | sort -n )"

let d1++
let d3++

echo D1: $d1  D3: $d3  D1xD3: $(( $d1 * $d3 ))
