#!/bin/sh
for i in $(aws s3 ls --profile $1 | awk '{ print $NF }');
do
  printf "$i \n";
done

read -p "Check size All S3? " -n 1 -r

if [[ $REPLY =~ ^[Yy]$ ]]
then
  echo ""
  for i in $(aws s3 ls --profile $1 | awk '{ print $NF }');
  do
    getsize=$(aws s3 ls --recursive --human-readable --summarize $i --profile $1  | grep 'Total\ Size'| awk '{print $3,$4}')
    echo "$i size: $getsize"
  done
else
     echo ""
     echo "Please input s3 bucket"
     read s3_bucket
     aws s3 ls --recursive --human-readable --summarize $s3_bucket --profile $1  | grep 'Total'
fi
