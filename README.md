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

Currently the only supported databases are `mongo` and `postgres` and the only supported "QA type" is `sample`.

Supported database versions have their own Dockerfile in each directory.

As an example, the command below will run a pre-populated Mongo 4.0 database.

```shell
docker run --rm -p 27017:27017 --name meta-mongo-sample metabase/qa-databases:mongo-sample-4.0
```

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
