#!/bin/sh

# Builds all MySQL images

# Loop through our different versions, hard-coded for now
for version in 8 5.7; do
    echo "Building MySQL ${version}"
    INTERMEDIATE_CONTAINER_NAME="pg-${version}-$(date +%s)"
    BUILD_IMAGE_NAME="metabase-qa/mysql-sample:${version}"
    CONTAINER_REPO_TAG="metabase/qa-databases:mysql-sample-${version}"

    # First build the image
    docker build -t ${BUILD_IMAGE_NAME} -f ${version}/Dockerfile .

    # Then run the image so the database gets populated
    docker run -d --name ${INTERMEDIATE_CONTAINER_NAME} ${BUILD_IMAGE_NAME}

    # We have to wait for the database to be populated
    while ! docker exec -it ${INTERMEDIATE_CONTAINER_NAME} mysql \
        -u metabase \
        -pmetasample123 \
        -D sample \
        -sN \
        -e "SELECT CONCAT('check=', COUNT(*)) FROM _METABASE_METADATA" | grep check=42
    do
        sleep 1
    done

    # Now that the database has been populated, overwrite the image
    docker commit ${INTERMEDIATE_CONTAINER_NAME} ${BUILD_IMAGE_NAME}

    # And then rm the image
    docker stop ${INTERMEDIATE_CONTAINER_NAME}
    docker rm ${INTERMEDIATE_CONTAINER_NAME}

    # Push up to Docker hub
    # TODO: Break this step out
    docker tag ${BUILD_IMAGE_NAME} ${CONTAINER_REPO_TAG}
    docker push ${CONTAINER_REPO_TAG}
done