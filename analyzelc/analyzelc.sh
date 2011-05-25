#! /usr/bin/bash

# Sample Usage - Put all the ops in 100leaf_ops folder and Call script as " bash analyzelc.sh 100leaf "
 


rm -r ${1}OP
mkdir ${1}OP
rm -r ${1}_lcs
mkdir ${1}_lcs
rm -r ${1}OP_lcmax
mkdir ${1}OP_lcmax
rm -r ${1}OP_lcsum
mkdir ${1}OP_lcsum
rm -r ${1}accumulate
mkdir ${1}accumulate


cp ${1}_ops/*_OP ${1}OP/

bash foreachleafcount.sh ${1}OP

cp ${1}OP/*_lc_s ${1}_lcs/

cd ${1}_lcs

for filename in *
do
  tail -n 1 $filename > ../${1}OP_lcmax/${filename}max
  echo donefindingmax!
done

cd ..

accumulate1=0
sample=0
for filename in ${1}OP_lcmax/*
do
  echo $filename
  output=$(head -n 1 $filename)
  echo $output 
  let accumulate=$accumulate+$output  
  one=1
  sample=$(($sample+$one))
done

echo  accumulate is $accumulate
echo  nsample is $sample
echo  $accumulate > ${1}accumulate/accumulate
echo  $sample > ${1}accumulate/nsample
