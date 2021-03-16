# Table of Contents

- [Table of Contents](#table-of-contents)
- [Introduction](#introduction)
  - [Main features:](#main-features)
  - [Required Variables:](#required-variables)
- [Tests](#tests)

# Introduction

This module will deploy CI pipeline based on `CodePipeline`, `CodeBuild` and `CodeCommit`.

Documentation, about how to deploy it, is provided as an example [here](../../examples/cicd_account/main.tf).

The optional and required parameters to be passed are documented directly in the [variables.tf](./variables.tf) file.

## Main features:

- `CodeBuild` can be deployed in Public and Private Subnet (this needs to be provided apart)
  Private Subnet can be useful in case of connectivity with on-prem resources.
- Support cross account deployments. As a pre-requisite a role thrusting the account where the CI is provided 
  and with the right permissions should be provided.
  
## Required Variables:

- `custom_tags`: tags to be attached to the deployed resources
- `account_type`: Human readable name for the target account. 
  The target account can be either the same account where `CodeBuild` is running or a remote account.
  This value will be exposed as environment variable inside `CodeBuild`.
- `pipeline_deployment_bucket_name`: Bucket name for storing the artifacts, this will be created during 
  `Terraform` run
- `git_repository_name`: The `CodeCommit` repository name that you want to create and will be monitored by `CodePipeline`
 
# Tests

A basic Terraform test is provided for educational purpose using golang `Terratest` library 
and automatically performed by `CodeBuild`.

The test will:
 
1. Try to deploy the all the resources described in the module
2. Check and compare CodePipeline and CodeBuild names
3. Destroy all the resources either is the test failed or exited successfully.
4. Save report and logs locally in order to be retrieved by the CI.




  



