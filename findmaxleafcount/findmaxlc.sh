#! /usr/bin/bash

for filename in ./*
do
  tail -n 1 $filename > ../apr3_lc_maxsize/$filename
done
