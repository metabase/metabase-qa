# Metabase Util Server

A generic HTTP and SMTP server that can be used in test pipelines.

## Usage

- Docker build

```shell
docker build -t metabase-qa/metabase-util .
```

- Run and expose HTTP and SMTP ports

```shell
docker run --rm -p 8080:8080 -p 2525:2525 --name metabase-util metabase-qa/metabase-util
```

Specify `-e HTTP_PORT` or `-e SMTP_PORT` to change the port that either server runs on.

## Mail server

By default, an email server with username `admin`/`admin` is running on port `2525`.

When you send an email to the server, it saves the basic fields (subject/from/to/body) to a markdown file.

The file is created using a basic counter that increments each time you send an email, so the first file is named `1.md` and so on.

Browse to http://localhost:8080/emails to see a list of emails that have been received.

Browse to http://localhost:8080/emails/1 (replace `1` with the counter ID) to see a specific email.

## Web server

By default, an express.js web server is running on port `8080`.

It does do much expose some local files at http://localhost:8080/