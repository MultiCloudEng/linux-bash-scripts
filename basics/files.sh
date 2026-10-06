#!/bin/bash
shopt -s nullglob  # no matches -> loop runs zero times instead of using "*.txt" literally
for file in *.txt
do 
     echo "Processing file: $file"
done
