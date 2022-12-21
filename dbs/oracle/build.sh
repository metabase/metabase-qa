#!/bin/bash

version=21.3
BUILD_IMAGE_NAME="metabase-qa/oracle-xe:${version}"
CONTAINER_REPO_TAG="metabase/qa-databases:oracle-xe-${version}"

docker build -t ${BUILD_IMAGE_NAME} .
docker tag ${BUILD_IMAGE_NAME} ${CONTAINER_REPO_TAG}
docker push ${CONTAINER_REPO_TAG}
