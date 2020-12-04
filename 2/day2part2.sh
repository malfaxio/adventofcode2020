#!/bin/bash

valid=0
while read range char password
do
  x=$(( $(echo $range | cut -d- -f1) - 1))
  y=$(( $(echo $range | cut -d- -f2) - 1))
  xc=${password:$x:1} 
  yc=${password:$y:1}
  c=${char%\:}
  if [ "x$xc" == "x$c" -a "y$yc" != "y$c" ] || [ "x$xc" != "x$c" -a "y$yc" == "y$c" ]; then 
    let valid++
  fi
done < password.txt

echo Valid: $valid

