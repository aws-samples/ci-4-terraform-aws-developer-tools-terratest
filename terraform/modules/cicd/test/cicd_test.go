package test

import (
	"strings"
	"testing"
	"fmt"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
	"github.com/gruntwork-io/terratest/modules/random"
	"github.com/gruntwork-io/terratest/modules/aws"
)

func TestBitBucketIntegration(t *testing.T) {

	uniqueId := strings.ToLower(random.UniqueId())
	awsRegion := aws.GetRandomStableRegion(t, nil, nil)
	awsAccountID := aws.GetAccountId(t)

	terraformOptions := &terraform.Options{
		// Set the path to the Terraform code that will be tested.
		TerraformDir: "../",

		// Here provide the values for the terraform variables
		Vars: map[string]interface{} {
			"custom_tags": map[string]string {
				"Environment": "Terratest",
    			"TargetAccounts": "Same",
    			"DeploymentType": "Terratest",
			},
			"pipeline_deployment_bucket_name": fmt.Sprintf("testing-%s",uniqueId),
			"roles": []string{},
			"account_id": awsAccountID,
			"region": awsRegion,
			"git_repository_name": "mocked",
			"account_type": "Terratest",
			"branches": []string{"dev"},
		},
	}

	// Clean up resources with "terraform destroy" at the end of the test.
	defer terraform.Destroy(t, terraformOptions)

	// Run "terraform init" and "terraform apply". Fail the test if there are any errors.
	terraform.InitAndApply(t, terraformOptions)
	
	outputCodePipelineName := terraform.Output(t, terraformOptions, "codepipeline_name")
	outputCodeBuildProjectName := terraform.Output(t, terraformOptions, "codebuild_name")

	// // Run `terraform output` to get the values of output variables and check they have the expected values.
	
	assert.Equal(t, "[mocked-dev]", outputCodePipelineName)
	assert.Equal(t, "[mocked-build]", outputCodeBuildProjectName)
}