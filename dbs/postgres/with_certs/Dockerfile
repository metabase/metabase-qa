FROM postgres:14-alpine

# We use a standard set of database names and users for our sample images 
# PostgreSQL sets VOLUME /var/lib/postgresql/data in its Dockerfile which means it will be empty every time the container starts if you don’t persist it to the Docker host. 

ENV POSTGRES_DB=sample POSTGRES_USER=metabase POSTGRES_PASSWORD=metasample123 PGDATA=/data

RUN apk add openssl &&\
    mkdir /var/lib/postgresql/keys /var/lib/postgresql/certs &&\
    chmod og-rwx /var/lib/postgresql/keys /var/lib/postgresql/certs &&\
    openssl req -new -x509 -days 365 -nodes -out /var/lib/postgresql/certs/ca.crt -keyout /var/lib/postgresql/keys/ca.key -subj "/CN=root-ca" &&\
    mkdir /var/lib/postgresql/pgconf &&\
    cp /var/lib/postgresql/certs/ca.crt /var/lib/postgresql/pgconf/ca.crt &&\
    openssl req -new -nodes -out /var/lib/postgresql/server.csr -keyout /var/lib/postgresql/pgconf/server.key -subj "/CN=postgres_with_certs" &&\
    openssl x509 -req -in /var/lib/postgresql/server.csr -days 365 -CA /var/lib/postgresql/certs/ca.crt -CAkey /var/lib/postgresql/keys/ca.key -CAcreateserial -out /var/lib/postgresql/pgconf/server.crt &&\
    chmod og-rwx /var/lib/postgresql/pgconf/* && chown 70 /var/lib/postgresql/pgconf/* &&\
    openssl req -new -nodes -out /var/lib/postgresql/client.csr -keyout /var/lib/postgresql/keys/client.key -subj "/CN=metabase" &&\
    chmod og-rwx /var/lib/postgresql/keys/* &&\
    openssl x509 -req -in /var/lib/postgresql/client.csr -days 365 -CA /var/lib/postgresql/certs/ca.crt -CAkey /var/lib/postgresql/keys/ca.key -CAcreateserial -out /var/lib/postgresql/certs/client.crt

COPY dbs/postgres/with_certs/pg_hba.conf /var/lib/postgresql/

COPY dbs/postgres/data/sample_data.sql.gz /docker-entrypoint-initdb.d/sample_data.sql.gz