#!/bin/sh

function read_stdin() {
  local message=$1

  read -p "${message}: " line
  echo ${line}
}

function get_secrets() {
  local secrets_manager_name=$1
  local region=$2

  aws secretsmanager get-secret-value --secret-id ${secrets_manager_name} --query "SecretString" --region ${region} --output text
}

function update_secrets() {
  local secrets_manager_name=$1
  local region=$2
  local secrets=$3

  echo ${secrets_manager_name} ${region}
  echo ${secrets}

  aws secretsmanager put-secret-value --secret-id ${secrets_manager_name} --secret-string ${secrets} --region ${region}
}



src_region=`read_stdin "移行元のSecretsManagerが存在するリージョンを指定してください。"`
src_name=`read_stdin "移行元のSecretsManagerの名前を指定してください。例) sample-secrets"`

dst_region=`read_stdin "移行先のSecretsManagerが存在するリージョンを指定してください。未入力の場合は、${src_region}を使用します"`
if [ "${dst_region}" == "" ]; then
  dst_region=${src_region}
fi
dst_name=`read_stdin "移行先のSecretsManagerの名前を指定してください。例) sample-secrets"`

echo "${src_region} ${src_name} → ${dst_region} ${dst_name}"

src_secrets=`get_secrets "${src_name}" "${src_region}"`

echo ${src_secrets}

update_secrets "${dst_name}" "${dst_region}" "${src_secrets}"
