#! /usr/bin/bash

for filename in $1/*
do
  perl leafcount2.pl $filename
done;
