#!/bin/sh

# Builds all Postgres images

# Loop through our different versions, hard-coded for now
for version in 11 12; do
    echo "Building Postgres ${version}"
    INTERMEDIATE_CONTAINER_NAME="pg-${version}-$(date +%s)"
    BUILD_IMAGE_NAME="metabase-qa/postgres-sample:${version}"
    CONTAINER_REPO_TAG="metabase/qa-databases:postgres-sample-${version}"

    cp ./data/sample_data.sql.gz ${version}/sample_data.sql.gz
    # First build the image
    docker build -t ${BUILD_IMAGE_NAME} -f ${version}/Dockerfile .
    rm ${version}/sample_data.sql.gz

    # Then run the image so the database gets populated
    docker run -d --name ${INTERMEDIATE_CONTAINER_NAME} ${BUILD_IMAGE_NAME}

    # We have to wait for the database to be populated
    while ! docker exec -it ${INTERMEDIATE_CONTAINER_NAME} psql \
        -U metabase \
        -d sample \
        -c "SELECT 'check='||COUNT(*) FROM _METABASE_METADATA" -t | grep check=42
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