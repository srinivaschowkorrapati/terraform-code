# Realtime Integration Platform Terraform

This Repository Belongs to Realtime Integration team for deploying resources in to AWS infrastructure across all environments. Please Read the content of this file before proceeding with the repository

## Table of contents

- [Instructions](#Instructions)
- [D&D](#D&D)
- [Pre-requisites](#pre-requisites)
- [Setup](#setup)
- [Environments](#environments)

## Instructions

This repository consists of various checks and validations please make sure you follow the below instructions before making commits/PR/Merges in to the repository

### Security Checks

- Local branch created should follow the naming convention "IPRM-_-_-\*" inorder to be able to merge with Develop branch. (Ex: IPRM-4709-ReadMe-PB). This enables us to integrate the commit details to JIRA board.

- Pull Request is required in order to initiate merge in to various branches. Check the Merging workflow check below and follow the same

Local ("IRPM-_-_-_") ---> Develop ---> SIT ---> VNP ----> main <--- HOTFIX-_-\*

### Terraform Format Check

- Checks if the Code is as per the Terraform language style conventions. To check this locally please find the commands below

Terraform Format Check : terraform fmt -check --recursive
Format the files : terraform fmt --recursive

### Terraform Plan/Apply

- Plane gives an overview of the infrastructure changes that will be made in the respective environment once the code is merged.

- Once Merge is triggered the planned infrasturcture changes will be deployed in to the respective Environment

- Any Errors or failures should be handleded based on scenarios.

## D&D

### DO's:

- Make sure all the code is up to date with the default branch
- Make sure all the format is valid.
- Naming conventions of the branch is as per the Checks
- Approval obtained from Code Owners.
- Revert the merge in case of failures during merge.

### DONT'S:

- Donot merge the code in case of errors.
- Donot merge the code if Update Branch option is enabled.
- Donot Push the Code directly to the Branches

## Pre-requisites

### Pre-requisite repositories

- VPC terraform(Network code) - https://github.com/sainsburys-tech/realtime-integration-platform-network
- Github Runner(Shared repository code) - https://github.com/sainsburys-tech/realtime-integration-platform-shared
- AWS Infrastructure Access Repository - https://github.com/JSainsburyPLC/aws-access
- New Relic Logging - https://github.com/sainsburys-tech/realtime-integration-platform-newrelic

### Pre-requisite artefacts

- Hosted Zone - Environment Specific: It also includes entry addition in jsplc shared infra (https://github.com/JSainsburyPLC/js-devops-shared-infra)
- Certificate for the hosted zone
- New Relic Event Cloudformation artefacts
- Environment Specific tfvars file: Within tfvars/

## Setup

- The project runs with GitHub Actions runner.
- Workflow of each environment is within .github/workflows
- Mandatory labels(environment specific): develop, SIT, VNP
- Pull request is used to run Terraform plan
- Merge request is used to run Terraform apply
- Production Changes will create a RFC using Change API

## Environments

- Dev environment - No approvals
- SIT environment - At least 1 approval
- VNP environment - At least 1 approval
- PROD Environment - At least 1 approval from E2E PLM Change Approvers
