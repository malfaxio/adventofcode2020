#!/bin/bash

function checkField () {
  cf=0
  for f in $*
  do
    field=$(echo $f | cut -d: -f1)
    value=$(echo $f | cut -d: -f2)
    #echo -n $field = $value :
    case "$field" in
      "byr")
        if [[ "$value" =~ ^[0-9]{4}$ ]] && [ $value -ge 1920 ] && [ $value -le 2002 ]; then
          #echo -n valid
          let cf++
        fi
      ;;
      "iyr")
        if [[ "$value" =~ ^[0-9]{4}$ ]] && [ $value -ge 2010 ] && [ $value -le 2020 ]; then
          #echo -n valid
          let cf++
        fi
      ;;
      "eyr")
        if [[ "$value" =~ ^[0-9]{4}$ ]]; then 
        if [ $value -ge 2020 ] && [ $value -le 2030 ]; then
          #echo -n valid
          let cf++
        fi
        fi
      ;;
      "hgt")
        if [[ "$value" =~ ^[0-9]{3}cm$ ]]; then
          #XXXcm >= 150 <= 193
          #echo -n ${value:0:3} : 
          if [ ${value:0:3} -ge 150 ] && [ ${value:0:3} -le 193 ]; then
            #echo -n valid
            let cf++
          fi
        elif [[ "$value" =~ ^[0-9]{2}in$ ]]; then
          #XXXin >= 59 <= 76
          #echo -n ${value:0:2} : 
          if [ ${value:0:2} -ge 59 ] && [ ${value:0:2} -le 76 ]; then
            #echo -n valid
            let cf++
          fi
        fi
      ;;
      "hcl")
        if [[ "$value" =~ ^\#[0-9a-f]{6}$ ]]; then
          #echo -n valid
          let cf++
        fi
      ;;
      "ecl")
        case "$value" in
          "amb" | "blu" | "brn" | "gry" | "grn" | "hzl" | "oth")
            #echo -n valid
            let cf++
          ;;
          *)
          ;;
        esac
      ;;
      "pid")
        if [[ "$value" =~ ^[0-9]{9}$ ]]; then
          #echo -n valid
          let cf++
        fi
      ;;
      *)
      ;;
    esac
    #echo 
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
      echo ${passport[*]} 
      let valid++
    fi
    passport=()
  else
    passport=(${passport[*]} ${l[*]})
  fi
done < passports.txt

checkField ${passport[*]}
if [ $? -eq 1 ]; then
  echo ${passport[*]}
  let valid++
fi
echo "Valid: $valid"

