FROM mongo:4.2.12

# We use a standard set of database names and users for our sample images
ENV MONGO_INITDB_ROOT_USERNAME=metabase MONGO_INITDB_ROOT_PASSWORD=metasample123 MONGO_INITDB_DATABASE=sample

# We copy in our initialization data
COPY *.tsv load.sh /docker-entrypoint-initdb.d/

# In order to have an image with pre-populated data, we override the db path
RUN mkdir /data/db2/ \
    && chown -R mongodb:mongodb /data/db2

CMD ["mongod", "--dbpath", "/data/db2/"]