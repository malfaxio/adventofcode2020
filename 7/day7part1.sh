#!/bin/bash

RULEFILE="rules.txt"

function getHolder () {
  bag=$1
  grep "$bag" $RULEFILE | grep -v "^$bag" | awk -F"bags contain " '{ print $1 }'
}

tf=$(mktemp)
echo "shiny gold" > $tf
> res.txt
n=0
r=1
while [ $r -gt 0 ]
do
  tf2=$(mktemp)
  while read s
  do
    getHolder "$s" >> $tf2
  done <<< "$(cat $tf)"
  cat $tf2 | sort -u > $tf
  r=$(cat $tf | wc -l)
  rm -f $tf2
  cat $tf >> res.txt
done
cat res.txt | sort -u | wc -l
rm -f $tf 
