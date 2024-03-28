#/bin/sh

export AWS_PROFILE=
export AWS_DEFAULT_OUTPUT="text"

function disable_access_key() {
  local user=$1

  access_keys=`aws iam list-access-keys --user-name ${user} --query "AccessKeyMetadata[].AccessKeyId"`
  for access_key in ${access_keys}
  do
    aws iam update-access-key --user-name ${user} --access-key-id ${access_key} --status Inactive
  done
}

function disable_user() {
  local user=$1

  aws iam delete-login-profile --user-name ${user}
}

user=$1

disable_access_key "${user}"
disable_user "${user}"
