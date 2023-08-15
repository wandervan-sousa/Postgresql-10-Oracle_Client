# PostgreSQL - Docker with Docker Compose

This project provides a ready-to-use Docker environment with PostgreSQL using Docker Compose. It uses a Dockerfile file to create an image containing PostgreSQL installed and Oracle Foreign Data Wrapper (Oracle FDW) configured. In addition, the project includes PostgreSQL configuration files (postgresql.conf and pg_hba.conf) that can be customized according to your needs.

The central purpose of this installation is to allow the validation of the behavior of scripts, database routines and data loads with the version of PostgreSQL + PostGIS in production.

- **PostgreSQL Version**: PostgreSQL 10.23 (Ubuntu 10.23-1.pgdg20.04+1) on x86_64-pc-linux-gnu, compiled by gcc (Ubuntu 9.4.0-1ubuntu1~20.04.1) 9.4.0, 64-bit
- **PostGIS Version**: POSTGIS="2.5.5" [EXTENSION] PGSQL="100" GEOS="3.8.0-CAPI-1.13.1 " PROJ="Rel. 6.3.1, February 10th, 2020" GDAL="GDAL 3.0.4, released 2020/01/28" LIBXML="2.9.10" LIBJSON="0.13.1" LIBPROTOBUF="1.3.3" RASTER

## Prerequisites

- Docker installed on the machine.
- Docker Compose installed on the machine.


## How to use


#### 1. Clone the repository:

Adding an SSH key to clone the repository has become essential as of August 13, 2021, due to the removal of support for password authentication.

```bash
git clone git@github.com:wandervan-sousa/Postgresql-10-Oracle_Client.git
cd Postgresql-10-Oracle_Client/
```

#### 2. Customize the PostgreSQL configuration:

Edit the "postgresql.conf" and "pg_hba.conf" files inside the confs folder to adjust the PostgreSQL settings as per your needs.

#### 3. Start the PostgreSQL environment using Docker Compose:

First, let's build the image:

```bash
docker-compose build
```

After this step, let's start Docker:

```bash
docker-compose up -d
```

List the containers:

```bash
docker ps
```

Just enter the container:

```bash
docker exec -it "nome do container" bash
```

Now inside the container you can connect to the database:

```bash
psql
```

Remembering that the password is defined in docker-compose.yml

Inside the bank just create the extensions:

```sql
CREATE EXTENSION postgis;
```

```sql
CREATE EXTENSION oracle_fdw;
```

If you want to stop the Environment without dropping the container:

CTRL + d

To drop the container and remove the volume:

```bash
docker-compose down -v
```


## Comments
Make sure you have the required files for Oracle FDW in your oracle folder before running docker-compose.

These files can be purchased from: https://www.oracle.com/br/database/technologies/instant-client/linux-x86-64-downloads.html 

It is necessary to log in and download the instant client according to the desired version.

These files are required for installing the Oracle Instant Client.

The start_postgresql_service.sh file is responsible for starting PostgreSQL and performing some configurations. It also keeps the container alive to allow interaction with PostgreSQL.


## Contributing
Feel free to contribute improvements, bug fixes or add new features to the project. Just open a pull request!
