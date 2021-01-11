#!/bin/bash

file=bus.txt

ts=`head -1 $file`
bus=( `tail -1 $file | sed "s/,x//g" | tr "," " "` )

for b in ${bus[@]}; do
  echo BID: $b
  t1=$(( ts / b ))
  re=$(( ts % b ))
  if [ $re -gt 0 ]; then
    gap=$(( ( t1 * b ) + b - ts ))
    if [ a"$minbid" != "a" ]; then
      if [ $gap -lt $mingap ]; then
        mingap=$gap
        minbid=$b
      fi
    else
      minbid=$b
      mingap=$gap
    fi
  fi
done

echo Bus ID: $minbid  with $mingap to wait
