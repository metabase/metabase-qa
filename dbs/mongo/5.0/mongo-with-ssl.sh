#!/bin/bash

mongod --dbpath /data/db2/ --tlsMode requireTLS --tlsCertificateKeyFile /etc/mongo/metamongo.pem --tlsCAFile /etc/mongo/metaca.crt
