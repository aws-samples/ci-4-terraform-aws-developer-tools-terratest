#!/bin/bash
set -e

cd ${BASE_PATH}/cicd/test
# Run terratest
echo "Running Terratest"
go get "github.com/gruntwork-io/terratest/modules/terraform" \
   "github.com/stretchr/testify/assert" \
   "strings" \
   "testing" \
   "fmt" \
   "github.com/gruntwork-io/terratest/modules/random" \
   "github.com/gruntwork-io/terratest/modules/aws"

mkdir reports
go test cicd_test.go -timeout 10m -v | tee reports/test_output.log
retcode=${PIPESTATUS[0]}

echo "Creating Logs"
terratest_log_parser -testlog reports/test_output.log -outputdir reports

exit ${retcode}