#!/bin/bash
#
#$ -l mem_free=3G
#$ -S /bin/bash -cwd
#$ -M r.avinash@ufl.edu -m e


for r in 6 7 8 9 10
do
  
  time ./nw_match $1$2${3}rep${r}70_cfs $1$2${3}rep${r} 70 

done
