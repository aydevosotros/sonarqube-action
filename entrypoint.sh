#!/bin/bash

set -e

REPOSITORY_NAME=$(basename "${GITHUB_REPOSITORY}")

echo "Listing current dir:"
ls -lh

[[ ! -z ${INPUT_PASSWORD} ]] && SONAR_PASSWORD="${INPUT_PASSWORD}" || SONAR_PASSWORD=""

if [[ ! -f "${GITHUB_WORKSPACE}/sonar-project.properties" ]]; then
  echo "No sonar-project.properties file found"
  [[ -z ${INPUT_PROJECTKEY} ]] && SONAR_PROJECTKEY="${REPOSITORY_NAME}" || SONAR_PROJECTKEY="${INPUT_PROJECTKEY}"
  [[ -z ${INPUT_PROJECTNAME} ]] && SONAR_PROJECTNAME="${REPOSITORY_NAME}" || SONAR_PROJECTNAME="${INPUT_PROJECTNAME}"
  [[ -z ${INPUT_PROJECTVERSION} ]] && SONAR_PROJECTVERSION="" || SONAR_PROJECTVERSION="${INPUT_PROJECTVERSION}"
  sonar-scanner -X \
    -Dsonar.host.url=${INPUT_HOST} \
    -Dsonar.projectKey=${SONAR_PROJECTKEY} \
    -Dsonar.projectName=${SONAR_PROJECTNAME} \
    -Dsonar.projectVersion=${SONAR_PROJECTVERSION} \
    -Dsonar.login=${INPUT_LOGIN} \
    -Dsonar.password=${SONAR_PASSWORD} \
    -Dsonar.sources=. \
    -Dsonar.sourceEncoding=UTF-8
else
  echo "No sonar-project.properties file found"
  sonar-scanner -X \
    -Dsonar.host.url=${INPUT_HOST} \
    -Dsonar.login=${INPUT_LOGIN} \
    -Dsonar.password=${SONAR_PASSWORD}
fi
