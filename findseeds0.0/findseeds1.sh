#!/bin/bash
#
#$ -cwd
#$ -S /bin/bash -cwd
#$ -l mem_free=3G
#$ -M r.avinash@ufl.edu -m e

#Script for MFAST execution flow
#sample usage : sh MFAST_script.sh k a freq mastsize mastpresentpc


for r in {1..10}
do
  echo $r
  
  # find potential seeds #
  /home/r.avinash/MFAST/mar28_d1/MFAST /home/r.avinash/MFAST/mar28_d1/ds/$4${5}rep$r $1 $2 $3 $4${5}rep${r}s

  # find frequent seeds #
  time perl /home/r.avinash/MFAST/mar28_d1/freq_check_seedsv4.pl /home/r.avinash/MFAST/mar28_d1/ds/${1}s $4${5}rep${r}s $4${5}rep${r}fs

done
