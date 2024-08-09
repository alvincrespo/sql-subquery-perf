# Setup

## Table of Contents
- [Getting Started](#getting-started)
  - [Database + Database Client Setup](#database--database-client-setup)
    - [Pull MySQL Image](#pull-mysql-image)
    - [Start the MySQL Database Container](#start-the-mysql-database-container)
    - [Start the MySQL Client Container](#start-the-mysql-client-container)
  - [Running Migrations](#running-migrations)
    - [Create library database](#create-library-database)
    - [Create library_join database](#create-library_join-database)
  - [Seeding Data](#seeding-data)
    - [Populate library database](#populate-library-database)
    - [Populate library_join database](#populate-library_join-database)

## Getting Started

### Dababase + Databse Client Setup

#### Pull MySQL Image

```sh
docker pull mysql:8.4.1
```

#### Start the MySQL Database Container

```sh
docker run --name my-mysql-container -e MYSQL_ROOT_PASSWORD=my-secret-pw -p 3306:3306 --restart unless-stopped -d mysql:8.4.1
```

#### Start the MySQL Client Container

```sh
docker run -it --rm mysql:8.4.1 mysql -hhost.docker.internal -uroot -p
```

### Running Migrations

There are two databases to run.

#### Create library database

```sh
docker cp migration.sql my-mysql-container:/migration.sql && docker exec -i my-mysql-container sh -c 'exec mysql -uroot -p"my-secret-pw" -e "source /migration.sql"'
```

#### Create library_join database

```sh
docker cp migration.sql my-mysql-container:/migration_join.sql && docker exec -i my-mysql-container sh -c 'exec mysql -uroot -p"my-secret-pw" -e "source /migration_join.sql"'
```

### Seeding Data

#### Populate library database
```sh
python script.py
```

#### Populate library_join database

```sh
python script_join.py
```

Congrats! You're all set up to use the query provided in the runner SQL files.
