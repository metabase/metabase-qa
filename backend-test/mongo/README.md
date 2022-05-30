# Mongo database for backend tests

This folder contains instructions for building empty Mongo database containers
containing server, CA and client certificates for testing SSL support.

For example, a version 5.0 Mongo server can be run such:

```shell
docker run -it --rm -p 27017:27017 --name metamongo metabase/qa-databases:mongo-ssl-5.0 --tlsMode requireTLS --tlsCertificateKeyFile /etc/mongo/metamongo.pem --tlsCAFile /etc/mongo/metaca.crt
```
