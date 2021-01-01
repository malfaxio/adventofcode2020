#!/bin/bash

declare -a seats
seats=( `cat seats.txt` )

function getSeat () {
  local x=$1
  local y=$2
  
  local l=${seats[$y]}
  echo ${l:$x:1}
}

function getSurrounding () {
  local x=$1
  local y=$2


  minx=$(( x - 1 ))
  maxx=$(( x + 1 ))
  miny=$(( y - 1 ))
  maxy=$(( y + 1 ))
  if [ $minx -lt 0 ]; then
    minx=0
  fi
  if [ $miny -lt 0 ]; then
    miny=0
  fi
  if [ $maxx -ge "${#seats[$y]}" ]; then
    maxx=$(( ${#seats[$y]} - 1 ))
  fi
  if [ $maxy -ge ${#seats[@]} ]; then
    maxy=$(( ${#seats[@]} - 1 ))
  fi
  local surround=0  
  for (( xc=minx; xc<=maxx; xc++)); do
    for (( yc=miny; yc<=maxy; yc++)); do
      s=$(getSeat $xc $yc)
      if [ $xc -eq $x ] && [ $yc -eq $y ]; then
        s=$s
      else
        if [ a"$s" == "a#" ]; then
          let surround++
        fi
      fi
    done
  done

  echo $surround
}

# Main loop
exitf=0
rounds=0
while [ $exitf -eq 0 ]; do
  let rounds++
  data=$(date +"%F %T")
  printf "%s Round: % 4d\n" "$data" $rounds
  declare -a nseats=()
  y=0
  while [ $y -lt ${#seats[@]} ]; do
    l=${seats[$y]}
    l2=""
    x=0
    while [ $x -lt ${#l} ]
    do
      s=$(getSeat $x $y) 
      n=$(getSurrounding $x $y)
      case "$s" in
        "L")
          if [ $n -eq 0 ]; then
            ns="#"
          else
            ns="L"
          fi
          ;;
        "#")
          if [ $n -gt 3 ]; then
            ns="L"
          else
            ns="#"
          fi
          ;;
        ".")
          ns=$s
          ;;
      esac
      l2=${l2}${ns}
      let x++
    done
    nseats=( ${nseats[@]} "$l2" )
    let y++
  done
  
  md5s=$(echo "${seats[@]}" | md5)
  md5ns=$(echo "${nseats[@]}" | md5)
  if [ "a$md5s" == "a$md5ns" ]; then
    exitf=1
  else
    seats=( ${nseats[@]} )
  fi
done

echo Rounds: $rounds
y=0
c=0
while [ $y -lt ${#seats[@]} ]; do
  l=${seats[$y]}
  x=0
  while [ $x -lt ${#l} ]; do
    s=$(getSeat $x $y)
    if [ a"$s" = "a#" ]; then
      let c++
    fi
    let x++
  done
  let y++
done
echo Occupied seats: $c
