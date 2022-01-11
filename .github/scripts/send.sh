#!/bin/bash

if [ -z "$3" ]; then
    echo -e "\nMissing argument(s)!\n\nUsage:\n\$ $0 WORKFLOW BRANCH TARGET_ENV\n\n"
    exit 1
fi

if [ -z "$TOKEN" ]; then
    echo -e "Please define the variable \$TOKEN to authenticate to Github API\n\n"
    exit 1
fi

WORKFLOW=$1
BRANCH=$2
TARGET_ENV=$3
REPO="pdonorio/ga-meta-job"

curl \
    --request POST \
    --url "https://api.github.com/repos/${REPO}/actions/workflows/${WORKFLOW}/dispatches" \
    --header 'Content-Type: application/json' \
    --header "Authorization: Bearer ${TOKEN}" \
    --header 'Accept: application/vnd.github.everest-preview+json' \
    --fail \
    --data-raw "{
        \"ref\": \"${BRANCH}\",
        \"inputs\": {
            \"testkey\": \"42\",
            \"target_env\": \"${TARGET_ENV}\"
        }
    }"
