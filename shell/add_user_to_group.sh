#/bin/sh

function add_user_to_group() {
  local user=$1
  local group=$2

  aws iam add-user-to-group --user-name ${user} --group-name ${group}
}

user=$1

add_user_to_group "${user}" "${group}"

