#!/bin/sh
# WIP

function get_findings() {
  local acconut_id=$1

  local filter="{\"AwsAccountId\":[{\"Value\": \"${account_id}\",\"Comparison\":\"EQUALS\"}],\"WorkflowStatus\":[{\"Value\": \"NEW\",\"Comparison\":\"EQUALS\"}],\"RecordState\":[{\"Value\": \"ACTIVE\",\"Comparison\":\"EQUALS\"}],\"ProductName\":[{\"Value\": \"Security Hub\",\"Comparison\":\"EQUALS\"}]}"
  local query='Findings[].{SeverityLabel:Severity.Label,AwsAccountId:AwsAccountId,WorkflowStatus:Workflow.Status,RecordState:RecordState,ProductName:ProductName,Title:Title,Description:Description,RecommendationText:Remediation.Recommendation.Text,RecommendationUrl:Remediation.Recommendation.Url,Resources:Resources[0].{Type:Type,Id:Id,Region:Region}}'

  aws securityhub get-findings --filter "${filter}" --query "${query}" --output json
}

account_id=$1
region=$2

export AWS_REGION=${region}

get_findings ${account_id}

