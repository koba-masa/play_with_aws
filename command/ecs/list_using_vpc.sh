#!/bin/sh

# クラスターの一覧を取得する
function get_clusters() {
  aws ecs list-clusters --query "clusterArns" --output text
}

# サービスの一覧を取得する
function get_services() {
  local cluster_arn=$1
  aws ecs list-services --cluster ${cluster_arn} --query "serviceArns" --output text
}

# サービスの詳細を取得する
function get_subnets() {
  local cluster_arn=$1
  local service_arn=$2
  aws ecs describe-services --cluster ${cluster_arn} --services ${service_arn} --query "services[0].networkConfiguration.awsvpcConfiguration.subnets[0]" --output text
}

function get_vpc_id_from_subnet() {
  local subnet_id=$1
  aws ec2 describe-subnets --subnet-ids ${subnet_id} --query "Subnets[*].VpcId" --output text
}

cluster_arns=`get_clusters`
for cluster_arn in ${cluster_arns}
do
  service_arns=`get_services ${cluster_arn}`
  for service_arn in ${service_arns}
  do
    subnet_ids=`get_subnets ${cluster_arn} ${service_arn}`
    for subnet_id in ${subnet_ids}
    do
      vpc_id=`get_vpc_id_from_subnet ${subnet_id}`

      echo "${cluster_arn}\t${service_arn}\t${vpc_id}"
    done
    exit
  done
done
