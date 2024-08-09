# sql-subquery-perf

SQL performance monitoring for conditional subquery v. inner join sub query v. exists sub query

## Setup + Installation

```sh
./bin/setup
```

Run the above script and it will automate the setup installation. If you prefer
to know the magic sauce, you can check out the [setup guide here](./SETUP.md).

A successful script run will look like this:

```sh
./bin/setup
Installing MySQL
8.4.1: Pulling from library/mysql
c72f53f7235b: Pull complete
c7e4ed755af2: Pull complete
6c8c802f90bc: Pull complete
eecc55f854cd: Pull complete
cc8dabc09813: Pull complete
9aac7d685a2a: Pull complete
a41e3581bc15: Pull complete
575080e22a6f: Pull complete
a4d1cfd20590: Pull complete
8402c954594c: Pull complete
Digest: sha256:a7dc4a4e07a9c5d53c0cf36b5b4e8a1b3bb677cb0d544256a0581114a93ddf0f
Status: Downloaded newer image for mysql:8.4.1
docker.io/library/mysql:8.4.1

What's next:
    View a summary of image vulnerabilities and recommendations → docker scout quickview mysql:8.4.1
MySQL installed.

9fcb16fa38f6b6c95869d67c7a8ea7c37f56ff9cb78c7e831b51164b1a14625d
Waiting for my-mysql-container to start...
my-mysql-container started.

Running library database migration.
Successfully copied 5.63kB to my-mysql-container:/migration.sql
mysql: [Warning] Using a password on the command line interface can be insecure.
Library database migrated.

Running library (join) database migration.
Successfully copied 5.63kB to my-mysql-container:/migration_join.sql
mysql: [Warning] Using a password on the command line interface can be insecure.
Table   Op      Msg_type        Msg_text
library_join.authors    analyze status  OK
Table   Op      Msg_type        Msg_text
library_join.books      analyze status  OK
Library (join) database migrated.

Seeding library database.
Inserted 1000 authors and 1000000 books.
Library database seeded.

Seeding library (join) database.
Inserted 1000 authors and 1000000 books.
Library (join) database seeded.
```
