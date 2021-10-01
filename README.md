# Metabase QA

This repository contains:

- Docker images with pre-populated data for integration testing

## Database Configurations

As part of standard QA process, we test different types of database setups:

- Single schema, single user access
- Multi schema, single user access
- Multi schema, multi user access

What this looks like in practice, is we have the following configurations:

- Metabase Sample Database with a single `metabase` user
- Metabase Sample Database + second schema with other random sample data
- Custom sample data that may or may not be database dependent
    - e.g. Postgres JSON types

## Using in Testing

Use Docker images of the form: `metabase/qa-databases:{DATABASE}-{QA_TYPE}-{VERSION}`

Currently the only supported databases are `mongo`, `postgres` and `mysql` and the only supported "QA type" is `sample`.

Supported database versions have their own Dockerfile in each directory.

We use a standard set of database names and users for our sample images:
- Database name: `sample`
- Username: `metabase`
- Password: `metasample123`

Listed below are the examples for running each of the supported databases in Docker.

#### Mongo 4
```shell
docker run --rm -p 27017:27017 --name meta-mongo4-sample metabase/qa-databases:mongo-sample-4.0
```

#### PostgreSQL 12
```shell
docker run --rm -p 5432:5432 --name meta-postgres12-sample metabase/qa-databases:postgres-sample-12
```

#### MySQL 8
```shell
docker run --rm -p 3306:3306 --name meta-mysql8-sample metabase/qa-databases:mysql-sample-8
```

### Supported Databases and Versions

These images are currently pushed to the public [metabase/qa-databases](https://hub.docker.com/r/metabase/qa-databases/tags) repository:

- `metabase/qa-databases:mongo-sample-4.0`
- `metabase/qa-databases:mysql-sample-5.7`
- `metabase/qa-databases:mysql-sample-8`
- `metabase/qa-databases:postgres-sample-11`
- `metabase/qa-databases:postgres-sample-12`

## Building

Building is manual for now until we support more databases.

### Sample Data

For Postgres, `sample_data.sql.gz` contains the Metabase Sample Database.
For Mongo, we extract the sample data from Postgres into files that are then loaded with `mongoimport`.

### Building/Updating Images

To build either the `mongo` or `postgres` images, change into the respective directory and execute the `build.sh` script.

```shell
cd dbs/postgres
./build.sh
```

**WARNING**: This currently also tries to push the image to Docker Hub, so if you don't have access that part will fail. 

If the Sample Database has changed in Postgres, you can run `./update_data.sh` in `dbs/mongo` to update the data files.

## References

- [Saving a Postgres Database in a Docker Image](https://nickjanetakis.com/blog/docker-tip-79-saving-a-postgres-database-in-a-docker-image)
- [eksctl](https://github.com/weaveworks/eksctl/blob/master/Makefile.docker) has a good example of committing an intermediate image.
- A [couple](https://github.com/mvanholsteijn/docker-makefile/blob/master/Makefile) [other](https://github.com/philpep/dockerfiles/blob/master/Makefile) good Docker/Makefile tooling examples
