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

sid=0
while read d
do
  getRow ${d:0:7}
  row=$?
  
  getCol ${d:7:3}
  col=$?
  if [ $(( row*8+col )) -gt $sid ]; then
    sid=$(( row*8+col ))
  fi
done < seats.txt

echo seatID $sid

