#!/usr/bin/env bash

sudo sh -c 'echo "deb https://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
sudo apt-get update
sudo apt-get -y install postgresql
sudo apt install libpq-dev

sudo -u postgres createuser -s -i -d -r -l -w $USER
sudo -u postgres psql -c "ALTER ROLE $USER WITH PASSWORD 'postgres';"

sudo apt install postgresql-14-postgis-3

sudo apt-get install redis
