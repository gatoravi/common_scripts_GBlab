#!/bin/bash

for r in {1..10}
do
  for i in 15 20 30
  do
     for j in 80 90
     do
       ./synthetic_ds 100labels.txt $i $j 100 $i${j}rep$r
     done
  done
done
