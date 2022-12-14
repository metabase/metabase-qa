# Mongo Sample Database

This Mongo sample data is prepared directly from the Postgres database.

Just run spin up a Postgres sample database and run `update.sh`.

```shell
docker run --rm -d --name mb-postgres-12 -p 5433:5432 -v "$(pwd)/data:/tmp" metabase-qa/postgres-sample:12
```

```sql
COPY (
    SELECT 
        id AS "id.int64()",
	    address AS "address.string()",
        email AS "email.string()",
        password AS "password.string()",
        name AS "name.string()", 
        city AS "city.string()", 
        longitude AS "longitude.double()",
        state AS "state.string()",
        source AS "source.string()",
        birth_date AS "birth_date.date(2006-01-02)",
        zip AS "zip.string()",
        latitude AS "latitude.double()",
        created_at AS "created_at.date(2006-03-02 15:04:05.99999999)"
    FROM 
        people
) TO '/tmp/sample-people.tsv' WITH (FORMAT CSV, HEADER TRUE, DELIMITER E'\t');

COPY (
    SELECT
        id AS "id.int64()",
        ean AS "ean.string()",
        title AS "title.string()",
        category AS "category.string()",
        vendor AS "vendor.string()",
        price AS "price.double()",
        rating AS "rating.double()",
        created_at AS "created_at.date(2006-03-02 15:04:05.99999999)"
    FROM products
) TO '/tmp/sample-products.tsv' WITH (FORMAT CSV, HEADER TRUE, DELIMITER E'\t');

COPY (
    SELECT
        id AS "id.int64()",
        user_id AS "user_id.int64()",
        product_id AS "product_id.int64()",
        subtotal AS "subtotal.double()",
        tax AS "tax.double()",
        total AS "total.double()",
        discount AS "discount.double()",
        created_at AS "created_at.date(2006-03-02 15:04:05.99999999)",
        quantity AS "quantity.int32()"
    FROM orders
) TO '/tmp/sample-orders.tsv' WITH (FORMAT CSV, HEADER TRUE, DELIMITER E'\t');

COPY (
    SELECT
        id AS "id.int64()",
        product_id AS "product_id.int64()",
        reviewer AS "reviewer.string()",
        rating AS "rating.int32()",
        body AS "body.string()",
        created_at AS "created_at.date(2006-03-02 15:04:05.99999999)"
    FROM reviews
) TO '/tmp/sample-reviews.tsv' WITH (FORMAT CSV, HEADER TRUE, DELIMITER E'\t');

COPY (
    SELECT
        keypath AS "keypath.string()",
        value AS "value.string()"
    FROM _metabase_metadata
) TO '/tmp/sample-_metabase_metadata.tsv' WITH (FORMAT CSV, HEADER TRUE, DELIMITER E'\t');
```


And try to import into a mongo image.

```shell
docker run --rm -d --name mb-mongo -p 27017:27017 -v "$(pwd)/data:/tmp" mongo:4.0
```

```shell
for table in people products orders reviews _metabase_metadata; do
    echo "Loading ${table}"
    mongoimport --drop --db sample --collection ${table} --type tsv --file "/tmp/sample-${table}.tsv" --headerline --columnsHaveTypes --ignoreBlanks
done
```

One issue is that the `discount` field in `orders` can be null. So we had to add `--ignoreBlanks`

```
use sample
db.orders.find({'discount': {$exists: false}})
```

## Running the server with SSL support

```shell
docker run -it --rm -p 27017:27017 --name metamongo metabase/qa-databases:mongo-ssl-5.0 mongod --dbpath /data/db2/ --tlsMode requireTLS --tlsCertificateKeyFile /etc/mongo/metamongo.pem --tlsCAFile /etc/mongo/metaca.crt
```
