#!/bin/bash

map=$(cat map.txt)

my=$(echo "$map" | wc -l)

function pointer () {
  l=$1
  i=0
  while [ $i -lt $2 ]; do
    echo -n ${l:$i:1}
    let i++
  done
  echo "$3"
}

# read the data at given position x,y
function isTree () {
  x=$1
  let x=x%31
  y=$2
  l=$(echo "$map" | head -$y | tail -1)
  #printf "%s\r" $l
  if [ a"${l:$x:1}" == "a#" ]; then
    #pointer $l $x X
    r=1
  else
    #pointer $l $x O
    r=0
  fi
  return $r
}

declare -a res

for delta in "1,1" "3,1" "5,1" "7,1" "1,2"
do 
  dx=$(echo $delta | cut -d, -f1)
  dy=$(echo $delta | cut -d, -f2)
  x=0
  y=1
  ntree=0
  while [ $y -le $my ]; do
    isTree $x $y
    if [ $? -eq 1 ]; then
      let ntree++
    fi 
    let x+=dx
    let y+=dy
  done
  echo "($delta) N. of Tree: $ntree"
  res=( "${res[@]}" "$ntree" )
done

echo ${res[*]}
