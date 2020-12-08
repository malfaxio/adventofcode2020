#!/bin/bash

function countchar () {
  s=$1
  cc=$(for c in $(seq 0 $(( ${#s} - 1 )) )
  do
    echo ${s:$c:1}
  done |sort -u | wc -l)
  return $cc
}

ss=0
answeringroup=""
while read l
do
  if [ a"$l" == "a" ]; then
    countchar $answeringroup
    c=$?
    let ss+=c
    answeringroup=""
  else
    answeringroup="${answeringroup}${l}"
  fi
done < answers.txt
countchar $answeringroup
c=$?
let ss+=c
echo "S: " $ss
