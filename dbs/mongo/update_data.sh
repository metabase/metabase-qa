#!/bin/sh

# This updates the MongoDB sample data using Postgres as the source
#
# Requirements:
# - Docker
# - metabase-qa/postgres-sample:12 image built locally or published

# Build variables
INTERMEDIATE_CONTAINER_NAME="mongo-data-$(date +%s)"
SOURCE_IMAGE_NAME="metabase-qa/postgres-sample:12"

# Step 1: Spin up Postgres with our `data` directory mounted as `/tmp`
docker run --rm -d --name ${INTERMEDIATE_CONTAINER_NAME} -v "$(pwd)/data:/tmp" ${SOURCE_IMAGE_NAME}

# Step 1.5: Wait for Postgres to be ready :)
while ! docker exec -it ${INTERMEDIATE_CONTAINER_NAME} pg_isready
do
    sleep 1
done

# Step 2: Execute a series of SQL commands that copy sample data to TSV files
# We _don't_ run these via standard `/docker-entrypoint-initdb.d` scripts because we already have a data directory
docker exec -it ${INTERMEDIATE_CONTAINER_NAME} psql -U metabase -d sample -f /tmp/pg_to_mongo.sql

# Step 3: Stop the image! We're done. :)
docker stop ${INTERMEDIATE_CONTAINER_NAME}