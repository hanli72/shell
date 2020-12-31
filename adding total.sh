#!/bin/bash

cat pay.txt |awk 'NR==1 {printf "%10s %10s %10s %10s %10s \n", $1, $2,$3,$4, "total"}; NR>=2 {total=$2+$3+$4; printf "%10s %10d %10d %10d %10.2f \n", $1, $2,$3,$4,total}'
