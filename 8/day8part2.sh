#!/bin/bash

istr=()
exec=()

i=0
while read s; do
  istr[$i]=$s
  alt[$i]=""
  let i++
done < code.txt
maxIstr=$i
mex=0

while [ $mex -eq 0 ]; do
  for i in $(seq 0 $maxIstr)
  do
    exec[$i]=0
  done
  ex=0
  i=0
  accumulator=0
  chg=0
  while [ $ex -eq 0 ] && [ $i -lt $maxIstr ]
  do
    if [ ${exec[$i]} -gt 0 ]; then
      echo "too much exec"
      ex=1
    else
      echo I: ${istr[$i]}
      exec[$i]=$(( ${exec[$i]} + 1 ))
      case "${istr[$i]}" in
        acc*)
          accumulator=$(( $accumulator + $(echo ${istr[$i]} | cut -d' ' -f2) ))
          let i++
          ;;
        jmp*)
          if [ a"${alt[$i]}" == "a" ] && [ $chg -eq 0 ]; then
            alt[$i]="nop $(echo ${istr[$i]} | cut -d' ' -f2)"
            echo "Change: ${istr[$i]} with ${alt[$i]}"
            chg=1
            let i++
          else
            i=$(( $i + $(echo ${istr[$i]} | cut -d' ' -f2) ))
          fi
          ;;
        nop*)
          j=$(echo ${istr[$i]} | cut -d' ' -f2)
          if [ a"${alt[$i]}" == "a" ] && [ $j != "+0" ] && [ $chg -eq 0 ]; then
            alt[$i]="jmp $(echo ${istr[$i]} | cut -d' ' -f2)"
            echo "Change: ${istr[$i]} with ${alt[$i]}"
            i=$(( $i + $(echo ${istr[$i]} | cut -d' ' -f2) ))
            chg=1
          else
            let i++
          fi
          ;;
      esac 
    fi
  done
  if [ $i -eq $maxIstr ]; then
    mex=1
  fi
done
echo "End"
echo ACC: $accumulator

