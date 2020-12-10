#!/bin/bash

declare -a xmas=( $(cat xmas.txt) )
limit=2089807806

for x in $(seq 0 $(( ${#xmas[@]} -1 )) ); do
  acc=${xmas[$x]}
  for y in $(seq $(( $x +1 )) $(( ${#xmas[@]} -1 )) ); do
    let acc+=${xmas[$y]}
    if [ $acc -eq $limit ]; then
      echo Trovato $x $y
      
      break 2
    elif [ $acc -gt $limit ]; then
      break 1
    fi
  done
done

mx=${xmas[$x]}
mi=${xmas[$x]}
for j in $(seq $(( $x + 1 )) $y); do
  if [ ${xmas[$j]} -gt $mx ]; then
    mx=${xmas[$j]}
  fi
  if [ ${xmas[$j]} -lt $mi ]; then
    mi=${xmas[$j]}
  fi
done
echo $(( $mx + $mi ))
