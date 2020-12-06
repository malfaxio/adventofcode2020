#!/bin/bash

function checkField () {
  cf=0
  cid=0
  for f in $*
  do
    field=$(echo $f | cut -d: -f1)
    value=$(echo $f | cut -d: -f2)
    case "$field" in
      "byr" | "iyr" | "eyr" | "hgt" | "hcl" | "ecl" | "pid")
        if [ a"$value" != "a" ]; then
          let cf++
        fi
      ;;
      *)
      ;;
    esac
  done
  if [ $cf -eq 7 ]; then
    r=1
  else
    r=0
  fi

  return $r
}

valid=0
declare -a passport=()
while read l
do
  if [ a"$l" == "a" ]; then
    checkField ${passport[*]}
    if [ $? -eq 1 ]; then
      let valid++
    fi
    passport=()
  else
    passport=(${passport[*]} ${l[*]})
  fi
done < passports.txt
checkField ${passport[*]}

if [ $? -eq 1 ]; then
  let valid++
fi
echo "Valid: $valid"

