ARG tag=latest
FROM postgres:${tag}

# We use a standard set of database names and users for our sample images
ENV POSTGRES_DB=sample
ENV POSTGRES_USER=metabase
ENV POSTGRES_PASSWORD=metasample123

# PostgreSQL sets VOLUME /var/lib/postgresql/data in its Dockerfile which means it will be empty every time the container starts if you don’t persist it to the Docker host. 
ENV PGDATA=/data

COPY dbs/postgres/data/sample_data.sql.gz /docker-entrypoint-initdb.d/sample_data.sql.gz

