#!/bin/bash
set -e

if [[ -z  ${TEST_ACCOUNT_ASSUMED_ROLE} ]]; then
  echo "[INFO] Local Deployment"
  exit 0
fi

echo "Assume Role in Test Account"
aws sts assume-role --role-arn ${TEST_ACCOUNT_ASSUMED_ROLE} --role-session-name "deployment" > /tmp/role
export AWS_ACCESS_KEY_ID=$(cat /tmp/role|jq -r '.Credentials.AccessKeyId')
export AWS_SECRET_ACCESS_KEY=$(cat /tmp/role|jq -r '.Credentials.SecretAccessKey')
export AWS_SESSION_TOKEN=$(cat /tmp/role|jq -r '.Credentials.SessionToken')