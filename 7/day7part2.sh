#!/bin/bash

RULEFILE="rules.txt"

function getContainer () {
  set -x
  b=$1
  rr=0
  sb=0
  while read s
  do
    if [ "$s" == "no other" ]; then
      rr=0
    else
      echo $s >> res.txt
      num=$(echo $s | cut -d" " -f1)
      bag=$(echo $s | cut -d" " -f2-)
      r=$(getContainer "$bag")
      rr=$(( $rr + $num * $r ))
      sb=$(( $sb + $num ))
    fi
  done <<< "$(grep "^$b" $RULEFILE | awk -F'bags contain ' '{ print $2 }' | tr , '\n' |sed -e 's/bag[s.]*//' -e 's/^ *//')"
  echo $(( $rr + $sb ))
}


> res.txt

r=$(getContainer "shiny gold")

echo $r
