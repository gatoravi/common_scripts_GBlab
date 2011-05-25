#! /usr/bin/bash

for filename in $1/*
do
  tail -n 1 $filename > ${filename}max
  echo done!
done
