#! /usr/bin/bash
#Analyze and combine all the fs files.
for t in $1
do 
  rm -r ${t}treefs
  rm -r ${t}treecfs
  rm -r ${t}treescfs
  rm -r ${t}treepscfs
  
  mkdir ${t}treefs
  mkdir ${t}treecfs
  mkdir ${t}treescfs
  mkdir ${t}treepscfs

  #Copy all the fs files to a folder  
  cp ${t}tree_ops/*fs70* ${t}treefs/  
  
  #combine all the fs  
  for r in {1..10}
  do
    for k in 3 4 5 6
    do
      echo rep${r}${k}
      cat ./${t}treefs/*rep${r}${k}*fs70 >>  ./${t}treecfs/${t}treerep${r}cfs
      cat ./${t}treefs/*rep${r}${k}*fs70_frequencies >>  ./${t}treecfs/${t}treerep${r}cfs_frequencies
    done
  done 
  
  cp -r ${t}treecfs/* ${t}treescfs/
  
  #Sort all the seeds based on frequency
  for filename in ./${t}treescfs/*cfs
  do
      perl sort_freq_seeds.pl $filename
  done
  
  cd ${t}treescfs
  #prune all the frequent seeds  
  for filename in *cfs
  do 
      echo pruning $filename
      head -n 800 $filename > ../${t}treepscfs/$filename
  done   
  
  for filename in *cfs_frequencies
  do
      echo pruning $filename
      head -n 800 $filename > ../${t}treepscfs/$filename
  done
  
  cd ..
done
