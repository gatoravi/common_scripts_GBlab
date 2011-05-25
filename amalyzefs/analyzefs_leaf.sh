#! /usr/bin/bash
#Analyze and combine all the fs files.
for t in $1
do 
  rm -r ${t}leaffs
  rm -r ${t}leafcfs
  rm -r ${t}leafscfs
  rm -r ${t}leafpscfs
  
  mkdir ${t}leaffs
  mkdir ${t}leafcfs
  mkdir ${t}leafscfs
  mkdir ${t}leafpscfs

  #Copy all the fs files to a folder  
  cp ${t}leaf_ops/*fs70* ${t}leaffs/  
  
  #combine all the fs  
  for r in {1..10}
  do
    for k in 3 4 5 6
    do
      echo rep${r}${k}
      cat ./${t}leaffs/*rep${r}${k}*fs70 >>  ./${t}leafcfs/${t}leafrep${r}cfs
      cat ./${t}leaffs/*rep${r}${k}*fs70_frequencies >>  ./${t}leafcfs/${t}leafrep${r}cfs_frequencies
    done
  done 
  
  cp -r ${t}leafcfs/* ${t}leafscfs/
  
  #Sort all the seeds based on frequency
  for filename in ./${t}leafscfs/*cfs
  do
      echo now sorting $filename
      ./sortseeds $filename
  done
  
  cd ${t}leafscfs
  #prune all the frequent seeds  
  for filename in *cfs
  do 
      echo pruning $filename
      head -n 800 $filename > ../${t}leafpscfs/$filename
  done   
  
  for filename in *cfs_frequencies
  do
      echo pruning $filename
      head -n 800 $filename > ../${t}leafpscfs/$filename
  done
  
  cd ..
done
