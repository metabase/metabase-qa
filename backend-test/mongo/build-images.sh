#!/bin/sh

# Builds (and for now pushes) all Mongo images

# Loop through our different versions, hard-coded for now
for version in 4.0 5.0; do
    echo "Building Mongo ${version}"
    BUILD_IMAGE_NAME="metabase-qa/mongo-ssl:${version}"
    CONTAINER_REPO_TAG="metabase/qa-databases:mongo-ssl-${version}"

    # First build the image
    docker build -t ${BUILD_IMAGE_NAME} -f ${version}/Dockerfile .

    # Push up to Docker hub
    # TODO: Break this step out
    docker tag ${BUILD_IMAGE_NAME} ${CONTAINER_REPO_TAG}
    docker push ${CONTAINER_REPO_TAG}
done
