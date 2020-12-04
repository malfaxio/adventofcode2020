#!/bin/bash

valid=0
while read range char password
do
  l=$(echo $range | cut -d- -f1)
  m=$(echo $range | cut -d- -f2)

  c=${char%\:}
  n=$(echo $password | grep -o $c |wc -l)
  echo -n "$password $l $m $c $n: "
  if [ $n -ge $l ] && [ $n -le $m ]; then
    echo Valid
    let valid++
  else
    echo Invalid
  fi
done < password.txt
echo $valid

