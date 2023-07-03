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

COPY (
    SELECT
        id AS "id.int64()",
        email AS "email.string()",
        first_name AS "first_name.string()",
        last_name AS "last_name.string()",
        plan AS "plan.string()",
        source AS "source.string()",
        seats AS "seats.int32()",
        created_at AS "created_at.date(2006-03-02 15:04:05.99999999)",
        trial_ends_at AS "trial_ends_at.date(2006-03-02 15:04:05.99999999)",
        canceled_at AS "canceled_at.date(2006-03-02 15:04:05.99999999)",
        trial_converted AS "trial_converted.boolean()",
        active_subscription AS "active_subscription.boolean()",
        legacy_plan AS "legacy_plan.boolean()",
        latitude AS "latitude.double()",
        longitude AS "longitude.double()",
        country AS "country.string()",
    FROM accounts
) TO '/tmp/sample-accounts.tsv' WITH (FORMAT CSV, HEADER TRUE, DELIMITER E'\t');

COPY (
    SELECT
        id AS "id.int64()",
        account_id AS "account_id.int64()",
        event AS "event.string()",
        timestamp AS "timestamp.date(2006-03-02 15:04:05.99999999)",
        page_url AS "page_url.string()",
        button_label AS "button_label.string()",
        FROM analytic_events
) TO '/tmp/sample-analytic_events.tsv' WITH (FORMAT CSV, HEADER TRUE, DELIMITER E'\t');

COPY (
    SELECT
        id AS "id.int64()",
        account_id AS "account_id.int64()",
        email,
        date_received,
        rating,
        rating_mapped,
        body
    FROM feedback
) TO '/tmp/sample-feedback.tsv' WITH (FORMAT CSV, HEADER TRUE, DELIMITER E'\t');

COPY (
    SELECT 
        id AS "id.int64()",
        account_id AS "account_id.int64()",
        payment AS "payment.int32()",
        expected_invoice AS "expected_invoice.boolean()",
        plan as "plan.string()",
        date_received AS "date_received.date(2006-03-02 15:04:05.99999999)",
    FROM invoices
) TO '/tmp/sample-invoices.tsv' WITH (FORMAT CSV, HEADER TRUE, DELIMITER E'\t');