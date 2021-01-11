#!/bin/bash

file=mem.txt

function getval () {
  m=$2
  local v=$(printf "%036s" $( echo "2o $1 p" | dc ))
  >&2 echo "Val: $v"
  for (( i=0; i < ${#m}; i++ )); do
    if [ ${m:$i:1} != "X" ]; then
      v=${v:0:$i}${m:$i:1}${v:$(( i+1 ))}
    fi
  done
  echo "2i $v p" | dc
}


declare -a memory=()
while read l; do
  c=$(echo $l | cut -d= -f1 | sed "s/ //g")
  p=$(echo $l | cut -d= -f2 | sed "s/ //g")
  if [ "a$c" == "amask" ]; then
    mask=$p
    echo $mask
  else
    addr=$( echo "${c:4}" | sed -E "s/\]//" )
    echo MEM: $addr = $p
    val=$(getval $p $mask)
    echo "memory[$addr]=$val"
    memory[$addr]=$val
  fi
done < $file

s=0
for v in ${memory[@]}; do
  s=$(( s + v ))
done
echo "sum: $s"
