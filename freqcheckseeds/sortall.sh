#!/usr/bin/sh

for r in {1..10}
do
  perl freq_check_seeds6.pl ${1}leafrep${r}cfs ${1}leafrep${r} ${1}leafrep${r}scfs
done
