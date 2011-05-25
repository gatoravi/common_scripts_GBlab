#!/bin/bash

sh script $1 = tree  $2 = leaflist $3 = no of ip leaves

for i in 100 250 500
do
  mkdir ${i}leaf
  for r in {1..10}
  do
    echo ./${i}leaf/${i}leafrep$r
    perl randomreplicate_varleaf2.pl $1 $2 ./${i}leaf/${i}leafrep$r $i $3
  done
done

echo Done!
