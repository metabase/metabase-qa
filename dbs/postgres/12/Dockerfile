FROM postgres:12-alpine

# We use a standard set of database names and users for our sample images
# PostgreSQL sets VOLUME /var/lib/postgresql/data in its Dockerfile which means it will be empty every time the container starts if you don’t persist it to the Docker host. 
ENV POSTGRES_DB=sample POSTGRES_USER=metabase POSTGRES_PASSWORD=metasample123 PGDATA=/data

COPY sample_data.sql.gz /docker-entrypoint-initdb.d/sample_data.sql.gz

