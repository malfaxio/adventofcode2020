#!/bin/bash

# N/S
wlat=1
wlon=10
lat=0
lon=0
dir=0

while read mov; do
  c=${mov:0:1}
  m=${mov:1}
  #printf "%4s C: %s  M: %3d >" $mov $c $m
  #   lat
  #    N+
  #    |
  #-W--X--E+ lon
  #    |
  #    S-
  #
  case $c in
    "F")
      lon=$(( lon+(wlon*m) ))
      lat=$(( lat+(wlat*m) ))
      ;;
    "N")
      let wlat+=m
      ;;
    "S")
      let wlat-=m
      ;;
    "E")
      let wlon+=m
      ;;
    "W")
      let wlon-=m
      ;;
    "R")
      case "$m" in
        "90")
          let wlon1=wlat
          let wlat1=-wlon
          ;;
        "180")
          let wlon1=-wlon
          let wlat1=-wlat
          ;;
        "270")
          let wlon1=-wlat
          let wlat1=wlon
          ;;
      esac
      wlon=$wlon1
      wlat=$wlat1
      ;;
    "L")
      case "$m" in
        "90")
          let wlon1=-wlat
          let wlat1=wlon
          ;;
        "180")
          let wlon1=-wlon
          let wlat1=-wlat
          ;;
        "270")
          let wlon1=wlat
          let wlat1=-wlon
          ;;
      esac
      wlon=$wlon1
      wlat=$wlat1
      ;;
  esac
  #printf " (%4d,%4d) lat: %6d  lon: %6d\n" $wlon $wlat $lat $lon
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
