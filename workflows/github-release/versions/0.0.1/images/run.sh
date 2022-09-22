# !/bin/bash

set -o pipefail

bold() { echo -e "\e[1m$@\e[0m" ; }
red() { echo -e "\e[31m$@\e[0m" ; }
green() { echo -e "\e[32m$@\e[0m" ; }
yellow() { echo -e "\e[33m$@\e[0m" ; }

ok() { green OK ; }

REQUIRED_VARS=(
    GIT_CONTEXT
    REPO_OWNER
    REPO_NAME
    RELEASE_TAG
    RELEASE_NAME
)

OPTIONAL_VARS=(
    RELEASE_DESCRIPTION
    FILES
    DRAFT
    PRERELEASE
    BASE_URL
)

# Defaults
if [ ! -z $FILES ]
then 
  FILES=$(echo "$FILES" | tr "," " ")
fi

env
  
set -x
github-release upload \
    ${DRAFT:+-d true} \
    ${PRERELEASE:+-p $PRERELEASE} \
    ${$BASE_URL:+--baseurl $BASE_URL} \
    --token $GITHUB_TOKEN \
    --owner "$REPO_OWNER" \
    --repo  "$REPO_NAME" \
    --tag "$RELEASE_TAG" \
    --name "$RELEASE_NAME" \
    --body "$RELEASE_DESCRIPTION" \
    $FILES

[ $? = "0" ] && green "Release has been successfully created/updated"
