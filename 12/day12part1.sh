#!/bin/bash

# N/S
lat=0
lon=0
dir=0

while read mov; do
  c=${mov:0:1}
  m=${mov:1}
  #echo $mov C: $c M: $m
  #   lat
  #    N+
  #    |
  #-W--X--E+ lon
  #    |
  #    S-
  #
  case $c in
    "F")
      if [ $dir -eq 0 ]; then
        let lon+=m
      elif [ $dir -eq 90 ]; then
        let lat+=m
      elif [ $dir -eq 180 ]; then
        let lon-=m
      elif [ $dir -eq 270 ]; then
        let lat-=m
      fi
      ;;
    "N")
      let lat+=m
      ;;
    "S")
      let lat-=m
      ;;
    "E")
      let lon+=m
      ;;
    "W")
      let lon-=m
      ;;
    "R")
      dir=$(( ( dir - m ) % 360 ))
      ;;
    "L")
      dir=$(( ( dir + m ) % 360 ))
      ;;
  esac
  if [ $dir -lt 0 ]; then
    let dir=360+dir
  fi
  #echo "lat: $lat lon: $lon dir: $dir"
done < dir.txt

las="N"
if [ $lat -lt 0 ]; then
  las="S"
  let lat=0-lat
fi
los="E"
if [ $lon -lt 0 ]; then
  los="W"
  let lon=0-lon
fi
echo $lat $las $lon $los MS: $((lat+lon))
