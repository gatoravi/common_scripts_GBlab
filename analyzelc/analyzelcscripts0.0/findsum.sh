#! /usr/bin/bash
accumulate1=0
for filename in ./$1*
do
  echo $filename
  output=$(head -n 1 $filename)
  echo $output 
  let accumulate=$accumulate+$output  
done

echo sumis $accumulate

