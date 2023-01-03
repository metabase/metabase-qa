FROM mongo:latest

# We use a standard set of database names and users for our sample images
ENV MONGO_INITDB_ROOT_USERNAME=metabase
ENV MONGO_INITDB_ROOT_PASSWORD=metasample123
ENV MONGO_INITDB_DATABASE=sample

# We copy in our initialization data
COPY dbs/mongo/data/*.tsv /docker-entrypoint-initdb.d/
COPY dbs/mongo/data/load.sh /docker-entrypoint-initdb.d/

# Copy mongo server and client certificates. The client certificates are stored
# in the image so that they can be pulled from them for local testing.
COPY dbs/mongo/certificates/metabase.* dbs/mongo/certificates/metamongo.* dbs/mongo/certificates/metaca.* /etc/mongo/

# In order to have an image with pre-populated data, we override the db path
RUN mkdir /data/db2/ \
    && chown -R mongodb:mongodb /data/db2

CMD ["mongod", "--dbpath", "/data/db2/"]
