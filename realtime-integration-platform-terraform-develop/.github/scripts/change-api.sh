#!/bin/bash

set -o errexit
set -o nounset
# Deploys the application, notifying a Change API instance as part of the process.
# These functions are useful to all however they do require putting them in the correct order in your deployment pipeline
# Set the AWS_PROFILE to control the profile serverless framework uses to connect to AWS. It can be left unset.
#
# The STAGE_ENV variable must be set to determine the correct environment to deploy to.
#
#Sample function sequential order:
#
#generate_change_log
#log_changes_for_deployment
#generate_change_request
# Run your deployment e.g Run all the terraform for your deployment and run health checks
#deployment_successful_deployment (or fail if deployment breaks)
#
# The following environment variables are used to record this deployment with the Change API itself:
#  - API_KEY e.g ahidhaihugdaincaiga << Change API Key
#  - DEPLOYMENT_ITEM e.g Logistics Service App << Check Service Now For This
#  - ASSIGNMENT_GROUP e.g Group Data Lime Squad << Check Service Now For This
#  - CHANGE_API_URL e.g https://change.eng.js-devops.co.uk/sops/change << production
#  - GIT_REPO_URL e.g https://github.com/JSainsburyPLC/voyager-config
#  - DEPLOY_BRANCH e.g prod_deployed. The branch you will use to track what is currently in production. Note this can be different to what triggers the pipeline so long as at the end of every
#    deployment it correctly represents what has been deployed in the environment

: ${API_KEY?"Need to set API_KEY"}
: ${DEPLOYMENT_ITEM?"Need to set DEPLOYMENT_ITEM"}
: ${ASSIGNMENT_GROUP?"Need to set ASSIGNMENT_GROUP"}
: ${CHANGE_API_URL?"Need to set CHANGE_API_URL"}
: ${GIT_REPO_URL?"Need to set GIT_REPO_URL"}
: ${DEPLOY_BRANCH?"Need to set DEPLOY_BRANCH"}

BASE_CHANGE_API_URL=$(echo ${CHANGE_API_URL} | cut -d'/' -f1,2,3)

##This function genereates a change log list from your git commit messages
##To do this it compares what you are trying to deploy to the currently deployed branch in github
##e.g when I finish a deployment successfully I push the changes to my deployed branches so the next time a commit can be compared against it
function generate_change_log() {
      echo "Found last deploy branch... creating change log"
      START_COMMIT=$(git rev-parse $DEPLOY_BRANCH)
      END_COMMIT=$(git rev-parse HEAD)

      CHANGES="$(git log -1 --pretty=%b)"
      COMMIT=$(git rev-parse HEAD)
      CHANGE_LINK="${GIT_REPO_URL}/commit/${COMMIT}"
      CHANGELOG_WITH_LINES="${CHANGE_LINK}\n${CHANGES}"
      CHANGELOG=$(echo -e "${CHANGELOG_WITH_LINES}" | sed -E ':a;N;$!ba;s/\n/\\n/g')
}

function generate_change_request() {
  # Tell Change API deployment is starting
  PAYLOAD="{ \"deploymentItem\": \"${DEPLOYMENT_ITEM}\", \"assignmentGroup\": \"${ASSIGNMENT_GROUP}\", \"description\": \"${CHANGELOG}\" }"

  echo "Calling change API: ${CHANGE_API_URL}"
  echo "Change API payload: ${PAYLOAD}"

  CHANGE_RESOURCE=$(curl --location \
       --header "Content-Type: application/json" \
       --header "X-API-KEY: ${API_KEY}" \
       --request POST \
       --data "${PAYLOAD}" \
       ${CHANGE_API_URL})

  echo "Result of submitting new change..."
  echo ${CHANGE_RESOURCE}
}

function fail() {
    echo "Encountered error deploying, notifying Change API..."
    URL_PATH=$(echo ${CHANGE_RESOURCE} | jq '._links.fail.href')
    FAIL_URL="${BASE_CHANGE_API_URL}${URL_PATH//\"/}"
    echo "Using URL ${FAIL_URL}"
    curl --location \
         --header "X-API-KEY: ${API_KEY}" \
         --request POST \
         ${FAIL_URL}

     echo "Change API notified"
     exit
}

function log_changes_for_deployment() {
  # Perform deployment
  echo "Deploying the following changes:"
  echo "${CHANGELOG}"
}

function deployment_successful_deployment(){
  # Notify Change API of successful deployment
  echo "Deployment successful, notifying Change API..."
  URL_PATH=$(echo ${CHANGE_RESOURCE} | jq '._links.succeed.href')
  SUCCEED_URL="${BASE_CHANGE_API_URL}${URL_PATH//\"/}"
  echo "Using URL ${SUCCEED_URL}"
  curl --verbose \
       --fail \
       --location \
       --header "X-API-KEY: ${API_KEY}" \
       --request POST \
       ${SUCCEED_URL}
         
  echo "Change API notified"
}
