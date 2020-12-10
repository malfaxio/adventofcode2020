#!/bin/bash

istr=()
exec=()

i=0
while read s
do
  istr[$i]=$s
  exec[$i]=0
  let i++
done < code.txt
maxIstr=$i

ex=0
i=0
accumulator=0
while [ $ex -ne 1 ] && [ $i -lt $maxIstr ]
do
  if [ ${exec[$i]} -gt 0 ]; then
    ex=1
  else
    exec[$i]=$(( ${exec[$i]} + 1 ))
    echo I: ${istr[$i]}
    case "${istr[$i]}" in
      acc*)
        accumulator=$(( $accumulator + $(echo ${istr[$i]} | cut -d' ' -f2) ))
        let i++
        ;;
      jmp*)
        i=$(( $i + $(echo ${istr[$i]} | cut -d' ' -f2) ))
        ;;
      nop*)
        let i++
        ;;
    esac 
  fi
done
echo ACC: $accumulator
