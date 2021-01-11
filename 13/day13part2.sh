#!/bin/bash

# chinese remainder theory

file=bus.txt

bus=( `tail -1 $file | tr "," " "` )

declare -a val=()
declare -a busid=()

i=0
for b in ${bus[@]}; do
  if [ a"$b" != "ax" ]; then
    busid=( ${busid[@]} $b )
    val=( ${val[@]} $(( ( b-i ) % b )) )
  fi
  let i++
done
echo ${val[@]}
echo ${busid[@]}

v=${val[0]}
n=${busid[0]}
i=1
while [ $i -lt ${#val[@]} ]; do
  echo I: $i V: $v N: $n
  b=${busid[$i]}
  if [ $(( v % b )) -eq ${val[$i]} ]; then
    n=$(( n * b ))
    let i++
  else
    let v+=n
  fi
done
echo $v
