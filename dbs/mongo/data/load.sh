#!/bin/sh

# Data loader for MongoDB
for table in people products orders reviews _metabase_metadata accounts analytic_events feedback invoices; do
    echo "Loading ${table}"
    mongoimport --drop --db sample --collection ${table} --type tsv \
        --file "/docker-entrypoint-initdb.d/sample-${table}.tsv" \
        --headerline \
        --columnsHaveTypes \
        --ignoreBlanks
done
