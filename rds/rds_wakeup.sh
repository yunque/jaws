#!/bin/bash
#
# Usage:
#    ./rds_wakeup.sh <instance_name>

# Get RDS status
instance_name=$1
status=$(aws rds describe-db-instances \
           --db-instance-identifier $instance_name
           | jq ".DBInstances[0].DBInstanceStatus")
status=${status//\"}


# Instance actions
if [ $status == "available" ]; then
  echo "RDS instance already available.";

elif [ $status == "stopped" ]; then
  echo "RDS instance waking up...";
  aws rds start-db-instance \
    --db-instance-identifier $instance_name

else
  echo "RDS instance status: " $status
fi
