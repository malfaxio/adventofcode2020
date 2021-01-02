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
  local surround=0
  local dx
  local dy
  local x
  local y
  local maxx=$(( ${#seats[$y]} ))
  local maxy=$(( ${#seats[@]} ))

  for idir in $(seq 0 7); do
    x=$1
    y=$2
    case $idir in
      0) # up
        dx=0
        dy=-1
        ;;
      1) # up right
        dx=1
        dy=-1
        ;;
      2) # right
        dx=1
        dy=0
        ;;
      3) # down right
        dx=1
        dy=1
        ;;
      4) # down
        dx=0
        dy=1
        ;;
      5) # down left
        dx=-1
        dy=1
        ;;
      6) # left
        dx=-1
        dy=0
        ;;
      7) # up left
        dx=-1
        dy=-1
        ;;
    esac
    x=$(( x + dx ))
    y=$(( y + dy ))
    while [ $x -ge 0 ] && [ $x -lt $maxx ] && [ $y -ge 0 ] && [ $y -lt $maxy ]; do
      local s=$( getSeat $x $y )
      if [ a"$s" == "a#" ]; then
        let surround++
        break
      elif [ a"$s" == "aL" ]; then
        break
      fi
      x=$(( x + dx ))
      y=$(( y + dy ))
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
  #echo ${seats[@]} | tr " " "\n"
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
          if [ $n -gt 4 ]; then
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
  #echo $md5s $md5ns
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
