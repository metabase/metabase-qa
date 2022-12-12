#!/bin/bash

mongod --dbpath /data/db2/ --sslMode requireSSL --sslPEMKeyFile /etc/mongo/metamongo.pem --sslCAFile /etc/mongo/metaca.crt
