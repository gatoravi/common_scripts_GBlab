#! /usr/bin/bash

for filename in ./*
do
  head $filename -n 300 > ../opcfs_sorted_pruned/$filename
done
