#!/bin/bash
set -e

# Run terratest
echo "Running Terratest"
go get "github.com/gruntwork-io/terratest/modules/terraform" \
   "github.com/stretchr/testify/assert" \
   "strings" \
   "testing" \
   "fmt" \
   "github.com/gruntwork-io/terratest/modules/random" \
   "github.com/gruntwork-io/terratest/modules/aws"

mkdir ${BASE_PATH}/cicd/test/reports
go test ${BASE_PATH}/cicd/test/cicd_test.go -timeout 10m -v | tee ${BASE_PATH}/cicd/test/reports/test_output.log
retcode=${PIPESTATUS[0]}

echo "Creating Logs"
terratest_log_parser -testlog ${BASE_PATH}/cicd/test/reports/test_output.log -outputdir ${BASE_PATH}/cicd/test/reports

exit ${retcode}