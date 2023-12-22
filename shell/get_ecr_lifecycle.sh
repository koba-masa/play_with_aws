#!/bin/sh

###################################################
# ECRのライフサイクルポリシーの一覧を取得する
#  入力: なし
#  出力:　get_ecr_lifecycle.tsv
###################################################

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

# -------------------------------------------

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
