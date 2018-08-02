#!/bin/bash
#
# Input:
#   region # stack name (ideally)
#   instance_id # instance name (ideally)
# Output:
#   status
#
# Example:
#   get_instance_status.sh $region $instance_id
#   get_instance_status.sh "eu-west-2" "a123b456-789c-01d2-3efg-h456789ijkl0"
#
# TODO:
# - allow user to give stack and instance name only, instead of region and instance-id

if [ $# -lt 2 ]; then
  echo "Required args: \$region \$instance-id";
  exit 1;
fi

region=$1
instance_id=$2

function get_instance_id {
  instance_id=$(aws opsworks)
}

function get_status (){
status=$(aws opsworks describe-instances \
  --region $region \
  --instance-ids $instance_id \
  | jq ".Instances[0].Status")
  echo $status
}

function strip_char(){
  # Strip char from str
  str=$1
  char=$2
  return=${str//$char}
  echo $return
}

# Get status and remove \" chars
status=$(get_status)
#status=$(strip_char "$status" "\"")
status=${status//\"}

echo -e "status\tinstance_id"
echo -e "$status\t$instance_id"
