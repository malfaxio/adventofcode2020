#!/bin/bash

function countchar () {
  n=$1
  s=$2
  r=0
  cc=$(for c in $(seq 0 $(( ${#s} - 1 )) )
  do
    echo ${s:$c:1}
  done |sort |uniq -c)
  while read n1 a1
  do
    if [ $n1 -eq $n ]; then
      let r++
    fi
  done <<<"$cc"
  return $r
}

ss=0
answeringroup=""
np=0
while read l
do
  if [ a"$l" == "a" ]; then
    countchar $np $answeringroup
    c=$?
    let ss+=c
    answeringroup=""
    np=0
  else
    answeringroup="${answeringroup}${l}"
    let np++
  fi
done < answers.txt
countchar $np $answeringroup
c=$?
let ss+=c
echo "S: " $ss
