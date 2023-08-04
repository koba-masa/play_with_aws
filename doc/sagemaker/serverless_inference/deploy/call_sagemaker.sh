#!/bin/sh

output_file="output.txt"
endpoint_name=$2

# echo -n "test" | base64
# dGVzdA==
# body="dGVzdA=="
# aws sagemaker-runtime invoke-endpoint --endpoint-name ${endpoint_name} --body ${body} ${output_file} --profile $1

body="fileb://`pwd`/sample.png"
aws sagemaker-runtime invoke-endpoint --endpoint-name ${endpoint_name} --body ${body} --content-type image/png ${output_file} --profile $1


cat ${output_file}
