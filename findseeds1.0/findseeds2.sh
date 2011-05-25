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
  # find frequent seeds #
  time perl ./freq_check_seeds5.pl ./${1}leafrep${r}cfs70 ./${1}leafrep${r} ./${1}leafrep${r}cffs
done
