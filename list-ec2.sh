#!/bin/sh

read -p "Please input ec2 status (stopped|running) ?" ec2_status

read -p "Please type environment (development|staging|infra|production) ?" environment

aws ec2 describe-instances \
--query 'Reservations[*].Instances[*].{Instance:PrivateIpAddress,Name:Tags[?Key==`Name`]|[0].Value}' \
--filters Name=instance-state-name,Values=$ec2_status \
--profile $environment \
--output text
