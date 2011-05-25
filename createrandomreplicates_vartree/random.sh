#!/bin/bash

for i in 50 100 200
do
  for r in {1..10}
  do
    echo ./${i}tree/${i}treerep$r
    perl randomreplicates.pl $1 ./${i}tree/${i}treerep$r $i 
  done
done
echo Done!!
