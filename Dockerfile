FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive
ENV PG_VERSION=10
ENV PGIS_VERSION=2.5

WORKDIR /app

COPY ./oracle .

# Install essential packages
RUN apt-get update \
    && apt-get -y install curl gpg unzip build-essential git wget libaio-dev libaio1 alien

# Add PostgreSQL repository
RUN echo "deb http://apt.postgresql.org/pub/repos/apt focal-pgdg main" > /etc/apt/sources.list.d/pgdg.list && wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -

# Installation of PostgreSQL and PostGIS
RUN apt-get update \
    && apt-get -y install postgresql-$PG_VERSION postgresql-server-dev-$PG_VERSION postgresql-$PG_VERSION-postgis-$PGIS_VERSION \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Oracle client installation
RUN alien -vi *.rpm

# Oracle FDW Setup
RUN echo -e "/usr/lib/oracle/19.1/client64/lib/" >> /etc/ld.so.conf.d/oracle.conf \
    && ldconfig \
    && cd /usr/local/src/ && git clone https://github.com/laurenz/oracle_fdw.git && cd oracle_fdw && make && make install \
    && echo "shared_preload_libraries = 'oracle_fdw'" >> /etc/postgresql/$PG_VERSION/main/postgresql.conf

# Creating the scripts folder and copying the start_postgresql_service.sh script

RUN mkdir /scripts

COPY ./start_postgresql_service.sh /scripts/

RUN chmod +x /scripts/start_postgresql_service.sh

# Define the user to run the PostgreSQL service
USER postgres

ENTRYPOINT ["/bin/bash", "-c", "/scripts/start_postgresql_service.sh"]
