# SSL extension for the Oracle image

The whole setup was created following
https://www.oracle.com/docs/tech/wp-oracle-jdbc-thin-ssl.pdf.

## The metabase user

This image contains the user `metabase` identified as `CN=metabase,C=US`
by its SSL certificate. The user was granted privileges quite generously,
the goal being to make it usable in the test as simply as possible. (See
`user.sql`.)

## Certificates

The parts used by
the Oracle server were generated in the container with the `orapki` tool. The
parts used by Metabase (the client) were generated with Java's `keytool`.

### Server folders

#### `ca`

- `ewallet.p12` is a PKCS12 Oracle keystore containing the keys and the self-
  signed certificate.
- `b64certificate.txt` is the self-signed certificate ready to be imported into
  other keystores.

### `server`

- `ewallet.p12` is a PKCS12 Oracle keystore containing the server's keys and the
  certificate signed by the CA.
- `cwallet.sso` is an obfuscated copy of `ewallet.p12` used for auto-login.
- `cert.txt` is the signed certificate.
- `csr.txt` is the certificate signing request.

### Client folders

#### `client_p12`

- `client.p12` is a PKCS12 format keystore containing the private and public
  keys of `CN=metabase,C=US`, as well as signed certificate from the CA contained
  in the docker image.
- `cert.txt` is the signed certificate.
- `csr.txt` is the certificate signing request.

#### `truststore`

`truststore.p12` is a PKCS12 format truststore containing the self-signed
certificate of the CA contained in the docker image.
