#!/bin/bash


function getRow () {
  s=$1
  r1=0
  r2=127
  for i in $(seq 0 6)
  do
    if [ a"${s:$i:1}" == "aF" ]; then
      r2=$(( (r1+r2+1)/2 - 1 ))
    else 
      r1=$(( (r1+r2+1)/2 ))
    fi
  done
    
  return $r1
}

function getCol () {
  s=$1
  c1=0
  c2=7
  for i in $(seq 0 2)
  do
    if [ a"${s:$i:1}" == "aL" ]; then
      c2=$(( (c1+c2+1)/2 - 1 ))
    else
      c1=$(( (c1+c2+1)/2 ))
    fi
  done
 
  return $c1
}

sid=()
while read d
do
  getRow ${d:0:7}
  row=$?
  
  getCol ${d:7:3}
  col=$?
  sid=( ${sid[@]} $(( row*8+col )) )
done < seats.txt

IFS=$'\n' sorted=($(sort -n <<<"${sid[*]}")); unset IFS

for s in $(seq 1 ${#sorted[@]})
do
  if [ $(( ${sorted[$s]} - 2 )) -eq ${sorted[$(($s - 1))]} ]; then
    echo $(( ${sorted[$s]} - 1 ))
  fi
done
