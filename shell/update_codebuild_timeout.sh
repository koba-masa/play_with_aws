#!/bin/sh

TIMEOUT=20

export AWS_DEFAULT_OUTPUT="text"

function list() {
  aws codebuild list-projects --query "projects[]"
}

function get_project() {
  local project=$1
  aws codebuild batch-get-projects --names ${project} --query "projects[0].timeoutInMinutes"
}

function update_project_timeout_miniutes() {
  local project=$1
  local timeout=$2

  aws codebuild update-project --name ${project} --timeout-in-minutes ${timeout}
}


region=$1
new_timeout=$2
filter=$3

export AWS_REGION=${region}

projects=`list`
for project in ${projects}
do
  target=`echo ${project} | grep "${filter}"`
  if [ "${target}" == "" ]; then
    continue
  fi

  before_timeout=`get_project "${target}"`

  update_project_timeout_miniutes ${target} ${new_timeout}

  after_timeout=`get_project "${target}"`

  echo "${filter} ${target} ${before_timeout} ${after_timeout}" >> update_codebuild_timeout.log
done
