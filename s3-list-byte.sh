#!/bin/sh

for i in $(aws s3 ls --profile $1 | awk '{ print $NF }'); 
do 
  printf "$i "; 
  aws s3 ls --recursive --human-readable --summarize $i --profile $1  | grep 'Total'
done
