#! /usr/bin/bash
accumulate1=0
for filename in ./$1$2$3*
do
  echo $filename
  output=$(head -n 1 $filename)
  echo $output >> ../opsizes/$1$2$3
  let accumulate=$accumulate+$output  
done

echo $accumulate

