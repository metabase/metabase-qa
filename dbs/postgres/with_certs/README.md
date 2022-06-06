# Postgres 14 with certs

The certs are generated for the hostname postgres_with_certs and with a password of pass:abcd

You have to run the container with
-c ssl=on -c ssl_cert_file=/var/lib/postgresql/pgconf/server.crt -c ssl_key_file=/var/lib/postgresql/pgconf/server.key -c ssl_ca_file=/var/lib/postgresql/pgconf/ca.crt -c hba_file=/var/lib/postgresql/pg_hba.conf