#!/bin/sh

OUTPUT_FILE="get_ecr_lifecycle.tsv"

function get_repository_names() {
  local query="repositories[].repositoryName"

  aws ecr describe-repositories --query ${query} --output text
}

function get_repository_lifecycle_policies() {
  local repository_name=$1
  local query="[lifecyclePolicyText]"

  aws ecr get-lifecycle-policy --repository-name ${repository_name} --query ${query} --output text
}

export AWS_PROFILE=${AWS_PROFILE}

echo "name\tlifecycle_policy" > ${OUTPUT_FILE}

repository_names=`get_repository_names`

for repository_name in ${repository_names}
do
  lifecycle_policies=`get_repository_lifecycle_policies ${repository_name}`

  if [ -z "${lifecycle_policies}" ]; then
    echo "${repository_name}\t" >> ${OUTPUT_FILE}
  fi

  for lifecycle_policy in ${lifecycle_policies}
  do
    echo "${repository_name}\t${lifecycle_policy}" >> ${OUTPUT_FILE}
  done
done
