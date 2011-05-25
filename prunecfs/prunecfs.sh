#!/bin/bash

for filename in *
do
  echo $filename
  head -n 500 $filename > ../${1}treepcfs/$filename
done
