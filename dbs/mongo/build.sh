#!/bin/sh

# Builds (and for now pushes) all Mongo images

# Loop through our different versions, hard-coded for now
for version in 4.0 5.0; do
    echo "Building Mongo ${version}"
    INTERMEDIATE_CONTAINER_NAME="mongo-${version}-$(date +%s)"
    BUILD_IMAGE_NAME="metabase-qa/mongo-sample:${version}"
    CONTAINER_REPO_TAG="metabase/qa-databases:mongo-sample-${version}"

    # First build the image
    docker build -t ${BUILD_IMAGE_NAME} -f ${version}/Dockerfile .

    # Then run the image so the database gets populated
    docker run -d --name ${INTERMEDIATE_CONTAINER_NAME} ${BUILD_IMAGE_NAME}

    # We have to wait for the database to be populated
    while ! docker exec -it ${INTERMEDIATE_CONTAINER_NAME} mongo \
        -u metabase \
        -p metasample123 sample \
        --eval 'db.orders.count()' \
        --authenticationDatabase admin \
        --quiet | grep 18760

    do
        sleep 1
    done

    # Now that the database has been populated, rm the startup scripts and overwrite the image
    docker exec -it ${INTERMEDIATE_CONTAINER_NAME} sh -c 'rm -rf /docker-entrypoint-initdb.d/*'
    docker commit ${INTERMEDIATE_CONTAINER_NAME} ${BUILD_IMAGE_NAME}

    # And then rm the image
    docker stop ${INTERMEDIATE_CONTAINER_NAME}
    docker rm ${INTERMEDIATE_CONTAINER_NAME}

    # Push up to Docker hub
    # TODO: Break this step out
    docker tag ${BUILD_IMAGE_NAME} ${CONTAINER_REPO_TAG}
    docker push ${CONTAINER_REPO_TAG}
done
