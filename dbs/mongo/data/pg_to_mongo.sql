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