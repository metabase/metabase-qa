FROM mysql:8

# We use a standard set of database names and users for our sample images
ENV MYSQL_DATABASE=sample
ENV MYSQL_USER=metabase
ENV MYSQL_PASSWORD=metasample123

# MySQL requires a root user password, we just use the same sample password
ENV MYSQL_ROOT_PASSWORD=metasample123

COPY data/sample_data.sql.gz /docker-entrypoint-initdb.d/sample_data.sql.gz

# Similar to other images, we specify a custom mysql data directory so it can be persisted to an image
CMD ["--datadir", "/var/lib/mysql-mbsample"]

# Nope: "--character-set-server", "utf8mb4"