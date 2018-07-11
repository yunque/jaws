#!/bin/bash
#
# Usage:
#    ./rds_sleep.sh <instance_name>

# Get RDS status
instance_name=$1
status=$(aws rds describe-db-instances \
           --db-instance-identifier $instance_name
           | jq ".DBInstances[0].DBInstanceStatus")
status=${status//\"}

# Actions
if [ $status == "available" ]; then
  echo "RDS instance going to sleep...";
  aws rds stop-db-instance \
    --db-instance-identifier ciph2018-rds
elif [ $status == "stopped" ]; then
  echo "RDS instance already asleep.";
else
  echo "RDS instance status:" $status
fi

