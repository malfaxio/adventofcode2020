#!/bin/bash

PRELEN=25

declare -a preamble=()

function isValid () {
  valid=1
  for y in $(seq $(( $1 - $PRELEN )) $1 ); do
    for w in $(seq $(( $y )) $1 ); do
      if [ $(( ${preamble[$(( $w % $PRELEN ))]} + ${preamble[$(( $y % $PRELEN ))]} )) -eq $2 ]; then
        valid=0
        break 2
      fi
    done
  done
 
  return $valid
}

i=0
while read x; do
  echo "X: $x"
  
  if [ $i -ge $PRELEN ]; then
    #echo ${preamble[@]}
    isValid $i $x
    if [ $? -eq 0 ]; then
      echo $?
      echo Valid
    else
      echo INVALID
      break
    fi
    preamble[$(( $i % $PRELEN ))]=$x
  else
    preamble[$(( $i % $PRELEN ))]=$x
  fi
  let i++
done < xmas.txt
