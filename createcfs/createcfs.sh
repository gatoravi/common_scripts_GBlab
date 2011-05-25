#!/bin/bash

for r in {1..10}
do
  for k in 3 4 5 6
  do 
    cat ./${1}treefs/${1}treerep${r}${k}fs70 >> ./${1}treecfs/${1}treerep${r}${k}cfs70    
  done
done
