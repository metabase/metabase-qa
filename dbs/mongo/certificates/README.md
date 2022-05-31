# Keys and certificates

This folder contains keys (`*.key`) and certificates (`*.crt`) for a CA
(`metaca`), a client (`metabase`) and a server (`metamongo`). (The `*.pem` files
here are just the concatenation of the corresponding certificate and key files
and are used by mongo.) All certificates are signed by `metaca` and are bound to
the domain `localhost`.

## Re-generating the keys and certificates

The keys and certificates can be re-generated using the `generate-certs.sh`
script. The script needs `openssl` to be available.
