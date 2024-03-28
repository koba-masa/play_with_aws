#!/bin/sh

OUTPUT_FILE="get_validation_method_of_certification.tsv"

function get_regions() {
  aws ec2 describe-regions --query "Regions[].RegionName"
}

function get_certifications() {
  aws acm list-certificates --query "CertificateSummaryList[].CertificateArn"
}

function get_validation_method() {
  local certification=$1

  aws acm describe-certificate --certificate-arn ${certification} --query "Certificate.DomainValidationOptions[].[DomainName, ValidationMethod]"
}

export AWS_DEFAULT_OUTPUT="text"

echo "region\tdomain name\tvalidation method" > ${OUTPUT_FILE}

regions=`get_regions`

for region in ${regions}
do
  export AWS_REGION=${region}
  certifications=`get_certifications`

  if [ -z "${certifications}" ]; then
    continue
  fi

  for cartification in ${certifications}
  do
    records=`get_validation_method ${cartification} | sed 's/\t/,/g'`
    for record in ${records}
    do
      echo "${region}\t${record}" | sed 's/,/\t/g' >> ${OUTPUT_FILE}
    done
  done
done
